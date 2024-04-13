{ lib, config, pkgs, ... }:

{
  options = {
    main-user.enable
      = lib.mkEnableOption "enable user module";

    main-user.userName = lib.mkOption {
      default = "mainuser";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf config.main-user.enable {
    users.users.${config.main-user.userName} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "render" "video" "libvirt" ];
      packages = with pkgs; [
        protonvpn-gui
        firefox
        curl
        wget
        git
        gh
        eza
        neovim
        vesktop
        spotify
        ripgrep
        zig
        rustup
        transmission-gtk
        obs-studio
        krita
        blender
      ];
    };
    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
        };

        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
    programs.kdeconnect.enable = true;
  };
}
