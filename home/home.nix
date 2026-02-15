{ config, pkgs, ...}:

{
    imports = [
      ./terminal.nix
    ];
    
    home.username = "inryatt";
    home.homeDirectory = "/home/inryatt";


    
    home.packages = with pkgs; [
        neofetch
        vscode
        neovim
        thunderbird
        kdePackages.kate
        discord
        telegram-desktop
        spotify
        steam
        steamcmd
        steam-run
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
 

    programs.obsidian = {
      enable = true;
      defaultSettings.communityPlugins = ["obsidian-git"];
    };

    home.stateVersion = "25.11"; # no touchy
}