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
    firefox.enable = true;
    nvim.enable = true;
    nvim.users = [ "r0" "root" ];
    zsh.enable = true;
    zsh.users = [ "r0" "root" ];
    kitty.enable = true;
  };

  networking.hostName = "sleeper";
  system.stateVersion = "26.05";
}
