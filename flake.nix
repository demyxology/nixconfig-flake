{

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nur = { url = "github:nix-community/NUR"; };
  };

  outputs = { self, nixpkgs, nur, nixos-hardware }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [ 
        nixos-hardware.lenovo-thinkpad-x220
        ./hardware-configuration.nix
        ./configuration.nix 
      ];
    };
  };
}
