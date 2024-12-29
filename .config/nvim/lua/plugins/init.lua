return {
---------- Telescope ----------
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("configs.telescope")
      require("telescope").load_extension "file_browser"
    end
  },

  "nvim-telescope/telescope-file-browser.nvim",

  { 
    'nvim-telescope/telescope-fzf-native.nvim', 
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' 
  },

---------- Base16 Color ----------
  "RRethy/base16-nvim",

---------- Treesitter ----------
  "nvim-treesitter/nvim-treesitter",
}
