{ config, pkgs, ... }:

let
  vscodium = "com.vscodium.codium";
in
{
  services.flatpak.packages = [
    vscodium
  ];
  /*
    Installed extensions (until I don't find a better way)
      - jnoortheen.nix-ide
  */
  home.file = {
    # User settings
    ".var/app/${vscodium}/config/VSCodium/User/settings.json".text = ''
      {
        "files.autoSave": "afterDelay"
      }
    '';
  };

}
