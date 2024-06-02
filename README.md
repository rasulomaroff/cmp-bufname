# cmp-bufname

Buffer name completion source for `nvim-cmp`.

## Setup

```lua
require('cmp').setup {
  sources = {
    { name = 'bufname' }
  }
}
```

## Configuration

The following is a default configuration:

```lua
require('cmp').setup {
  sources = {
    {
      name = 'bufname',
      option = {
        -- use only current buffer for filename exractions
        current_buf_only = false,

        -- allows to configure what buffers to extract a filename from
        bufs = function()
          return vim.api.nvim_list_bufs()
        end,

        -- configure which entries you want to include in your completion:
        -- - you have to return a table of entries
        -- - empty string means skip that particular entry
        extractor = function(filename, full_path)
          return { filename:match '[^.]*'}
        end
      }
    }
  }
}
```
