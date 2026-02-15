{ config, pkgs, ...}:

{

programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    
      shellAliases = {
        edit = "sudo -e";
        grep = "grep --color=always";
        ls = "lsd -A1l";
        cat = "bat";
        x = "exit";
        clr = "clear";
        vim = "nvim";
        p3 = "python3";
        # bonzo ='~/ .config/bonzomatic/run.sh';
      };
    
      history.size = 10000;
      history.ignoreAllDups = true;
      history.path = "$HOME/.zsh_history";
      history.ignorePatterns = ["rm *" "pkill *" "cp *"];


      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"         # also requires `programs.git.enable = true;`
        ];
        theme = "robbyrussell";
  };
  
}