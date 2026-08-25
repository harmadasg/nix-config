{ config, inputs, pkgs, ... }:
{
  # Temp: everything in this file exists only while the mediaserver runs in a VM
  # (see profiles/personal/vm.nix). Remove once the mediaserver moves back to
  # the host.

  # /dev/sdc1 is passed directly into the VM; the host must NOT mount it
  # concurrently, so no fileSystems entry here.

  networking.firewall.allowedTCPPorts = [ 8096 ]; # Jellyfin default port

  # QEMU (running as gege) needs r/w on the raw block device to attach it to
  # the VM. "disk" is broad; acceptable since gege already has "wheel".
  users.users.gege.extraGroups = [ "disk" ];
}

