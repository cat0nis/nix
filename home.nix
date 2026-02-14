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
    ];

    programs.git = {
      enable = true;
      settings.user.name="cat0nis";
      settings.user.email = "inrymail@gmail.com";
    };

    catppuccin = {
        enable = true;
        flavor = "mocha";
        cursors.enable = true;
    };
 


    home.stateVersion = "25.11"; # no touchy
}