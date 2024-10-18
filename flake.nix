{
  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-24.05"; };
    # nur = { url = "github:nix-community/NUR"; };
  };

  outputs = { self, nixpkgs, nixos-hardware }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [ 
        nixos-hardware.nixosModules.lenovo-thinkpad-x220
        ./hardware-configuration.nix
        ./configuration.nix 
      ];
    };
  };
}
