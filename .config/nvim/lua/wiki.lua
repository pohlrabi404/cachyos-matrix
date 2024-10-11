-- Wiki templates
local function TemplateFallback(context)
    vim.api.nvim_buf_set_lines(0, 0, 0, false, {
        '# ' .. context.name,
        '',
        'Foobar'
    })
end

local wiki_templates = {
    {
        match_re = 'index',
        source_filename = '/home/user/templates/index.md'
    },
    {
        match_re = 'foo',
        source_filename = '.footemplate.md'
    },
    {
        match_func = function() return true end,  -- Always applies
        source_func = TemplateFallback
    }
}

-- Set the wiki templates in the global variable
vim.g.wiki_templates = wiki_templates
