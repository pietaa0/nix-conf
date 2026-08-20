{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.modules.dvd;
in
{
  options.modules.dvd = {
    enable = mkEnableOption "DVD burning tools";
    users = mkOption {
      type = types.listOf types.str;
      default = config.modules.user.users;
    };
  };
  config = mkIf cfg.enable {
    services.udev.extraRules = ''
      KERNEL=="sr[0-9]*", GROUP="cdrom", MODE="0660"
    '';
    programs.k3b.enable = true;
    services.udisks2.enable = true;
    users.users = genAttrs cfg.users (name: {
      extraGroups = [ "cdrom" ];
    });
    home-manager.users = genAttrs cfg.users (name: {
      home.packages = with pkgs; [ dvdplusrwtools kid3 ];
    });
  };
}