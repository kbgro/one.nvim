vim.keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
vim.keymap.set("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

return {
          ---@return string | nil commentstring If found, otherwise `nil`
          pre_hook = function(ctx)
            -- Only calculate commentstring for tsx filetypes
            if vim.bo.filetype == "typescriptreact" then
              local U = require "Comment.utils"

              -- Determine the location where to calculate commentstring from
              local location = nil
              if ctx.ctype == U.ctype.blockwise then
                location = require("ts_context_commentstring.utils").get_cursor_location()
              elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                location = require("ts_context_commentstring.utils").get_visual_start_location()
              end

              return require("ts_context_commentstring.internal").calculate_commentstring {
                key = type,
                location = location,
              }
            end
            return nil
          end,

}
