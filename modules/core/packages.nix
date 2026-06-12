{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # System-wide packages (minimal set for root and system operations)
  environment.systemPackages = with pkgs; [
    # Minimal editor for root emergencies
    vim

    # Basic system utilities
    curl
    wget
    rsync
    wirelesstools

    # Network diagnostics (system-level)
    tcpdump
    dnsutils
    traceroute
    net-tools

    # System monitoring
    btop
    htop
    strace

    # Security (system-level)
    gnupg
    clamav
    apparmor-profiles
    apparmor-utils
    openssl
    age
    keepassxc

    # Build essentials (system-level)
    git
    gnumake

  ];

  # Allow program to run in ~/.local/bin
  environment.localBinInPath = true;

  # Allow script to find in /bin/
  services.envfs.enable = true;

  # Enable GPG agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable direnv
  programs.direnv.enable = true;

  # Firefox
  programs.firefox.enable = true;

  # Configure Git globally
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "csman964";
        email = "mdi2611@hotmail.com";
        #signingkey = "~/.ssh/id_ed25519.pub";
      };
      pull.rebase = true;
      fetch.prune = true;
    };
  };

}