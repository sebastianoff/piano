{
  description = "piano";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, zen-browser, ... } @ inputs:
  let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    overlays.default = final: prev: {
      unstable = import nixpkgs-unstable {
        system = prev.system;
        config = prev.config;
      };
    };

    formatter = forAllSystems (system:
      let pkgs = import nixpkgs { inherit system; }; in pkgs.alejandra
    );

    nixosConfigurations.piano = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit self; };
      modules = [
        { nixpkgs.overlays = [ self.overlays.default ]; }

        ./modules/common/base.nix
        ./modules/common/users.nix
        ./modules/desktop/plasma.nix
        ./hosts/piano/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.cat = import ./home/cat/home.nix;
   	      home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };
        }
      ];
    };
  };
}
