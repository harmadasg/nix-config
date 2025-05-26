{ config, pkgs, userSettings, ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    settings = {
      window_margin_width = 7;
      window_border_width = "2pt";
      single_window_margin_width = 0;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_activity_symbol = "*";
    };
  };
  
    programs.${userSettings.shell} = {
      shellAliases = {
        ssh = "kitty +kitten ssh";
      };
    };
  
}
