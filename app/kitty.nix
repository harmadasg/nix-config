{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    shellIntegration.enableZshIntegration = true;

    font = {
      name = "MesloLGS NF";
    };

    settings = {
      background_opacity = "0.90";
      window_margin_width = 7;
      window_border_width = "2pt";
      single_window_margin_width = 0;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_activity_symbol = "*";
    };
  };
  
}
