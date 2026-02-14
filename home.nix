{ config, pkgs, ...}:

{
    home.username = "inryatt";
    home.homeDirectory = "/home/inryatt";

    home.packages = with pkgs; [
        neofetch
        vscode
        neovim
        thunderbird
        kdePackages.kate
        discord
        spotify
        steam
        steamcmd
        steam-run
        starship
        (python3.withPackages (
          p: with p; [
            pwntools
          ]
        ))
        ghidra
        screen
        imhex
        lsd


        # hyprland
        kitty
        waybar
        fuzzel
        mako
        rofi
        swaylock
        #alsamixer
        #cpupower
        #fcitx5

    ];

    programs.git = {
      enable = true;
      settings.user.name="cat0nis";
      settings.user.email = "inrymail@gmail.com";
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    
      shellAliases = {
        ls = "ls -la";
        edit = "sudo -e";
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

    };
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/inryatt/dev/dotfiles";
    };

    catppuccin = {
        enable = true;
        flavor = "mocha";
    };
 
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.enable = false;
    };

    programs.obsidian = {
      enable = true;
      defaultSettings.communityPlugins = ["obsidian-git"];
    };

    home.stateVersion = "25.11"; # no touchy
}