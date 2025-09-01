{ config, pkgs, ... }:

let
  # Based on the SDDM Arch Wiki page
  input_options =
    "[Libinput][1133][16505][Logitech G Pro ]                             \\n" +
    "PointerAccelerationProfile=1                                         \\n" +
    "                                                                     \\n" +
    "[Libinput][1133][49288][Logitech G Pro Wireless Gaming Mouse]        \\n" +
    "PointerAccelerationProfile=1                                         \\n" +
    "                                                                     \\n" +
    "[Keyboard]                                                           \\n" +
    "NumLock=0"
  ;
in
{
  services.displayManager = {
    autoLogin = {
      user = "gege";
    };
    defaultSession = "hyprland";
    sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      wayland = {
        enable = true;
        # TODO move to a more lightweight DM like greetd or ly
        compositor = "kwin";
      }; 
      autoNumlock = true;
    };
  };

  # TODO Clean up and source this from a single location for both system and home config
  # TODO Do the same for the monitors
  systemd.tmpfiles.rules = [
    "f+ /var/lib/sddm/.config/kcminputrc 0600 sddm sddm - ${input_options}"
  ];
}
