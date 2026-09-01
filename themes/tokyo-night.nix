{
  config,
  lib,
  pkgs,
  ...
}: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    image = ./../user/resources/tokyo-night.jpg;
    polarity = "dark";

  };
}
