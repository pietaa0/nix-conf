{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.opt.enable = mkEnableOption "Large packages";

  config = mkIf config.modules.opt.enable {
    environment.systemPackages = with pkgs; [ libreoffice-still rustup mpv gcc ];
  };
}