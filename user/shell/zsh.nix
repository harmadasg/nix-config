{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    initContent = let
      zshConfigEarlyInit = lib.mkOrder 500 ''
        if [[ $(tput lines) -gt 50 ]]; then
          fastfetch
        fi 
      '';
      zshConfig = lib.mkOrder 1000 ''
        # put stuff here
      '';
    in
      lib.mkMerge [ zshConfigEarlyInit zshConfig ];

    plugins = [
      {
        name = "powerlevel10k-config";
        src = ./.;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "colored-man-pages"
      ];
    };
  };
}
