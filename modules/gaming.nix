{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.gaming.enable = mkEnableOption "Gaming packages";

  config = mkIf config.modules.gaming.enable {
    hardware.graphics.enable32Bit = true;
    programs.steam.enable = true;
    programs.gamemode.enable = true;
    environment.systemPackages = with pkgs; [ lutris mangohud blender gamescope ];
  };
}