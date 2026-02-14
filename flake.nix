{
    description = "My dotfiles uwu";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = {self, nixpkgs, ...}@inputs: {
        nixosConfigurations.emetselch = nixpkgs.lib.nixosSystem {
            modules = [
                ./configuration.nix
            ];
        };
    };
}