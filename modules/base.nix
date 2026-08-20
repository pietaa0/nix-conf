{ config, lib, pkgs, ... }:

with lib;

{
  options.modules.base.enable = mkEnableOption "Core system configuration";

  config = mkIf config.modules.base.enable {

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    boot.loader.systemd-boot.enable = true;

    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.networkmanager.enable = true;
    services.tailscale.enable = true;

    time.timeZone = "Europe/Amsterdam";
    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver.xkb.layout = "us";

    fonts.packages = with pkgs; [ noto-fonts noto-fonts-cjk-sans noto-fonts-color-emoji liberation_ttf nerd-fonts.jetbrains-mono ];
    fonts.fontconfig = {
      defaultFonts = {
        serif = [ "Noto-serif" ];
        sansSerif = [ "Noto-sans" ];
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    hardware.graphics.enable = true;
    services.printing.enable = true;
    services.libinput.enable = true;
    programs.zsh.enable = true;

    xdg.terminal-exec =
      {
        enable = true;
        settings.default = [ "kitty.desktop" ];
      };
    environment.systemPackages = with pkgs;
      [ feishin drawy lazygit swaylock tmux vim tree wget zip unzip luarocks qjackctl yazi ripgrep ];

  };
}