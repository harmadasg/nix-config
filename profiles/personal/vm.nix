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
{ config, inputs, pkgs, ... }:
{
  imports = [
    inputs.nixarr.nixosModules.default
  ];

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096;
      diskSize = 4096;
      cores = 4;
      # sharedDirectories = ...
    };
  };

  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    initialPassword = "test";
  };

  environment.systemPackages = with pkgs; [
    cowsay
    lolcat
  ];

  nixarr = {
    enable = true;
    jellyfin = { 
      enable = true;
      openFirewall = true;
    };
  };

  system.stateVersion = "24.05";
}
