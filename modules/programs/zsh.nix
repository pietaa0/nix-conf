{ pkgs, config, lib, ... }:

with lib;

let
  cfg = config.modules.zsh;
in
{
  options.modules.zsh = {
    enable = mkEnableOption "zsh";
    users = mkOption {
      type = types.listOf types.str;
      default = config.modules.user.users;
    };
  };
  config = mkIf cfg.enable
    {
      home-manager.users = genAttrs cfg.users (name: {
        home.packages = with pkgs;
          [ zsh-completions ];

        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          autocd = true;

          shellAliases = {
            la = "ls -la";
            configedit = "sudo -E nvim /etc/nixos/hosts/$(hostname)/configuration.nix";
            configdir = "cd /etc/nixos";
            moddir = "cd /etc/nixos/modules";
            dotfiledir = "cd /etc/nixos/dotfiles";
            nrebuild = "nh os switch";
            nboot = "nh os boot";
            upshut = "nh os boot && shutdown now";
            upreb = "nh os boot && reboot";
            ".." = "cd ..";
            "..." = "cd ../..";
            snvim = "sudo -E nvim";
            slazy = "sudo -E lazygit";
            cd = "z";
          };

          history = {
            size = 10000;
            save = 10000;
          };

          initContent = ''
              zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'


            function y() {
              local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
              command yazi "$@" --cwd-file="$tmp"
              IFS= read -r -d ''' cwd < "$tmp"
              [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
              command rm -f -- "$tmp"
            }
          '';
        };

        programs.starship = {
          enable = true;
          settings = {
            add_newline = false;
            format = "$all";
          };
        };

        programs.zoxide.enable = true;
      });
    };
}