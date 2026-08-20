{ lib, ... }:

{
  imports = [
    ../../shared/configuration.nix
  ];

  networking.hostName = "dreamer";
  system.stateVersion = "26.05";
}
