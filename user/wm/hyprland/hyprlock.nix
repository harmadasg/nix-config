{ pkgs, inputs, config, userSettings, ... }:

with config.lib.stylix.colors;
{
  programs.hyprlock = {
    enable = true;
    settings = {
      "$accent" = "rgb(${base0E})";
      "$accentAlpha" = base0E;
      "$surface" = "rgb(${base02})";
      "$base" = "rgb(${base00})";
      "$text" = "rgb(${base05})";
      "$textAlpha" = base05;
      "$red" = "rgb(${base08})";
      "$yellow" = "rgb(${base0A})";
      "$font" = config.stylix.fonts.monospace.name;

      # GENERAL
      general = {
          disable_loading_bar = true;
          hide_cursor = true;
      };

      # BACKGROUND
      background = {
          monitor = "";
          path = "${./../../resources/${userSettings.theme}.jpg}";
          blur_passes = 2;
          # stylix takes care, should rework hyprlock config anyway
          # color = "$base";
      };

      label = [
        {
          # TIME
          monitor = "DP-4";
          text = "cmd[update:30000] echo \"$(date +\"%R\")\"";
          color = "$text";
          font_size = 90;
          font_family = "$font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        {
          # DATE 
          monitor = "DP-4";
          text = "cmd[update:43200000] echo \"$(date +\"%A, %d %B %Y\")\"";
          color = "$text";
          font_size = 25;
          font_family = "$font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];

      # USER AVATAR
      image = {
          monitor = "DP-4";
          path = "${./../../resources/face}";
          size = 96;
          border_color = "$accent";

          position = "0, 75";
          halign = "center";
          valign = "center";
      };

      # INPUT FIELD
      input-field = {
        monitor = "DP-4";
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2; # Scale of dots' absolute size, -1.0 - 1.0
        dots_center = true;
        fade_on_empty = false;
        placeholder_text = "<span foreground=\"##$textAlpha\"><i>󰌾 Logged in as </i><span foreground=\"##$accentAlpha\">$USER</span></span>"; # Text rendered in the input box when it's empty.
        hide_input = false;
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
        capslock_color = "$yellow";
        position = "0, -35";
        halign = "center";
        valign = "center";
      };
    };

  };  
}
