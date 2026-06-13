-- Plugin configuration using lazy.nvim
return {
  -- Meta
  { "folke/lazy.nvim" },

  -- Theme: solarized8 (truecolor, treesitter & LSP-aware)
  {
    "lifepillar/vim-solarized8",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("syntax enable")
      vim.opt.termguicolors = true   -- 24-bit color so treesitter highlighting pays off
      vim.opt.background = "dark"
      pcall(vim.cmd, "colorscheme solarized8")
    end,
  },

  -- Claude Code integration
  {
    "coder/claudecode.nvim",
    config = function()
      require("claudecode").setup()
    end,
  },

  -- Git
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "airblade/vim-gitgutter" },

  -- UI: statusline (replaces vim-powerline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({ options = { theme = "solarized_dark" } })
    end,
  },

  -- Editing
  { "tpope/vim-abolish" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },           -- '.' support for surround/abolish
  { "Raimondi/delimitMate" },
  { "mg979/vim-visual-multi" },
  -- replaces nerdcommenter (gcc / gc)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Navigating (Telescope replaces ctrlp + yegappan/grep)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<Leader>f", builtin.find_files, { silent = true })
      vim.keymap.set("n", "<Leader>b", builtin.buffers, { silent = true })
      vim.keymap.set("n", "<Leader>]", builtin.tags, { silent = true })
      vim.keymap.set("n", "gr", builtin.lsp_references, { silent = true })
    end,
  },
  { "chaoren/vim-wordmotion" },     -- replaces CamelCaseMotion
  { "easymotion/vim-easymotion" },
  { "christoomey/vim-tmux-navigator" },

  -- Universal language file rules
  { "editorconfig/editorconfig-vim" },

  -- Syntax & highlighting (treesitter covers C/C++, XML, and the langs below)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "cpp", "xml", "lua", "vim", "vimdoc",
          "go", "rust", "json", "markdown", "bash",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  -- XML/HTML tag auto-close & edit
  { "sukima/xmledit" },

  -- Language tooling (LSP/diagnostics handled by nvim-lspconfig below)
  {
    "elzr/vim-json",
    config = function()
      vim.g.vim_json_syntax_conceal = 0
    end,
  },
  { "fatih/vim-go", build = ":GoUpdateBinaries" },
  { "rust-lang/rust.vim", ft = "rust" },
  {
    "racer-rust/vim-racer",
    ft = "rust",
    config = function()
      vim.g.racer_experimental_completer = 1
    end,
  },
  { "ARM9/arm-syntax-vim" },
  { "vim-pandoc/vim-pandoc" },
  { "vim-pandoc/vim-pandoc-syntax" },

  -- Other
  { "MikeDacre/tmux-zsh-vim-titles" },
  { "tpope/vim-dispatch" },

  -- LSP & Completion
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Check if we're on nvim 0.11+ with new API
      local has_new_lsp = vim.fn.has('nvim-0.11') == 1

      if has_new_lsp then
        -- Use new nvim 0.11+ API
        local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Setup keybindings on LSP attach
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local opts = { buffer = args.buf, silent = true }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
          end,
        })

        -- C/C++ via clangd (install: apt install clangd / brew install llvm)
        vim.lsp.config.clangd = {
          cmd = { "clangd" },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
          root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
          capabilities = default_capabilities,
        }
        vim.lsp.enable("clangd")

        -- rust-analyzer
        vim.lsp.config.rust_analyzer = {
          cmd = { "rust-analyzer" },
          filetypes = { "rust" },
          root_markers = { "Cargo.toml", ".git" },
          capabilities = default_capabilities,
        }
        vim.lsp.enable("rust_analyzer")

        -- gopls
        vim.lsp.config.gopls = {
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_markers = { "go.mod", ".git" },
          capabilities = default_capabilities,
        }
        vim.lsp.enable("gopls")
      else
        -- Fallback to old API for older neovim versions
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local on_attach = function(client, bufnr)
          local opts = { buffer = bufnr, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
        end

        lspconfig.clangd.setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })

        lspconfig.rust_analyzer.setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })

        lspconfig.gopls.setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
