{ lib, ... }:

{
  imports = [
    ../modules/base.nix
    ../modules/user.nix
  ];

  modules = {
    base.enable = true;
  };

  powerManagement.cpuFreqGovernor = "performance";
}