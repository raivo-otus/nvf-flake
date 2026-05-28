{
  description = "Standalone home-manager Neovim config via nvf";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nvf,
    ...
  }: {
    homeManagerModules.default = {pkgs, ...}: {
      imports = [nvf.homeManagerModules.default];

      programs.nvf = {
        enable = true;
        settings.vim = {
          theme = {
            enable = true;
            name = "gruvbox";
            style = "dark";
          };

          options = {
            expandtab = true;
            shiftwidth = 2;
            tabstop = 2;
            relativenumber = true;
            number = true; # absolute number on current line, relative elsewhere
          };

          globals.mapleader = " ";

          statusline.lualine.enable = true;
          telescope.enable = true;
          autocomplete.nvim-cmp.enable = true;
          filetree.neo-tree.enable = true;
          binds.whichKey.enable = true; # popup showing available keybindings after a prefix key
          git.gitsigns.enable = true;
          visuals.indent-blankline.enable = true; # vertical guide lines at each indent level
          autopairs.nvim-autopairs.enable = true;

          spellcheck = {
            enable = true;
            ignoreTerminal = true;
            programmingWordlist.enable = true;
          };

          languages = {
            enableTreesitter = true; # syntax highlighting and code structure for all languages below
            enableFormat = true; # enable formatters for all languages below

            nix.enable = true;
            markdown.enable = true;
            r.enable = true;
            lua.enable = true;
            yaml.enable = true;
            toml.enable = true;
            typst.enable = true; # includes tinymist LSP and typst-preview-nvim
            python.enable = true; # basedpyright LSP + ruff formatter
            tex.enable = true; # texlab LSP + latexmk formatter
          };

          lsp = {
            enable = true;
            formatOnSave = true;
            trouble.enable = true; # structured diagnostics/references panel (:Trouble)
          };

          utility.surround.enable = true; # add/change/delete surroundings: ys, cs, ds

          navigation.harpoon.enable = true; # pin files for instant jump (<leader>a to mark, <C-e> to browse)

          # codewindow requires nvim-treesitter.ts_utils at setup time, before
          # treesitter is loaded via lz.n, causing an init error.
          # minimap.codewindow.enable = true;

          extraPlugins = with pkgs.vimPlugins; {
            "guess-indent" = {
              package = guess-indent-nvim;
              setup = "require('guess-indent').setup {}"; # detects and applies existing file indentation style
            };
          };
        };
      };
    };
  };
}
