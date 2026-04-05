{
  lib,
  config,
  pkgs,
  ...
}:
{
  # TODO: Refactor this as neotest is supported on nixvim now
  options = {
    neotest.enable = lib.mkEnableOption "Enable neotest module";
  };
  config = lib.mkIf config.neotest.enable {
    plugins = {
      neotest = {
        enable = true;
        adapters = {
          java.enable = true;
          python.enable = true;
          vitest.enable = true;
          plenary.enable = true;
        };
        settings = {
          output = {
            enabled = true;
            open_on_run = true;
          };
          summary = {
            enabled = true;
          };
        };
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      FixCursorHold-nvim
      nvim-nio
    ];
    keymaps = [
      {
        mode = "n";
        key = "<leader>Tt";
        action = "<cmd>lua require('neotest').run.run(vim.fn.expand '%')<CR>";
        options = {
          desc = "Run File";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>TT";
        action = "<cmd>lua require('neotest').run.run(vim.loop.cwd())<CR>";
        options = {
          desc = "Run All Test Files";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>Tr";
        action = "<cmd>lua require('neotest').run.run()<CR>";
        options = {
          desc = "Run Nearest";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>Td";
        action = "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>";
        options = {
          desc = "Run Nearest with debugger";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>Ts";
        action = "<cmd>lua require('neotest').summary.toggle()<CR>";
        options = {
          desc = "Toggle Summary";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>To";
        action = "<cmd>lua require('neotest').output.open{ enter = true, auto_close = true }<CR>";
        options = {
          desc = "Show Output";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>TO";
        action = "<cmd>lua require('neotest').output_panel.toggle()<CR>";
        options = {
          desc = "Toggle Output Panel";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>TS";
        action = "<cmd>lua require('neotest').run.stop()<CR>";
        options = {
          desc = "Stop";
          silent = true;
        };
      }
    ];
  };
}
