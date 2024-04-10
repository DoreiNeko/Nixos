{ config, pkgs, ... }:

{
  hardware.opengl = {
    # amdvlk
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };
}
