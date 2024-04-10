{ config, pkgs, ... }:

{
  # Asus stuff for my laptop
  services.supergfxd.enable = true;
  services.asusd = {
    enable = true;
    enableUserService = true;
  };
}
