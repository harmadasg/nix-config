{ config, lib, pkgs, inputs, userSettings, ... }:

{

  home.packages = with pkgs; [
    libsForQt5.qt5ct
    qt6ct
  ];

  stylix = {

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  # not really working
  qt = {
    enable = true;
    style = {
      package = pkgs.adwaita-qt;
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:none";
      };
    };
  };

}
