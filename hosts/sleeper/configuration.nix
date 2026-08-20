{ lib, ... }:

{
  imports = [
    ../../shared/configuration.nix
  ];

  modules = {
    nvidia.enable = true;
    gaming.enable = true;
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
    dvd.enable = true;
    dvd.users = [ "r0" ];
    kicad.enable = true;
    obsidian.enable = true;
    obsidian.users = [ "r0" ];
  };

  networking.hostName = "sleeper";
  system.stateVersion = "26.05";
}
