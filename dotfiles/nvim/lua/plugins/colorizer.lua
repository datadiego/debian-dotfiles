return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local colorizer = require("colorizer")

    colorizer.setup({
      "*",
    })

    -- auto attach
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        colorizer.attach_to_buffer(0)
      end,
    })
  end,
}
