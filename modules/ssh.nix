{ config, lib, ... }:
with lib;
{
  options.modules.ssh.enable = mkEnableOption "Wake-on-LAN and tailscale routing";

  config = mkIf config.modules.ssh.enable {
    services.tailscale.useRoutingFeatures = "server";
    networking.interfaces.enp34s0.wakeOnLan.enable = true;
  };
}