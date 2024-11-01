{ config, lib, pkgs, ...  }:

{
  options = {
    themes.catppuccin-mocha.enable = lib.mkEnableOption "Catppuccin Mocha";
  };

  config = lib.mkIf config.themes.catppuccin-mocha.enable {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      image = ./catppuccin-mocha.jpg;
      # image = pkgs.fetchurl {
      #   url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/landscapes/shaded_landscape.png";
      #   sha256 = "1199a43751f1234d3fb92ecf614fbf34de2c07334d3fdd355891044f51bddada";
      # };
      polarity = "dark";
    };
  };
}
