{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";

    lazygit.url = "github:jesseduffield/lazygit";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixvim,
      lazygit,
      #niri,
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

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs user; };
                users.${user} = {
                  imports = [
                    self.homeManagerModules.common
                    nixvim.homeModules.nixvim
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
