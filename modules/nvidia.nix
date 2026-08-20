{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.nvidia.enable = mkEnableOption "NVIDIA GPU support";

  config = mkIf config.modules.nvidia.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.open = true;
    hardware.nvidia.modesetting.enable = true;
  };
}