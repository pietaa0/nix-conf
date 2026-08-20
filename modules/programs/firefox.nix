{ config, lib, ... }:

with lib;

let
  cfg = config.modules.firefox;
in
{
  options.modules.firefox = {
    enable = mkEnableOption "firefox";
    users = mkOption {
      type = types.listOf types.str;
      default = config.modules.user.users;
    };
  };
  config = mkIf cfg.enable
    {
      home-manager.users = genAttrs cfg.users (name: {
        programs.firefox = {
          enable = true;

          profiles.default = {
            id = 0;
            isDefault = true;

            settings = {
              "browser.startup.homepage" = "about:blank";
              "browser.newtabpage.enabled" = false;
              "privacy.trackingprotection.enabled" = true;
              "signon.rememberSignons" = false;
              "browser.download.folderList" = 2;
              "browser.download.dir" = "/home/r0/Downloads";
              "extentions.pocket.enabled" = false;
              "browser.tabs.warnOnClose" = false;
              "extentions.activeThemeID" = "firefox-compact-dark@mozilla.org";
              "ui.systemUsesDarkTheme" = 1;
              "layout.css.prefers-color-scheme.content-override" = 0;
              "browser.urlbar.suggest.searches" = false;
              "browser.compactmode.show" = true;
              "full-screen-api.warning.timeout" = 0;
              "browser.aboutConfig.showWarning" = false;
              "sidebar.revamp" = true;
              "sidebar.verticalTabs" = true;
              "sidebar.position_start" = false;
              "places.history.enabled" = false;
              "browser.urlbar.suggest.history" = false;
            };

            search = {
              default = "ddg";
              force = true;
            };


          };


        };
      });
    };
}