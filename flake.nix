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
    };

    outputs = {self, nixpkgs, home-manager, catppuccin,  ...}@inputs: {
        nixosConfigurations.emetselch = nixpkgs.lib.nixosSystem {
            modules = [
                ./configuration.nix
                catppuccin.nixosModules.catppuccin


                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
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