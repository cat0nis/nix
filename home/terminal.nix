{ config, pkgs, ...}:

{

  home.packages = [
    pkgs.zoxide
  ];

  programs.kitty = {
      enable = true;
      settings =  {
        window_padding_width = 1;
      };
    };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  
    shellAliases = {
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

    initContent = ''
      eval $(ssh-agent) 
      ssh-add ~/dev/sshkeys/github_key
      bindkey "^H" backward-delete-word
      eval "$(starship init zsh)"
      eval "$(zoxide init --cmd cd zsh)"
      clear
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"         # also requires `programs.git.enable = true;`
      ];
      theme = "robbyrussell";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
       add_newline = true;
       command_timeout = 1300;
       scan_timeout = 50;
       #format = "$all$nix_shell$nodejs$lua$golang$rust$php$git_branch$git_commit$git_state$git_status\n$username$hostname$directory";
       #character = {
       #  success_symbol = "[](bold green) ";
       #  error_symbol = "[✗](bold red) ";
       #};
     };
  };

}