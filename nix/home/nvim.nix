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
        mode = "n";
        key = "<space>d";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
      mode = "n";
      key = "K";
      action = "vim.lsp.buf.hover";
      lua = true;
      options = {
        noremap = true;
        silent = true;
      };
      }
      {
      mode = "n";
      key = "gD";
      action = "vim.lsp.buf.declaration";
      lua = true;
      options = {
        noremap = true;
        silent = true;
      };
      }
      {
      mode = "n";
      key = "gd";
      action = "<cmd>Telescope lsp_definitions<CR>";
      options = {
        noremap = true;
        silent = true;
      };
      }
      {
      mode = "n";
      key = "gi";
      action = "<cmd>Telescope lsp_implementations<CR>";
      options = {
        noremap = true;
        silent = true;
      };
      }
      {
      mode = "n";
      key = "<space>rn";
      action = "vim.lsp.buf.rename";
      lua = true;
      options = {
        noremap = true;
        silent = true;
      };
      }
      {
      mode = "n";
      key = "gr";
      action = "<cmd>Telescope lsp_references<CR>";
      options = {
        noremap = true;
        silent = true;
      };
      }
      {
      mode = [ "n" "v" ];
      key = "<space>ca";
      action = "vim.lsp.buf.code_action";
      lua = true;
      options = {
        noremap = true;
        silent = true;
      };
      }
    ];

    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
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
          roslyn_ls = {
            enable = true;
          };
          rust_analyzer = {
            enable = true;
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
        };
      };
      treesitter = {
        enable = true;
        highlight.enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
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
    };
  };
}
