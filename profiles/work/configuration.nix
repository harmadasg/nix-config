{pkgs, self, userSettings, ...}: let
  homeDir = "/Users/${userSettings.username}";
in {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    tree
  ];

  # Auto upgrade nix package
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;
  
  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;
    primaryUser = "${userSettings.username}";
    defaults.dock.autohide = true;
  };

  # https://discourse.nixos.org/t/automatically-launching-macos-applications-on-login/19823
  system.activationScripts.postActivation.text = ''
    osascript -e 'tell application "System Events" to make login item at end with properties {path:"${homeDir}/Applications/Home Manager Trampolines/Maccy.app", hidden:false}' 2>/dev/null || true
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
