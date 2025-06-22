{pkgs, ...}: {
  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libsecret
  ];

  programs.seahorse.enable = true;

  security.polkit.enable = true;

  # Not working due to https://github.com/NixOS/nixpkgs/issues/86884#issuecomment-1134787613
  # Time to switch to greetd?
  # security.pam.services.sddm.enableGnomeKeyring = true;
}
