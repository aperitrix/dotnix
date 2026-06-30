{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixfmt
    black
    ripgrep
    fd
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    globals.mapleader = " ";
    globals.maplocalleader = " ";

    colorschemes.tokyonight = {
      enable = true;
      settings.style = "night";
    };

    opts = {
      number = true;
      relativenumber = true;
      clipboard = "unnamedplus";
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      termguicolors = true;
      ignorecase = true;
      smartcase = true;
      splitright = true;
      splitbelow = true;
      signcolumn = "yes";
      updatetime = 200;
      timeoutlen = 300;
      undofile = true;
      scrolloff = 8;
    };

    plugins = {
      # UI
      lualine = {
        enable = true;
        settings.options.theme = "tokyonight";
      };
      bufferline.enable = true;
      indent-blankline.enable = true;
      nvim-tree.enable = true;
      which-key.enable = true;
      gitsigns.enable = true;
      noice.enable = true;
      notify.enable = true;

      # Fuzzy finding
      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
      };

      # Treesitter
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
      treesitter-context.enable = true;

      # LSP
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          pyright.enable = true;
          lua_ls.enable = true;
          bashls.enable = true;
        };
      };
      lsp-format.enable = true;
      fidget.enable = true; # LSP progress UI

      # Completion (LazyVim default = blink.cmp now, nvim-cmp also fine)
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
            "<C-Space>" = "cmp.mapping.complete()";
          };
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;
      luasnip.enable = true;

      # Formatting
      conform-nvim = {
        enable = true;
        settings.formatters_by_ft = {
          nix = [ "nixfmt" ];
          python = [ "black" ];
        };
      };

      # Git
      lazygit.enable = true;

      spectre.enable = true;
    };

    keymaps = [
      # File explorer (LazyVim style)
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>NvimTreeToggle<CR>";
        options.desc = "Toggle file explorer";
      }

      # Telescope (find files / grep / buffers)
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "Grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<CR>";
        options.desc = "Recent files";
      }

      # LSP (LazyVim style: g prefix for goto, leader+c for code)
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.desc = "Goto definition";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options.desc = "References";
      }
      {
        mode = "n";
        key = "gi";
        action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
        options.desc = "Implementation";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        options.desc = "Hover docs";
      }
      {
        mode = "n";
        key = "<leader>cr";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options.desc = "Rename";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options.desc = "Code action";
      }
      {
        mode = "n";
        key = "<leader>cf";
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
        options.desc = "Format";
      }

      # Buffers (tabs)
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>bprevious<CR>";
        options.desc = "Prev buffer";
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>bnext<CR>";
        options.desc = "Next buffer";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<CR>";
        options.desc = "Delete buffer";
      }
      {
        mode = "n";
        key = "<leader>bo";
        action = "<cmd>BufferLineCloseOthers<CR>";
        options.desc = "Close other buffers";
      }

      # Window navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Go to left window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Go to right window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Go to lower window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Go to upper window";
      }

      # Git
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options.desc = "LazyGit";
      }

      # Clear search highlight
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
        options.desc = "Clear search highlight";
      }

      {
        mode = "v";
        key = ">";
        action = ">gv";
        options.desc = "Indent and reselect";
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options.desc = "Outdent and reselect";
      }

      # Search & Replace (Spectre - project-wide)
      {
        mode = "n";
        key = "<leader>sr";
        action = "<cmd>lua require('spectre').toggle()<CR>";
        options.desc = "Replace in files (Spectre)";
      }
      {
        mode = "n";
        key = "<leader>sW";
        action = "<cmd>lua require('spectre').open_visual({select_word=true})<CR>";
        options.desc = "Search current word";
      }
      {
        mode = "v";
        key = "<leader>sW";
        action = "<cmd>lua require('spectre').open_visual()<CR>";
        options.desc = "Search current selection";
      }
      {
        mode = "n";
        key = "<leader>sp";
        action = "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>";
        options.desc = "Search in current file";
      }

      # Telescope-based search
      {
        mode = "n";
        key = "<leader>sg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "Grep (root dir)";
      }
      {
        mode = "n";
        key = "<leader>sw";
        action = "<cmd>Telescope grep_string<CR>";
        options.desc = "Search word under cursor";
      }
      {
        mode = "v";
        key = "<leader>sw";
        action = "<cmd>Telescope grep_string<CR>";
        options.desc = "Search word under cursor";
      }
      {
        mode = "n";
        key = "<leader>sb";
        action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
        options.desc = "Search in current buffer";
      }

      # Native buffer-local find & replace
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
        options.desc = "Fuzzy search in buffer";
      }
      {
        mode = "n";
        key = "<leader>rr";
        action = ":%s/";
        options.desc = "Replace in buffer";
      }
      {
        mode = "v";
        key = "<leader>rr";
        action = ":s/";
        options.desc = "Replace in selection";
      }

      # Quick word-under-cursor replace (classic LazyVim-adjacent pattern)
      {
        mode = "n";
        key = "<leader>cR";
        action = ":%s/\\<<C-r><C-w>\\>//g<Left><Left>";
        options.desc = "Rename word under cursor (buffer)";
      }
    ];
  };
}
