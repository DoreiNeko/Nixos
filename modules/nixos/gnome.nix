{ cnofig, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    };

  environment.gnome.excludePackages = ( with pkgs; [
    gnome-photos
    gnome-tour
    epiphany
  ]) ++ (with pkgs.gnome; [
    gnome-terminal
  ]);
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
  ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  xdg.portal.enable = true;
}
