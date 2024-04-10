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
      extraGroups = [ "wheel" "render" "video" ];
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
      ];
    };
    programs.steam = {
      enable = true;
    };
  };
}
