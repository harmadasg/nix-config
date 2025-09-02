{
  inputs,
  systemSettings,
  userSettings,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.${userSettings.shell} = {
    shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };
  };

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
      # For later
      #
      # bufmap('gr', require('telescope.builtin').lsp_references)
      # bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
      # bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)
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
        key = "<leader>r";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
      }
      {
        mode = "n";
        key = "<leader>gD";
        action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
      }
      {
        mode = "n";
        key = "<leader>gI";
        action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
      }
      {
        mode = "n";
        key = "<leader>D";
        action = "<cmd>lua vim.lsp.buf.type_definition()<CR>";
      }
      {
        mode = "n";
        key = "<leader>gf";
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
      }
    ];

    # We can set the leader key:
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # We can create maps for every mode!
    # There is .normal, .insert, .visual, .operator, etc!

    # We can also set options:
    opts = {
      # Set whitespace options, see http://vimcasts.org/episodes/tabs-and-spaces/
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      number = true;
      clipboard = "unnamedplus";
      signcolumn = "auto";
      mouse = "a";
      termguicolors = true;

      # etc...
    };

    plugins = {
      telescope = {
        enable = true;
        extensions = {
          ui-select.enable = true;
        };
      };

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      comment.enable = true;
      gitsigns.enable = true;
      # diffview.enable  for later

      neo-tree.enable = true;

      lualine.enable = true;

      web-devicons.enable = true;

      alpha = {
        enable = true;
        theme = "startify";
      };

      none-ls = {
        enable = true;
        sources.formatting.alejandra.enable = true;
      };

      lsp = {
        enable = true;
        servers.nixd = {
          enable = true;
          settings = {
            options = let
              getFlake = ''(builtins.getFlake "${./../..}")'';
            in {
              nixos.expr = "${getFlake}.nixosConfigurations.${systemSettings.hostname}.options";
              home_manager.expr = "${getFlake}.homeConfigurations.${userSettings.username}.options";
            };
          };
        };
      };

      luasnip.enable = true;
      friendly-snippets.enable = true;
      cmp_luasnip.enable = true;
      cmp-nvim-lsp.enable = true;

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
          window = let
            bordered = {
              border = "rounded";
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
              zindex = 1001;
            };
          in {
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
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require('luasnip').locally_jumpable(-1) then
                  require('luasnip').jump(-1)
                else
                  fallback()
                end
              end, { 'i', 's' })
            '';
            "<Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require('luasnip').expand_or_locally_jumpable() then
                  require('luasnip').expand_or_jump()
                else
                  fallback()
                end
              end, { 'i', 's' })
            '';
          };
        };
      };
    };
  };
}
