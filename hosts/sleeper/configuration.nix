{ lib, ... }:

{
  imports = [
    ../../shared/configuration.nix
  ];

  modules = {
    user = {
      enable = true;
      users = [ "r0" "roos" ];
    };
  };

  networking.hostName = "sleeper";
  system.stateVersion = "26.05";
}
