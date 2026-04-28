return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      dockerfile = { "hadolint" },
      terraform = { "tflint" },
      tf = { "tflint" },
      ansible = { "ansible_lint" },
    }
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
