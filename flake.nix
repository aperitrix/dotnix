{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";

    lazygit.url = "github:jesseduffield/lazygit";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixvim,
      lazygit,
      niri,
      noctalia,
      catppuccin,
      ...
    }:
    let
      user = "aperitrix";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          lazygit.overlays.default
        ];
      };
      lib = nixpkgs.lib;
    in
    {
      homeManagerModules.common = ./home-manager;

      nixosConfigurations = {
        desktop = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs user; };
          modules = [
            ./hosts/desktop

            niri.nixosModules.niri
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs user catppuccin; };
                users.${user} = {
                  imports = [
                    self.homeManagerModules.common
                    nixvim.homeModules.nixvim
                    catppuccin.homeModules.default
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
