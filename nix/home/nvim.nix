{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    opts = {
      number = true;
      relativenumber = true;
      swapfile = false;
      undofile = true;
      clipboard = "unnamedplus";
      termguicolors = true;
      expandtab = true;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
    };

    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "night";
      };
    };

    keymaps = [
    {
      key = "s";
      mode = [ "n" "x" "o" ];
      action.__raw = ''
        function()
          require("flash").jump()
        end
      '';
      options.desc = "Flash jump";
    }
    {
      key = "S";
      mode = [ "n" "x" "o" ];
      action.__raw = ''
        function()
          require("flash").treesitter()
        end
      '';
      options.desc = "Flash treesitter";
    }
    {
    key = "<C-Space>";
    mode = [ "n" "x" "o" ];
    action.__raw = ''
      function()
        require("flash").treesitter({
          actions = {
            ["<c-space>"] = "next",
            ["<BS>"] = "prev",
          },
        })
      end
    '';
    options.desc = "Treesitter incremental selection";
  }
{
      mode = "n";
      key = "<leader>f/";
      action.__raw = ''
      function()
	require('telescope.builtin').live_grep({
	  grep_open_files = true,
	  prompt_title = "Live Grep in Open Files"
	})
	end
      '';
      options.desc = "Fuzzily search in open files";
    }
      {
        mode = "n";
        key = "<space>d";
        action.__raw = "vim.diagnostic.open_float";
        options.desc = "Open diagnostic float";
      }
      {
        mode = "n";
        key = "K";
        action.__raw = "vim.lsp.buf.hover";
        options.desc = "Hover documentation";
      }
      {
        mode = "n";
        key = "gD";
        action.__raw = "vim.lsp.buf.declaration";
        options.desc = "Go to declaration";
      }
      {
        mode = "n";
        key = "<space>rn";
        action.__raw = "vim.lsp.buf.rename";
        options.desc = "Rename symbol";
      }
      {
        mode = [ "n" "v" ];
        key = "<space>ca";
        action.__raw = "vim.lsp.buf.code_action";
        options.desc = "Code action";
      }
    ];

    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
          mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
                }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                  local luasnip = require('luasnip')
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                  else
                    fallback()
                  end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                  local luasnip = require('luasnip')
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end, { 'i', 's' }),
              })
            '';
          };
        };
      };
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;

      conform = {
        enable = true;
        autoLoad = true;
        format_on_save = # Lua
      ''
        function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          if slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end

          local function on_format(err)
            if err and err:match("timeout$") then
              slow_format_filetypes[vim.bo[bufnr].filetype] = true
            end
          end

          return { timeout_ms = 200, lsp_fallback = true }, on_format
         end
      '';
        format_after_save = # Lua
	''
	  function(bufnr)
	    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
	      return
	    end

	    if not slow_format_filetypes[vim.bo[bufnr].filetype] then
	      return
	    end

	    return { lsp_fallback = true }
	  end
	'';
      };
      dap = {
        enable = true;
      };
      flash = {
        enable = true;
        modes = {
          treesitter = {
            search.incremental = true;
          };
        };
      };
      gitsigns = {
        enable = true;
      };
      lsp = {
        enable = true;
        servers = {
          eslint = {
            enable = true;
          };
          nixd = {
            enable = true;
          };
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          tailwindcss = {
            enable = true;
          };
          ts_ls = {
            enable = true;
          };
          gh_action_ls = {
            enable = true;
          };
        };
      };
      lsp-format = {
        enable = true;
	      lspServersToEnable = "all";
      };
      neotest = {
        enable = true;
        adapters = {
          dotnet = {
            enable = true;
          };
        };
      };
      oil = {
        enable = true;
        settings ={
          columns = [
            "icon"
          ];
          keymaps = {
            "<C-p>" = false;
          };
          view_options = {
            show_hidden = true;
          };
        };
      };
      render-markdown = {
        enable = true;
      };
      roslyn = {
        enable = true;
        settings = {
          filewatching = "off";
        };
      };
      telescope = {
        enable = true;
	      file_ignore_patterns = [
	        "node%_modules/.*"
	        "node_modules"
	        "^node_modules/*"
	        "node_modules/*"
	      ];
        extensions = {
          ui-select = {
            enable = true;
          };
        };
        keymaps = {
          "<C-p>" = {
            action = "git_files";
          };
	        "<Space><Space>" = {
	          action = "oldfiles";
	        };
	        "<Space>fg" = {
	          action = "live_grep";
	        };
	        "<Space>fh" = {
	          action = "help_tags";
	        };
          "gd" = {
            action = "lsp_definitions";
          };
          "gi" = {
            action = "lsp_implementations";
          };
          "gr" = {
            action = "lsp_references";
          };
        };
      };
      treesitter = {
        enable = true;
        highlight.enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          c_sharp
          json
          lua
          make
          markdown
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
        ];
      };
      web-devicons.enable = true;
    };
  };
}
