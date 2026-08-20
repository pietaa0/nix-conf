{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.modules.obsidian;
in
{
  options.modules.obsidian = {
    enable = mkEnableOption "obsidian";
    users = mkOption {
      type = types.listOf types.str;
      default = config.modules.user.users;
    };
  };
  config = mkIf cfg.enable {
    home-manager.users = genAttrs cfg.users
      (name: {
        programs.obsidian = {
          enable = true;

          vaults."forget-me-not" = {
            enable = true;
            target = "Documents/forget-me-not";
          };
          defaultSettings = {
            corePlugins = [
              { name = "daily-notes"; settings = { folder = "daily"; format = "YYYY-MM-DD"; }; }
              { name = "templates"; settings.folder = "templates"; }
              "backlink"
              "file-explorer"
              "global-search"
              "tag-pane"
              "graph"
            ];
          };

        };
      });
  };
}