{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.user;
in
{
  imports = [
    ./home/r0.nix
    ./home/roos.nix
    ./home/root.nix
  ];

  options.modules.user = {
    enable = mkEnableOption "User accounts";
    users = mkOption
      {
        type = types.listOf types.str;
        default = [ ];
      };
  };

  config = mkIf cfg.enable {

    users.users = genAttrs cfg.users (name: {
      isNormalUser = true;
      initialPassword = "changeme";
      shell = pkgs.zsh;
    });


    home-manager.backupFileExtension = "backup";
    home-manager.overwriteBackup = true;

  };
}