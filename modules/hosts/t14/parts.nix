{
  config = {
    t14 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
      username = "csman";
      hostname = "t14";
      pkgs-unstable = import nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
      };
      };
      modules = [
      home-manager.nixosModules.home-manager
      {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
          username = "csman";
          };
      }
      ];
    };
  };
}