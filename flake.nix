{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nur = { url = "github:nix-community/NUR"; };
  };

  outputs = { self, nixpkgs, nur }: {
    nixosConfigurations.joes-desktop = nixpkgs.lib.nixosSystem {
      modules = [ 
        ./hardware-configuration.nix
        ./configuration.nix 
      ];
    };
  };
}
