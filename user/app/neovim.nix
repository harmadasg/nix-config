{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    # This just enables NixVim.
    # If all you have is this, then there will be little visible difference
    # when compared to just installing NeoVim.
    enable = true;

    keymaps = [
      { 
        mode = "n";
        key = "<C-p>";
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
      }
      {
        mode = "n";
        key = "<C-n>";
        action = "<cmd>Neotree filesystem reveal left<CR>";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      }
      {
        mode = ["n" "v"];
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      }
      {
        mode = "n";
        key = "<leader>gf";
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
      }
    ];

    # We can set the leader key:
    globals.mapleader = " ";

    # We can create maps for every mode!
    # There is .normal, .insert, .visual, .operator, etc!

    # We can also set options:
    opts = {

      # Set whitespace options, see http://vimcasts.org/episodes/tabs-and-spaces/
      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;

      # etc...
    };

    # One of the big advantages of NixVim is how it provides modules for
    # popular vim plugins
    # Enabling a plugin this way skips all the boring configuration that
    # some plugins tend to require.
    plugins = {
      telescope = {
        enable = true;
        extensions = {
          ui-select.enable = true;
        };
      };

      web-devicons.enable = true;

      lualine.enable = true;

      treesitter = {
        enable = true;
        # By default, all available grammars packaged in the nvim-treesitter package are installed.
        # If you'd like more control, you could instead specify which packages to install. For example:
        # grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        #   bash
        #   json
        #   lua
        #   make
        #   markdown
        #   nix
        #   regex
        #   toml
        #   vim
        #   vimdoc
        #   xml
        #   yaml
        # ];
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      neo-tree.enable = true;

      alpha = {
        enable = true;
        theme = "startify";
      };

      none-ls = {
        enable = true;
        sources.formatting = {
          stylua.enable = true;
          isort.enable = true;
          black.enable = true;
          prettier = {
            enable = true;
            disableTsServerFormatter = true;
          };
        };
      };
  
      lsp = {
        enable = true;
        servers = {
          ts_ls.enable = true;
          nixd.enable = true;
          lua_ls.enable = true;
          eslint.enable = true;
        };
      };

      luasnip = {
        enable = true;
        fromVscode = [ { } ];
      };
      cmp_luasnip.enable = true;
      friendly-snippets.enable = true;


      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
          window = 
            let
              bordered = {
                border = "rounded";
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
                zindex = 1001;
              };
            in
            {
              completion = bordered;
              documentation = bordered;
            };
          sources = [
            {name = "nvim_lsp";}
            {name = "buffer";}
            {name = "path";}
            {name = "luasnip";}
          ];
          mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
              })
            '';
          };
        };
      };

      dap = {
        enable = true;
        extensions.dap-ui.enable = true;
      };
    };
    
    # There is a separate namespace for colorschemes:
    colorschemes.catppuccin.enable = true;
  };


}
