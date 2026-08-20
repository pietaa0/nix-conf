{ lib, ... }:

{
  imports = [
    ../modules/base.nix
    ../modules/gaming.nix
    ../modules/laptop.nix
    ../modules/nvidia.nix
    ../modules/user.nix
    ../modules/programs/dvd.nix
    ../modules/programs/firefox.nix
    ../modules/programs/kicad.nix
    ../modules/programs/kitty.nix
    ../modules/programs/nh.nix
    ../modules/programs/nvim.nix
    ../modules/programs/obsidian.nix
    ../modules/programs/zsh.nix
    ../modules/wmde/niri.nix
    ../modules/wmde/xfce.nix
  ];

  modules = {
    base.enable = true;
    nh.enable = true;
    nh.users = [ "root" "r0" ];
  };

  specialisation.xfce.configuration = {
    modules.niri.enable = lib.mkForce false;
    modules.xfce.enable = lib.mkForce true;
  };

  powerManagement.cpuFreqGovernor = "performance";
}