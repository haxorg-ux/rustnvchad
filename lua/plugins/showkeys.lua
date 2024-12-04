return {
  "siduck/showkeys",
  cmd = "ShowkeysToggle",
  opts = {
    timeout = 1,
    maxkeys = 5,
    -- more opts
  },
  keys = {
    { "<leader>gg", "<cmd>ShowkeysToggle<cr>", mode = { "n" }, desc = "Toogle Showkeys" },
  },
}
