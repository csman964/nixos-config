{ self, inputs, ... }: {

  flake.nixosModules.t14Configuration = { pkgs, lib, ... }: {
    # import any other modules from here
    imports = [
      self.nixosModules.myMachineHardware
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
    # ...
  };

}