# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./../../system/hardware-configuration.nix
    ./../../system/wm/sddm.nix
    ./../../system/hardware/boot.nix
    ./../../system/hardware/networking.nix
    ./../../system/hardware/graphics.nix
    ./../../system/hardware/sound.nix
    ./../../system/hardware/bluetooth.nix
    ./../../system/hardware/controller.nix
    ./../../system/misc/i18n.nix
    ./../../system/misc/console.nix
    ./../../system/security/sshd.nix
    ./../../system/app/flatpak.nix
    # ./../../system/wm//plasma.nix
    ./../../system/wm/hyprland.nix
  ];

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      gege = {
        isNormalUser = true;
        initialPassword = "pw123";
        extraGroups = ["networkmanager" "input" "wheel"]; # Enable ‘sudo’ for the user.
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
