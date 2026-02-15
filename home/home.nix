{ config, pkgs, ...}:

{
    imports = [
      ./terminal.nix
    ];
    
    home.username = "inryatt";
    home.homeDirectory = "/home/inryatt";


    home.file.".config/hypr/hyprland.conf".source = ../hyprland.conf;
    
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
      enable = false;
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