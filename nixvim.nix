{ pkgs, config, inputs, lib, ... }:
{
  programs.nixvim = {
    enable = true;
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    colorschemes.catppuccin = {
      enable = true;
      autoLoad = true;
      settings.flavour = "mocha";
    };
    clipboard.providers.wl-copy.enable = true;
    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
      ignorecase = true;
      smartcase = true;
      background = "dark";
   };
   plugins = {
      godot.enable = true;
      godot.autoLoad = true;
      lspconfig.autoLoad = true;
      lualine.enable = true;
      lualine.autoLoad = true;
      smear-cursor.enable = true;
      smear-cursor.autoLoad = true;
      lint.enable = true;
      lint.autoLoad = true;
      neoscroll.enable = true;
      
      neoscroll.autoLoad = true;
      vim-surround.enable = true;
      telescope.autoLoad = true;
      noice.enable = true;
      noice.autoLoad = true;
      vim-surround.autoLoad = true;
      nix.enable = true;
      nix.autoLoad = true;
      dashboard.enable = true;
      dashboard.autoLoad = true;
      dashboard.settings = {
        change_to_vcs_root = true;
        config = {
          footer = [
            "Unbalanced forces perish in the void..."
          ];
          header = [
          "░██    ░██ ░██           ░██               ░██       ░███    ░██ ░██           "
          "░██    ░██               ░██               ░██       ░████   ░██               "
          "░██    ░██ ░██ ░███████  ░██  ░███████  ░████████    ░██░██  ░██ ░██░██    ░██ "
          "░██    ░██ ░██░██    ░██ ░██ ░██    ░██    ░██       ░██ ░██ ░██ ░██ ░██  ░██  "
          " ░██  ░██  ░██░██    ░██ ░██ ░█████████    ░██       ░██  ░██░██ ░██  ░█████   "
          "  ░██░██   ░██░██    ░██ ░██ ░██           ░██       ░██   ░████ ░██ ░██  ░██  "
          "   ░███    ░██ ░███████  ░██  ░███████      ░████    ░██    ░███ ░██░██    ░██ "
          "                                                                               "                                                                            
          ];
          mru = {
            limit = 20;
          };
          project = {
            enable = false;
          };
          shortcut = [
            {
              action = {
                __raw = "function(path) vim.cmd('Telescope find_files') end";
              };
              desc = "Files";
              group = "Label";
              icon = " ";
              icon_hl = "@variable";
              key = "f";
            }
            {
              action = "Telescope app";
              desc = " Apps";
              group = "DiagnosticHint";
              key = "a";
            }
            {
              action = "Telescope dotfiles";
              desc = " dotfiles";
              group = "Number";
              key = "d";
            }
          ];
        };
        theme = "hyper";
      };
      which-key = {
        enable = true;
        settings = {
          preset = "modern";
        };
      };
      lsp.enable = true;

      nix-develop.enable = true;
      comment.enable = true;
      web-devicons.enable = true;
      dotnet.enable = true;
      rustaceanvim = {
        enable = true;
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
      };
      roslyn.enable = true;
      roslyn.autoLoad = true;
      nvim-tree = {
        enable = true;
      };
      telescope.enable = true;
      treesitter.enable = true;
      gitsigns.enable = true;
    };
    keymaps = [
  # File tree
  {
    action = "<cmd>NvimTreeToggle<CR>";
    key = "<leader>e";
    mode = "n";
  }
  # Telescope
  {
    action = "<cmd>Telescope find_files<CR>";
    key = "<leader>ff";
    mode = "n";
  }
  {
    action = "<cmd>Telescope live_grep<CR>";
    key = "<leader>fg";
    mode = "n";
  }
  {
    action = "<cmd>Telescope buffers<CR>";
    key = "<leader>fb";
    mode = "n";
  }
  {
    action = "<cmd>Telescope diagnostics<CR>";
    key = "<leader>fd";
    mode = "n";
  }
  # Buffer navigation
  {
    action = "<cmd>bnext<CR>";
    key = "<Tab>";
    mode = "n";
  }
  {
    action = "<cmd>bprev<CR>";
    key = "<S-Tab>";
    mode = "n";
  }
  {
    action = "<cmd>bdelete<CR>";
    key = "<leader>x";
    mode = "n";
  }
  # Save
  {
    action = "<cmd>w<CR>";
    key = "<leader>w";
    mode = "n";
  }
  # Git
  {
    action = "<cmd>Gitsigns preview_hunk<CR>";
    key = "<leader>gp";
    mode = "n";
  }
  {
    action = "<cmd>Gitsigns stage_hunk<CR>";
    key = "<leader>gs";
    mode = "n";
  }
  {
    action = "<cmd>Gitsigns reset_hunk<CR>";
    key = "<leader>gr";
    mode = "n";
  }
  {
  action = "<cmd>q<CR>";
  key = "<leader>q";
  mode = "n";
  }
];
    lsp.inlayHints.enable = true;
    lsp.servers = {
      rust_analyzer.enable = true;
      omnisharp.enable = true;

      nil_ls.enable = true;
    };
  };
}
