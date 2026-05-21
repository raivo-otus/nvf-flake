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
          };

          globals.mapleader = " ";

          statusline.lualine.enable = true;
          telescope.enable = true;
          autocomplete.nvim-cmp.enable = true;
          filetree.neo-tree.enable = true;
          binds.whichKey.enable = true;
          git.gitsigns.enable = true;
          visuals.indent-blankline.enable = true;
          dashboard.dashboard-nvim.enable = true;
          autopairs.nvim-autopairs.enable = true;

          languages = {
            enableTreesitter = true;
            enableFormat = true;

            nix.enable = true;
            markdown.enable = true;
            r.enable = true;
            lua.enable = true;
            yaml.enable = true;
            toml.enable = true;
          };

          lsp = {
            enable = true;
            formatOnSave = true;
          };

          extraPlugins = with pkgs.vimPlugins; {
            "guess-indent" = {
              package = guess-indent-nvim;
              setup = "require('guess-indent').setup {}";
            };
          };
        };
      };
    };
  };
}
