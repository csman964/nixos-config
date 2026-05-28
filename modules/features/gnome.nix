{ config, pkgs, username, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-boxes
    gnome-extension-manager  
    gnomeExtensions.window-list
    gnomeExtensions.applications-menu
    gnomeExtensions.places-status-indicator 
    #gnomeExtensions.system-monitor-next
    gnomeExtensions.vitals
    gnomeExtensions.dock-from-dash
    gnomeExtensions.blur-my-shell
    gnomeExtensions.user-themes
    gnomeExtensions.weather-oclock
    gnomeExtensions.pop-shell
  ];

}
