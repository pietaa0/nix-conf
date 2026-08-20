{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.nh;
in
{
  options.modules.nh = {
    enable = mkEnableOption "nix helper";
    users = mkOption {
      type = types.listOf types.str;
      default = config.modules.user.users;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users = genAttrs cfg.users
      (name: {
        programs.nh = {
          enable = true;
          flake = "/etc/nixos";
        };
      });
  };
}