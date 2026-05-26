{ config, pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.jetbrains-mono

    # Shell tools
    tmux
    fastfetch

    # Network tools
    nmap
    ipcalc

    # System utilities
    tree

    # Search and text processing

    # Development tools
    git-crypt

    # Programming languages
    python3
    python3Packages.pip

    # Container tools
    podman
    podman-compose

    # Virtualization
    virt-manager
    vagrant

    # Multimedia
    vlc
    deezer-enhanced

    # Terminal emulator
    kitty


    # Task management
    taskwarrior2

    # Other utilities
    cups
    python3Packages.virtualenv
    obsidian

  ];

}