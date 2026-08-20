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
    zsh.users = [ "r0" "roos" "root" ];
    kitty.enable = true;
    dvd.enable = false;
    kicad.enable = false;
    obsidian.enable = true;
    obsidian.users = [ "r0" ];
  };

  networking.hostName = "dreamer";
  system.stateVersion = "26.05";
}
