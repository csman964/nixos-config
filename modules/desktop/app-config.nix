{ config, pkgs, username, ... }:
home-manager.users.${username} = { pkgs, ... }: {
  # Terminator default
  programs.terminator.config = {
    profiles.default = {
      scrollback_lines = 5000;
      font = "Space Mono Regular 12";
    };
  };

};