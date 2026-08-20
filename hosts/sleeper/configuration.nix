{ lib, ... }:

{
  imports = [
    ../../shared/configuration.nix
  ];

  networking.hostName = "sleeper";
  system.stateVersion = "26.05";
}
