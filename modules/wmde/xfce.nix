{ lib, config, ... }:
{
  options.modules.xfce.enable = lib.mkEnableOption "xfce";

  config = lib.mkIf config.modules.xfce.enable {
    nixpkgs.config.pulseaudio = true;
    services = {
      xserver = {
        enable = true;
        desktopManager = { xterm.enable = false; xfce.enable = true; };
      };
      displayManager.defaultSession = "xfce";
    };

    system.nixos.label = "xfce";
  };
}