{ config, pkgs, username, lib, ... }:

{

    # Enable and configure libvirtd for virt-manager
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
        package = pkgs.qemu_kvm;
        # OVMF images are now available by default, no need to configure
        };
    };

    # Enable Podman (container runtime)
    virtualisation.podman = {
        enable = true;
        dockerCompat = true;  # Create docker alias
        defaultNetwork.settings.dns_enabled = true;
    };

    # VirtualBox guest additions (only enable on VMs, not physical machines)
    # Set virtualisation.virtualbox.guest.enable = true in host config if needed

    # Enable automatic system updates
    # You can check last run by running this command: journalctl -u nixos-upgrade.service -r
    # In case of this error: error: opening Git repository "/home/csman/nixos-config"
    # You should create the file /root/.gitignore with this information
    # [safe]
    #   directory = /home/csman/nixos-config

    system.autoUpgrade = {
        enable = true;
        flake = "/home/${username}/nixos-config";
        flags = [
        "--print-build-logs"
        "--commit-lock-file"
        ];
        dates = "daily";
        randomizedDelaySec = "45min";
        allowReboot = false;
    };

    # Garbage collector
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 15d";
    };

    # Keep only the last 5 generations
    boot.loader.systemd-boot.configurationLimit = 5;
}