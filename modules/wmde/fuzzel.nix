{ config, lib, ... }:

with lib;

let
  cfg = config.modules.fuzzel;
in
{
  options.modules.fuzzel = {
    enable = mkEnableOption "fuzzel";
    users = mkOption {
      type = types.listOf types.str;
      default = config.modules.user.users;
    };
  };
  config = mkIf cfg.enable {

    home-manager.users = genAttrs cfg.users (name: {

      programs.fuzzel = {
        enable = true;
        settings = {
          main = {
            font = "JetBrainsMono Nerd Font";
            lines = 10;
            width = 35;
          };
          colors = {
            background = "15161Eff";
            text = "a9b1d6ff";
            match = "6580a8ff";
            selection = "2a2b3cff";
            "selection-text" = "c0caf5ff";
            "selection-match" = "7393b3ff";
            border = "32344aff";
          };

          border = { width = 1; radius = 4; };
        };
      };
    });
  };
}