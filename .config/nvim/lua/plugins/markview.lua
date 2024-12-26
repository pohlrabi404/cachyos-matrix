require("markview").setup()
require("markview.extras.editor").setup({
    --- The minimum & maximum window width
    --- If the value is smaller than 1 then
    --- it is used as a % value.
    ---@type [ number, number ]
    width = { 10, 0.75 },

    --- The minimum & maximum window height
    ---@type [ number, number ]
    height = { 3, 0.75 },

    --- Delay(in ms) for window resizing
    --- when typing.
    ---@type integer
    debounce = 50,

    --- Callback function to run on
    --- the floating window.
    ---@type fun(buf:integer, win:integer): nil
    callback = function (buf, win)
    end
});

local presets = require("markview.presets").headings;

require("markview").setup({
    headings = presets.arrowed
});
