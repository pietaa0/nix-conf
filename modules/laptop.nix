{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.laptop.enable = mkEnableOption "Laptop-specific hardware support";

  config = mkIf config.modules.laptop.enable {
    services.upower.enable = true;
    hardware.bluetooth.enable = true;
    powerManagement.enable = true;
    services.logind.settings.Login.HandleLidSwitch = "ignore";
  };
}