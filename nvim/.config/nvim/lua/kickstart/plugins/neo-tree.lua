-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  {{
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v3.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- icone dei file
        'MunifTanjim/nui.nvim',
      },
      config = function()
        require('neo-tree').setup {
          close_if_last_window = true,
          enable_git_status = true,
          enable_diagnostics = true,
          filesystem = {
            filtered_items = {
              visible = true, -- mostra i file nascosti
              hide_dotfiles = false,
              hide_gitignored = false,
            },
          },
          window = {
            width = 30,
            mappings = {
              ['<space>'] = 'none', -- disabilita spazio per espandere
            },
          },
        }
      end,
    },}
}
