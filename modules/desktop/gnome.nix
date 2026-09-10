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
    gnomeExtensions.blur-my-shell
    gnomeExtensions.user-themes
    gnomeExtensions.weather-oclock
    gnomeExtensions.pop-shell
    
    # Theme
    flat-remix-gnome
    flat-remix-icon-theme
    flat-remix-gtk
    paper-icon-theme
    (marble-shell-theme.override {
      colors = ["yellow"];
      additionalInstallationTweaks = [ "-O" ];
    })
    catppuccin-gtk
  ];

    # Remove unwanted GNOME applications (games, etc.)
  environment.gnome.excludePackages = with pkgs; [
    gnome-music
    gnome-logs
    epiphany  # GNOME web browser
    geary     # Email client
    totem     # Video player
    yelp      # Help viewer
    # GNOME Games
    atomix
    hitori
    iagno
    gnome-2048
    tali
    gnome-mahjongg
    gnome-mines
    gnome-nibbles
    gnome-robots
    gnome-sudoku
    gnome-taquin
    gnome-tetravex
    quadrapassel
    swell-foop
    lightsoff
  ];
  
  home-manager.users.${username} = { pkgs, ... }: {
    # Fonts configuration
    home.packages = with pkgs; [
      # Nerd Fonts
      jetbrains-mono
    ];

    # Nautilus (Files) bookmarks
    home.file.".config/gtk-3.0/bookmarks".text = ''
      file:///mnt/csman csman
      file:///home/${username}/Downloads Downloads
    '';

    # GNOME dconf settings
    dconf.settings = {
      # Desktop interface settings
      "org/gnome/desktop/interface" = {
        clock-show-date = true;
        clock-format = "24h";
        clock-show-seconds = true;
        show-battery-percentage = true;
        gtk-theme = "Flat-Remix";
        icon-theme = "Flat-Remix-Teal-Dark";
        cursor = "Paper";
        color-scheme = "prefer-dark";
      };

      # Region & Language - Use French formats
      "org/gnome/system/locale" = {
        region = "fr_FR.UTF-8";
      };

      # Window manager preferences
      "org/gnome/desktop/wm/preferences" = {
        theme = "Adwaita-light";
      };

      # GNOME Shell configuration
      "org/gnome/shell" = {
        enabled-extensions = [
          "horizontal-workspaces@gnome-shell-extensions.gcampax.github.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "Vitals@CoreCoding.com"
          "blur-my-shell@aunetx"
          "orge@jmmaranan.com"
          "quick-settings-tweaks@qwreey"
          "weatheroclock@CleoMenezesJr.github.io"
          "pop-shell@system76.com"
          "places-menu@gnome-shell-extensions.gcampax.github.com"
          "apps-menu@gnome-shell-extensions.gcampax.github.com"
        ];
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Nautilus.desktop"
        ];
      };

      # User theme extension settings
      "org/gnome/shell/extensions/user-theme" = {
        name = "Flat-Remix-Dark-fullPanel";
      };

      # GNOME Terminal settings
      "org/gnome/terminal/legacy" = {
        menu-accelerator-enabled = true;
      };

      # Nautilus (Files) preferences
      "org/gnome/nautilus/preferences" = {
        search-filter-time-type = "last_modified";
        default-folder-viewer = "list-view";
      };

      # Custom keyboard shortcuts
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Launch Terminator";
        command = "terminator";
        binding = "<Super>t";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        name = "Launch Firefox";
        command = "firefox";
        binding = "<Super>f";
      };

    };
  };
}
