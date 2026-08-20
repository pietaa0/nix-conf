{ lib, pkgs, config, ... }:

let
  sddm-astronaut = (pkgs.sddm-astronaut.override {
    embeddedTheme = "purple_leaves";
  });
  cfg = config.modules.niri;
in
{
  options.modules.niri = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = config.modules.user.users;
    };
  };
  imports = [
    ./waybar.nix
    ./fuzzel.nix
    ./theming.nix
  ];
  config = lib.mkIf
    cfg.enable
    {
      environment.systemPackages = with pkgs; [ sddm-astronaut xwayland-satellite cliphist ];
      programs.niri.enable = true;

      modules = {
        waybar.enable = true;
        fuzzel.enable = true;
        theming.enable = true;
      };

      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        package = pkgs.kdePackages.sddm;
        extraPackages = with pkgs; [ kdePackages.qtmultimedia ];
        theme = "sddm-astronaut-theme";
      };
      home-manager.users = lib.genAttrs cfg.users
        (name: {
          xdg.configFile."niri/config.kdl".source = ../../dotfiles/niri/config.kdl;
        });
      system.nixos.label = "niri";
    };
}