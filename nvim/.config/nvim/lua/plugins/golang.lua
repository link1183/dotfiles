return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "golangci-lint" } },
      },
    },
    opts = function(_, opts)
      local lint = require("lint")

      -- modify existing golangci-lint args to avoid exit code 3 warnings
      if lint.linters.golangcilint and lint.linters.golangcilint.args then
        table.insert(lint.linters.golangcilint.args, "--issues-exit-code=0")
      end

      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.go = { "golangcilint" }
    end,
  },
}
