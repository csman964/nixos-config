{ config, pkgs, username, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager  
    gnomeExtensions.window-list
    gnomeExtensions.applications-menu
    gnomeExtensions.places-status-indicator 
    gnomeExtensions.system-monitor-next
    gnomeExtensions.dock-from-dash
  ];

}
