{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.waybar;
in
{
  options.modules.waybar = {
    enable = mkEnableOption "waybar";
    users = mkOption {
      type = types.listOf types.str;
      default = config.modules.user.users;
    };
  };
  config = mkIf cfg.enable
    {

      home-manager.users = genAttrs cfg.users
        (name: {
          home.packages = with pkgs; [ pavucontrol networkmanagerapplet ];
          programs.waybar = {
            enable = true;

            settings = {
              mainBar = {
                layer = "top";
                position = "top";
                height = 38;
                spacing = 4;

                modules-left = [ "cpu" "memory" "temperature" ];
                modules-center = [ "clock" ];
                modules-right = [ "battery" "pulseaudio" "network" "tray" ];

                battery = {
                  format = "{icon} {capacity}%";
                  format-full = "{icon} {capacity%}";
                  format-charging = "󱐌 {capacity}%";
                  format-plugged = " {capacity}%";
                  format-alt = "{icon} {time}";
                  tooltip-format = "usage: {power:0.1f}W\n health: {health}%\n cycles: {cycles}";
                  format-icons = {
                    default = [
                      "󰂎"
                      "󰁺"
                      "󰁻"
                      "󰁼"
                      "󰁽"
                      "󰁾"
                      "󰁿"
                      "󰂀"
                      "󰂁"
                      "󰂂"
                      "󰁹"
                    ];
                  };
                };

                clock = {
                  interval = 1;
                  format = "󰃱 {:%H:%M  %a %d %b}";
                  format-alt = "󰃱 {:%H:%M %S}";
                  tooltip-format = "<tt><small>{calendar}</small></tt>";
                };

                cpu = { format = "sam 󰻠 {usage}%"; interval = 2; };
                memory = { format = "󰍛 {percentage}%"; interval = 2; };
                temperature = {
                  hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
                  format = "{icon} {temperatureC}C";
                  critical-threshold = 80;
                  format-critical = "{icon} {temperatureC}C";
                  format-icons = [ "" "" "" ];
                };
                pulseaudio = {
                  format = "{icon}";
                  format-muted = "muted";
                  format-icons = {
                    headphone = "󰋋";
                    headset = "󰋋";
                    hands-free = "󰋋";
                    default = [ "" "" " " ];
                  };
                  on-click = "pavucontrol";
                  tooltip-format = "{volume}%";
                };

                network = {
                  format-wifi = "{icon}";
                  format-ethernet = "";
                  format-disconnected = "󰤣";
                  format-disabled = "󰤮";
                  format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
                  tooltip-format-wifi = "󱄙  {essid} ({signalStrength}%)\n\n󰐻  Freq: {frequency}GHz\n  {bandwidthDownBytes}   {bandwidthUpBytes}";
                  tooltip-format-ethernet = "󰈀  {ifname} (Connected)\n  {bandwidthDownBytes}   {bandwidthUpBytes}";
                  on-click = "nm-applet --indicator";
                  on-click-right = "pkill nm-applet";
                };

                tray = {
                  spacing = 8;
                };
              };
            };

            style = ''
              @define-color foreground #cdd6f4;
              @define-color background #15161e;

                *:not(#waybar) {
                  font-family: "JetBrainsMono Nerd Font";
                  font-weight: 700;
                  font-size: 14px;
                  min-height: 0px;
                  margin: 0;
                  padding: 0;
                  border: none;
                  border-radius: 0;
                  }

                  window#waybar {
                    background: transparent;
                  }

                  #cpu,
                  #memory,
                  #temperature,
                  #clock,
                  #pulseaudio,
                  #network,
                  #battery,
                  #tray {
                  margin: 4px 5px;
                  padding: 6px 16px;
                  border-radius: 20px;
                  color: @foreground;
                  background-color: @background;
                  color: #A9B1D6;
                  }
            '';
          };
        });
    };
}