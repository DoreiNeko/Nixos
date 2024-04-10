{ config, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;
 
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
  };

  environment.systemPackages = with pkgs.kdePackages; [
    dolphin
    dolphin-plugins
    kcmutils
    qtstyleplugin-kvantum
  ];
}
