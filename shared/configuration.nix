{ lib, ... }:

{
  imports = [
    ../modules/base.nix
    ../modules/user.nix
    ../modules/programs/firefox.nix
    ../modules/programs/kitty.nix
    ../modules/programs/nh.nix
    ../modules/programs/nvim.nix
    ../modules/programs/zsh.nix
  ];

  modules = {
    base.enable = true;
    nh.enable = true;
    nh.users = [ "root" "r0" ];
  };

  powerManagement.cpuFreqGovernor = "performance";
}