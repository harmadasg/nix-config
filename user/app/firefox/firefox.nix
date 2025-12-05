{
  config,
  pkgs,
  inputs,
  userSettings,
  ...
}: {
  programs.firefox = {
    enable = true;
    policies = {
      DisplayBookmarksToolbar = "always";
    };
    profiles.${userSettings.username} = {
      settings = {
        "browser.startup.page" = 3;
      };
      bookmarks = ./bookmarks/bookmark.nix;
      search.engines = {
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@np"];
        };
        "PCGamingWiki" = {
          urls = [
            {
              template = "https://www.pcgamingwiki.com/w/index.php";
              params = [
                {
                  name = "search";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = "https://static.pcgamingwiki.com/favicons/pcgamingwiki.png";
          definedAliases = ["@pc"];
        };
      };
      search.force = true;
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        sponsorblock
        frankerfacez
        i-dont-care-about-cookies
      ];
    };
  };
  stylix.targets.firefox.profileNames = ["${userSettings.username}"];
}
