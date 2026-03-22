return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  enable = "false",
  lazy = false,
  version = false,
  opts = {
    -- Default to Gemini for heavy coding and context reading
    provider = "gemini",
    auto_suggestions_provider = "gemini",

    providers = {
      gemini = {
        -- model = "gemini-2.5-pro",
        model = "gemini-2.5-flash",
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },

      -- NEW: Perplexity Integration
      perplexity = {
        __inherited_from = "openai",
        api_key_name = "PERPLEXITY_API_KEY",
        endpoint = "https://api.perplexity.ai",
        model = "sonar-pro", -- Perplexity's flagship search/reasoning model
      },
    },

    -- Workflow Behaviors
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
    },
  },

  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",

    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
          use_absolute_path = true,
        },
      },
    },

    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

