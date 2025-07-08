require('mini.statusline').setup({
  use_icons = true, -- Enable icons (requires a patched font)
  set_vim_settings = true, -- Set `laststatus` to 2 and `showmode` to false

  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git           = MiniStatusline.section_git({ trunc_width = 75 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location      = MiniStatusline.section_location({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
        '%<', -- Mark truncation point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        vim.fn['codeium#GetStatusString'](),
        '%=', -- Align right
        -- { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                 strings = { location } },
      })
    end,

    inactive = function()
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      return MiniStatusline.combine_groups({
        { hl = 'MiniStatuslineInactive', strings = { filename } },
      })
    end,
  },
})
