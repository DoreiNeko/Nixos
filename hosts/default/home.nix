{ config, pkgs, ... }:
{
  imports = [
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dorei";
  home.homeDirectory = "/home/dorei";

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Sky-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "sky" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "mocha";
      };
    };

    cursorTheme = {
      name = "Catppuccin-Mocha-Sky-Cursors";
      package = pkgs.catppuccin-cursors.mochaSky;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "sky";
      };
    };
  };

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # ...
  dconf.settings = {
    # ...
    "org/gnome/shell" = {
      disable-user-extensions = false;

      # `gnome-extensions list` for a list
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "color-picker@tuberry"
        "zen@le0.gs"
        "paperwm@paperwm.github.com"
        "blur-my-shell@aunetx"
        "dash-to-panel@jderose9.github.com"
        "sound-output-device-chooser@kgshank.net"
      ];
    };

    # Set shell theme
    "org/gnome/shell/extensions/user-theme" = {
      name = "Catppuccin-Mocha-Compact-Sky-Dark";
    };

    # paperwm settings
    "org/gnome/shell/extensions/paperwm" = {
      show-window-position-bar = false;
      show-workspace-indicator = false;
      gesture-workspace-fingers = 4;
      window-gap = 10;
      default-focus-mode = 1;
      show-focus-mode-icon = true;
    };

    # Dash to dash-to-panel
    "org/gnome/shell/extensions/dash-to-panel" = {
      # Position
      multi-monitors = false;

      # Style
      animate-appicon-hover = true;
      trans-use-custom-opacity = true;
      trans-use-dynamic-opacity = true;

      # Behavior
      isolate-workspaces = true;
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.zen
    gnomeExtensions.blur-my-shell
    gnomeExtensions.color-picker
    gnomeExtensions.appindicator
    gnomeExtensions.paperwm
    gnomeExtensions.dash-to-panel
    gnomeExtensions.sound-output-device-chooser
    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "eza";
      lls = "eza -l";
      llas = "eza -la";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "npm" ];
      theme = "macovsky";
    };
  };

  programs.git = {
    enable = true;
    userName = "DoreiNeko";
    lfs.enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
