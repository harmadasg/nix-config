{ pkgs, inputs, ... }:

{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  programs.plasma = {
    enable = true;
    # overrideConfig = true; to discard changes made outside plasma-manager

    #
    # Some high-level settings:
    #
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
    };

    input = {
      mice = [
        {
          name = "Logitech G Pro ";
          vendorId = "046d";
          productId = "4079";
          accelerationProfile = "none";
        }
        {
          name = "Logitech G Pro Wireless Gaming Mouse";
          vendorId = "046d";
          productId = "c088";
          accelerationProfile = "none";
        }
      ];
    };
  };
}
