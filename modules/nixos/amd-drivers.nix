{ config, pkgs, ... }:

{
  # Load drivers early
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Set the video driver
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  hardware.opengl = {
    # Radv
    driSupport = true;
    driSupport32Bit = true;

    # amdvlk
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };
}
