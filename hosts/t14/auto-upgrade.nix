system.autoUpgrade = {
  enable = true;
  flake = "/home/csman/nixos-config/home.nix";
  flags = [
    "--print-build-logs"
    "--commit-lock-file"  # If you want to automatically commit the updated flake.lock
  ];
  dates = "20:00";
  randomizedDelaySec = "45min";
};