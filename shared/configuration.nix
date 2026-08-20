{ lib, ... }:

{
  imports = [
    ../modules/base.nix
  ];

  modules = {
    base.enable = true;
  };

  powerManagement.cpuFreqGovernor = "performance";
}