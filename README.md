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

By default, `cmp-bufname` will use file names from all opened buffers. If you only want use a file name of a current buffer, then use the following config:

```lua
require('cmp').setup {
  sources = {
    {
      name = 'bufname',
      option = {
        current_buf_only = true
      }
    }
  }
}
```
