{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [ inputs.nvf.homeManagerModules.default ];

  options = {
    nvf.enable = lib.mkEnableOption "enables nvf";
  };

  config = lib.mkIf config.nvf.enable {
    programs.nvf = {

      enable = true;

      settings = {
        vim = {

          git.enable = true;
          lsp.enable = true;

          languages = {
            enableFormat = true;
            enableTreesitter = true;
            # Languages
            bash.enable = true;
            julia = {
              enable = true;
              lsp.package = null;
            };
            markdown = {
              enable = true;
              extensions.render-markdown-nvim.enable = true;
            };
            nix = {
              enable = true;
              format.type = "nixfmt";
              # lsp.server = "nixd"; # nixd seems to be not available yet
            };
            python.enable = true;
            r.enable = true;
          };

          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
          };

          # Plugins
          autocomplete.nvim-cmp.enable = true; # Swap for blink when available
          filetree.neo-tree.enable = true;
          statusline.lualine.enable = true;
          tabline.nvimBufferline.enable = true;
          telescope.enable = true;
          terminal.toggleterm = {
            enable = true;
            lazygit = {
              enable = true;
              package = null; # Null to use PATH
            };
          };
          ui.noice.enable = true;
          visuals.nvim-web-devicons.enable = true;

        };
      };

    };
  };
}
