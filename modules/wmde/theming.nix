{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.modules.theming;
in

{
  options.modules.theming = {
    enable = mkEnableOption "theming";
    users = mkOption {
      type = types.listOf types.str;
      default = config.modules.user.users;
    };
  };
  config = mkIf cfg.enable
    {

      home-manager.users = genAttrs cfg.users
        (name: {
          gtk = {
            enable = true;

            theme = {
              name = "Adwaita-dark";
              package = pkgs.gnome-themes-extra;
            };

            iconTheme = {
              name = "Papirus-Dark";
              package = pkgs.papirus-icon-theme;
            };

            cursorTheme = {
              name = "Bibata-Modern-Classic";
              package = pkgs.bibata-cursors;
              size = 24;
            };
          };

          home.pointerCursor = {
            enable = true;
            name = "Bibata-Modern-Classic";
            package = pkgs.bibata-cursors;
            size = 24;
            gtk.enable = true;
            x11.enable = true;
          };

          qt = {
            enable = true;
            platformTheme.name = "gtk3";
            style.name = "adwaita-dark";
          };
        });
    };

}