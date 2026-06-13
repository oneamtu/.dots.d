-- Plugin configuration using lazy.nvim
return {
  -- Meta
  { "folke/lazy.nvim" },

  -- Theme
  {
    "altercation/vim-colors-solarized",
    config = function()
      vim.cmd("syntax enable")
      vim.opt.background = "dark"
      vim.opt.termguicolors = false
      vim.cmd("colorscheme solarized")
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

  -- UI
  { "Lokaltog/vim-powerline" },
  { "vim-syntastic/syntastic" },

  -- Editing
  { "tpope/vim-abolish" },
  { "tpope/vim-surround" },
  { "tpope/vim-endwise" },
  { "ervandew/supertab" },
  { "scrooloose/nerdcommenter" },
  { "Raimondi/delimitMate" },
  { "mg979/vim-visual-multi" },
  { "vim-scripts/YankRing.vim" },

  -- Snippets
  { "honza/vim-snippets" },

  -- Navigating
  {
    "ctrlpvim/ctrlp.vim",
    config = function()
      vim.g.ctrlp_show_hidden = 1
      vim.g.ctrlp_extensions = { "cmdline", "yankring", "menu" }
      vim.g.ctrlp_user_command = 'rg %s --files --color=never --hidden --glob "!.git/*"'
      vim.g.ctrlp_use_caching = 0
      vim.g.ctrlp_tjump_only_silent = 1

      vim.keymap.set("n", "<Leader>f", ":CtrlP<CR>", { silent = true })
      vim.keymap.set("n", "<c-]>", ":CtrlPtjump<cr>", { noremap = true })
      vim.keymap.set("v", "<c-]>", ":CtrlPtjumpVisual<cr>", { noremap = true })
    end,
  },
  { "sgur/ctrlp-extensions.vim" },
  { "ivalkeen/vim-ctrlp-tjump" },
  { "bkad/CamelCaseMotion" },
  { "chaoren/vim-wordmotion" },
  { "easymotion/vim-easymotion" },
  { "christoomey/vim-tmux-navigator" },
  {
    "yegappan/grep",
    config = function()
      vim.g.Grep_Default_Options = "--color=never"
      vim.g.Grep_Skip_Files = "*.bak *~"
      vim.g.Grep_Skip_Dirs = ".git .hg .svn"
    end,
  },
  { "preservim/tagbar" },
  {
    "benmills/vimux",
    config = function()
      vim.g.vroom_use_vimux = 1
      vim.g.vroom_use_zeus = 1
      vim.g.vroom_clear_screen = 0

      vim.cmd([[
        function! VimuxSlime()
          call VimuxSendText(@v)
        endfunction
      ]])

      vim.keymap.set("v", "<Leader>vs", '"vy :call VimuxSlime()<CR>')
      vim.keymap.set("v", "<Leader>sms", '"vy :call VimuxSlime()<CR>')
      vim.keymap.set("n", "<Leader>sms", '"vy :call VimuxSlime()<CR>')
    end,
  },

  -- Universal language file rules
  { "editorconfig/editorconfig-vim" },

  -- Syntax & Languages
  {
    "elzr/vim-json",
    config = function()
      vim.g.vim_json_syntax_conceal = 0
    end,
  },
  { "fatih/vim-go" },
  {
    "rust-lang/rust.vim",
    ft = "rust",
  },
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
  { "tmux-plugins/vim-tmux" },
  { "ekalinin/Dockerfile.vim" },
  { "vim-scripts/tpp.vim" },
  { "pangloss/vim-javascript" },
  { "mxw/vim-jsx" },

  -- Ruby
  { "tpope/vim-bundler" },
  { "vim-ruby/vim-ruby" },
  { "tpope/vim-rake" },
  {
    "AndrewRadev/splitjoin.vim",
    config = function()
      vim.keymap.set("n", "<Leader>j", ":SplitjoinJoin<cr>")
      vim.keymap.set("n", "<Leader>k", ":SplitjoinSplit<cr>")
    end,
  },
  { "jgdavey/vim-blockle" },
  { "kana/vim-textobj-user" },
  {
    "nelstrom/vim-textobj-rubyblock",
    dependencies = { "kana/vim-textobj-user" },
  },
  { "ecomba/vim-ruby-refactoring" },
  { "skalnik/vim-vroom" },
  {
    "tpope/vim-rails",
    config = function()
      vim.g.rails_projections = {
        ["spec/features/*s_spec.rb"] = {
          command = "feature",
          affinity = "view",
        },
      }
      vim.g.rails_gem_projections = {
        factory_girl_rails = {
          ["spec/factories/*.rb"] = {
            command = "factory",
            affinity = "model",
            alternate = "app/models/{}.rb",
            related = "db/schema.rb#{plural}",
            test = "spec/models/{}_spec.rb",
            template = "FactoryGirl.create(:{})",
          },
        },
      }

      -- Ruby debugging
      vim.keymap.set("n", "<Leader>d", "obinding.pry<Esc>", { silent = true })
      -- Ruby list newline expansion
      vim.keymap.set("n", "<Leader>h", '$v%lohc<CR><CR><Up><C-r>"<Esc>:s/,/,\\r/g<CR>:\'[,\']norm ==<CR>\']\'')
    end,
  },
  { "KurtPreston/vim-autoformat-rails" },

  -- Crystal
  { "vim-crystal/vim-crystal" },

  -- Clojure
  { "guns/vim-clojure-static" },
  { "tpope/vim-fireplace" },
  { "tpope/vim-classpath" },

  -- LaTeX
  { "lervag/vimtex" },

  -- Other
  { "MikeDacre/tmux-zsh-vim-titles" },
  { "tpope/vim-dispatch" },
  {
    "jceb/vim-orgmode",
    config = function()
      vim.g.org_agenda_files = { "~/org/work.org" }
    end,
  },
  { "tpope/vim-speeddating" },
  { "freitass/todo.txt-vim" },

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

        -- Setup solargraph for Ruby
        vim.lsp.config.solargraph = {
          cmd = { vim.fn.expand("$HOME/.asdf/shims/solargraph"), "stdio" },
          filetypes = { "ruby" },
          root_markers = { "Gemfile", ".git" },
          capabilities = default_capabilities,
        }
        vim.lsp.enable("solargraph")

        -- Setup rust-analyzer
        vim.lsp.config.rust_analyzer = {
          cmd = { "rust-analyzer" },
          filetypes = { "rust" },
          root_markers = { "Cargo.toml", ".git" },
          capabilities = default_capabilities,
        }
        vim.lsp.enable("rust_analyzer")

        -- Setup gopls for Go
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

        lspconfig.solargraph.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { vim.fn.expand("$HOME/.asdf/shims/solargraph"), "stdio" },
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
