# Based on:
# https://jeancharles.quillet.org/posts/2023-01-16-Basic-nix-vm-for-just-anything.html
# https://discourse.nixos.org/t/how-to-leverage-build-vm-and-virt-manager-for-an-easy-multi-vm-setup/61287
# https://www.reddit.com/r/NixOS/comments/1sj56w8/nixosrebuild_buildvm_appreciation_post_create/
# https://gist.github.com/FlakM/0535b8aa7efec56906c5ab5e32580adf
# https://nix.dev/tutorials/nixos/nixos-configuration-on-vm.html
# https://github.com/eh8/chenglab/blob/1305f8101a23bad0011d0c31a2d3804f29d0f826/services/nixarr.nix
#
# Build this VM with nix build  ./#nixosConfigurations.vm.config.system.build.vm
# Then run is with: ./result/bin/run-nixos-vm
# To be able to connect with ssh enable port forwarding with:
# QEMU_NET_OPTS="hostfwd=tcp::2222-:22" ./result/bin/run-nixos-vm
# Then connect with ssh -p 2222 guest@localhost
{ config, inputs, lib, pkgs, ... }:
let
  # Add a new *arr service here — everything else is derived automatically.
  arrServices = [
    { name = "radarr";   uid = 13002; }
    { name = "sonarr";   uid = 13001; }
    { name = "prowlarr"; uid = 13006; }
  ];

  mkArrService = svc: {
    virtualisation.vmVariant.virtualisation = {
      forwardPorts = [{
        from = "host";
        host.port = config.nixarr.${svc.name}.port;
        guest.port = config.nixarr.${svc.name}.port;
      }];
      fileSystems."${config.nixarr.${svc.name}.stateDir}" = {
        device  = "/mnt/disk1/config/${svc.name}-config";
        fsType  = "none";
        options = [ "bind" ];
        depends = [ "/mnt/disk1" ];
      };
    };
    nixarr.${svc.name}                 = { enable = true; openFirewall = true; };
    services.${svc.name}.settings.auth = { method = "External"; required = "DisabledForLocalAddresses"; };
    users.users.${svc.name}.uid        = lib.mkForce svc.uid;
  };
in
{
  imports = [ inputs.nixarr.nixosModules.default ];

  config = lib.mkMerge ([
    {
      virtualisation.vmVariant.virtualisation = {
        memorySize = 8192;
        diskSize = 4096;
        cores = 6;
        forwardPorts = [{
          from = "host";
          host.port = config.nixarr.jellyfin.port;
          guest.port = config.nixarr.jellyfin.port;
        }];
        # Pass the physical media disk (/dev/sdc1) into the VM as a virtio-blk device.
        qemu.drives = lib.mkAfter [{
          name = "media-disk";
          file = "/dev/disk/by-id/ata-ST4000DM004-2CV104_ZFN01ZVB-part1";
          driveExtraOpts = {
            format = "raw";
            cache  = "none"; # O_DIRECT; avoid double-buffering
          };
        }];
        # Mount the ext4 partition inside the guest and expose the
        # jellyfin/nixarr paths via bind mounts (preserves the on-disk layout).
        fileSystems = {
          "/mnt/disk1" = {
            device = "/dev/disk/by-uuid/1f54c94a-1864-49ca-9900-eefa5df97a01";
            fsType = "ext4";
            options = [ "noatime" ];
          };
          "${config.nixarr.jellyfin.stateDir}" = {
            device  = "/mnt/disk1/config/jellyfin-config";
            fsType  = "none";
            options = [ "bind" ];
            depends = [ "/mnt/disk1" ];
          };
          "${config.nixarr.mediaDir}" = {
            device  = "/mnt/disk1/data/media";
            fsType  = "none";
            options = [ "bind" ];
            depends = [ "/mnt/disk1" ];
          };
        };
      };

      users.users.alice = {
        isNormalUser    = true;
        extraGroups     = [ "wheel" ]; # Enable 'sudo' for the user.
        initialPassword = "test";
      };

      nixarr = {
        enable = true;
        jellyfin = { enable = true; openFirewall = true; };
      };

      services.jellyfin.configDir = lib.mkForce "${config.nixarr.jellyfin.stateDir}"; # compat with old linuxserver setup

      # Pin UIDs/GIDs to match the previous Docker-based deployment
      users = {
        users.jellyfin.uid = lib.mkForce 13013;
        groups.media.gid   = lib.mkForce 13000;
      };

      environment.systemPackages = with pkgs; [ jq ];

      system.stateVersion = "24.05";
    }
  ] ++ map mkArrService arrServices
  );
}
