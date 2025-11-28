{
  systemSettings = {
    system = "x86_64-linux"; # system arch
    hostname = "nixos"; # hostname
    profile = "personal"; # select a profile defined from my profiles directory
    timezone = "Europe/Budapest"; # select timezone
    locale = "en_US.UTF-8"; # select locale
    bootMode = "uefi"; # uefi or bios
    bootMountPath = "/boot"; # mount path for efi boot partition; only used for uefi boot mode
    grubDevice = ""; # device identifier for grub; only used for legacy (bios) boot mode
    gpuType = "amd"; # amd, intel or nvidia; only makes some slight mods for amd at the moment
    monitors = [
      {
        name = "secondary";
        output = "DP-1";
        width = "2560";
        height = "1440";
        refresh = "144";
        x = "0";
        y = "0";
        scale = "1.0";
        enabled = true;
      }
      {
        name = "main";
        output = "DP-4";
        width = "3840";
        height = "2160";
        refresh = "60";
        x = "2560";
        y = "0";
        scale = "1.5";
        enabled = true;
      }
      {
        name = "dummy";
        output = "HDMI-A-1";
        enabled = false;
      }
    ];
  };

  userSettings = rec {
    username = "gege"; # username
    name = "Gergely"; # name/identifier
    email = "harmadasg@gmail.com"; # email (used for certain configurations)
    dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
    theme = "catppuccin-mocha"; # selcted theme from my themes directory (./themes/)
    wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
    # window manager type (hyprland or x11) translator
    wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
    browser = "firefox"; # Preferred browser
    shell = "zsh";
    term = "kitty"; # Default terminal command;
    font = "Caskaydia Cove Nerd Font"; # Selected font
    editor = "nvim"; # Default editor;
  };
}
