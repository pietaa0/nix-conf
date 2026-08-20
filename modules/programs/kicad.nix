{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.kicad;
in
{
  options.modules.kicad = {
    enable = mkEnableOption "KiCad";
    users = mkOption {
      type = types.listOf types.str;
      default = config.modules.user.users;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users = genAttrs cfg.users (name: {
      home.packages = with pkgs; [ kicad easyeda2kicad ];
    });
  };
}