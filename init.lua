return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "nord",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    config = {
       clangd = {
         capabilities = {
           offsetEncoding = "utf-8",
         },
       }, -- customize lsp formatting options
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true,     -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    vim.filetype.add {
      extension = {
        td = "tablegen",
      },
      filename = {
        ["Jenkinsfile"] = "groovy",
        [".clangd"] = "yaml",
      },
      -- pattern = {
      --   ["~/%.config/foo/.*"] = "fooscript",
      -- },
    }
    vim.opt.shiftwidth = 4
    vim.opt.smarttab = true
    vim.opt.expandtab = true
    -- Set persistent undo
    if vim.fn.has('persistent_undo') == 1 then
      local target_path = vim.fn.expand('~/.config/vim-persisted-undo/')
      if vim.fn.isdirectory(target_path) == 0 then
        os.execute('mkdir -p ' .. target_path)
      end
      vim.opt.undodir = target_path
      vim.opt.undofile = true
      local opt = vim.opt

      opt.foldmethod = "expr"
      opt.foldexpr = "nvim_treesitter#foldexpr()"
    end -- }
  end,
}
