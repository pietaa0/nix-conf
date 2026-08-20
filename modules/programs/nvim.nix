{ pkgs, config, lib, ... }:

with lib;

let
  cfg = config.modules.nvim;
in

{
  options.modules.nvim = {
    enable = mkEnableOption "nvim";
    users = mkOption {
      type = types.listOf types.str;
      default = config.modules.user.users;
    };
  };
  config = mkIf cfg.enable
    {

      nixpkgs.config.permittedInsecurePackages = [
        "pnpm-9.15.9"
      ];
      home-manager.users = genAttrs cfg.users (name: {

        home.packages = with pkgs; [ pyright lua-language-server nil rust-analyzer typescript-language-server vscode-langservers-extracted marksman stylua nixpkgs-fmt prettier ];
        programs.neovim = {
          enable = true;
          defaultEditor = true;
          viAlias = true;
          vimAlias = true;

          plugins = with pkgs.vimPlugins; [
            nvim-treesitter.withAllGrammars

            nvim-lspconfig

            nvim-cmp
            cmp-nvim-lsp
            luasnip
            cmp_luasnip
            nvim-autopairs

            conform-nvim

            telescope-nvim
            plenary-nvim
            gitsigns-nvim
            oil-nvim
            render-markdown-nvim
            mini-nvim
            dial-nvim

            tokyonight-nvim
          ];
          initLua = builtins.readFile ../../dotfiles/nvim/init.lua;
        };
      });
    };
}