{ config, lib, ... }:

with lib;

let
  cfg = config.modules.kitty;
in
{
  options.modules.kitty =
    {
      enable = mkEnableOption "kitty";
      users = mkOption {
        type = types.listOf types.str;
        default = config.modules.user.users;
      };
    };
  config = mkIf cfg.enable
    {
      home-manager.users = genAttrs cfg.users (name: {

        programs.kitty = {
          enable = true;
          font = { name = "JetBrainsMono Nerd Font"; size = 11; };
          settings = {
            background_opacity = "0.80";
            window_padding_width = 10;
            scrollback_lines = 10000;
            enable_audio_bell = false;
          };
          themeFile = "Eldritch-dark";
        };
      });
    };
}