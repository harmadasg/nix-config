{ pkgs, inputs, ... }:

{
  home.packages = [ pkgs.oranchelo-icon-theme ];

  programs.rofi = {
    enable = true;
    cycle = true;
    extraConfig = {
      modi = "drun,window,combi";
      icon-theme = "Oranchelo";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
      display-combi = " 🖥  All ";
      display-drun = " 🏃  Run ";
      display-window = " 🪟  Window";
      sidebar-mode = true;
    };
  };

}
