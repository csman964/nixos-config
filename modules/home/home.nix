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

    # Cloud
    pcloud

    # Search and text processing
    # yq
    # jq

    # Development tools
    vscode
    obsidian

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

    # Office Suite
    onlyoffice-desktopeditors

    # Terminal emulator
    kitty

    # Task management
    taskwarrior2

    # Other utilities
    cups
    python3Packages.virtualenv

  ];

}
