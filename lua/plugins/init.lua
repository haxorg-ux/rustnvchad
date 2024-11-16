return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    lazy = false, -- Esto fuerza la carga del plugin
    config = function()
      require("mason-tool-installer").setup {

        -- start
        ensure_installed = {

          -- you can pin a tool to a particular version
          -- { 'golangci-lint', version = 'v1.47.0' },

          -- you can turn off/on auto_update per tool
          { "bash-language-server", auto_update = true },

          -- 'lua-language-server',
          -- 'vim-language-server',
          "gopls",
          -- 'stylua',
          -- 'shellcheck',
          -- 'editorconfig-checker',
          "gofumpt",
          "golines",
          -- 'gomodifytags',
          "gotests",
          -- 'impl',
          -- 'json-to-struct',
          -- 'luacheck',
          -- 'misspell',
          -- 'revive',
          -- 'shellcheck',
          -- 'shfmt',
          -- 'staticcheck',
          -- 'vint',
          --
          "basedpyright",
          "isort",
          "black",
          "clangd",
          "prettier",
          "rust-analyzer",
          "codelldb",
          "typescript-language-server",
        },

        auto_update = false,

        -- Default: true
        run_on_start = true,

        -- Default: 0
        -- start_delay = 3000, -- 3 second delay

        -- Default: nil
        -- debounce_hours = 5, -- at least 5 hours between attempts to install/update

        -- doing lazy loading.
        -- integrations = {
        --   -- ["mason-lspconfig"] = true,
        --   -- ['mason-null-ls'] = true,
        --   -- ['mason-nvim-dap'] = true,
        -- },
      }
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function()
      local mason_registry = require "mason-registry"
      local codelldb = mason_registry.get_package "codelldb"
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      -- If you are on Linux, replace the line above with the line below:
      -- local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      local cfg = require "rustaceanvim.config"

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      -- Configurar codelldb como adaptador para Rust
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}", -- DAP asignará un puerto aleatorio
        executable = {
          command = vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/adapter/codelldb", -- Cambia esta ruta si es necesario
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.rust = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      local dapui = require "dapui"
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      }
      require("cmp").setup.buffer {
        sources = { { name = "crates" } },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require "nvim-treesitter.configs"
      config.setup {
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
}
