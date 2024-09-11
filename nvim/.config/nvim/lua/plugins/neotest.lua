return {
  {
    "nvim-neotest/neotest",
    version = "*",
    optional = true,
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
      },
    },
  },
}
