{ userSettings, pkgs, config, ... }:

{
  home.packages = with pkgs; [
    fastfetch
    fd
    ripgrep
    eza
    bat
    lnav
    gh
  ];

  home.sessionVariables = {
    EDITOR = "${userSettings.editor}";
  };

  programs.${userSettings.shell} = {
    shellAliases = {
      ll = "ls -alF";
      ".." = "cd ..";
    };
  };
}
