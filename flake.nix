{
    description = "My dotfiles uwu";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        catppuccin = {
            type = "github";
            owner = "catppuccin";
            repo = "nix";
        };

        hyprland = {
            type = "github";
            owner = "hyprwm";
            repo = "Hyprland";
        };
    };

    outputs = {self, nixpkgs, home-manager, catppuccin, hyprland, ...}@inputs: {
        nixosConfigurations.emetselch = nixpkgs.lib.nixosSystem {

            specialArgs = { inherit inputs; };

            modules = [
                ./configuration.nix
                catppuccin.nixosModules.catppuccin


                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        backupFileExtension = "backup";
                        users.inryatt = {
                            imports = [
                                ./home.nix
                                catppuccin.homeModules.catppuccin
                            ];
                        };
                    };
                }
            ];
        };
    };
}