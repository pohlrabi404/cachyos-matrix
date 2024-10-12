-- Wiki templates
local wiki_templates = {
    -- Use this when wanting to add new templates or something
    {
        match_re = 'index',
        source_filename = '/home/pohlrabi/wiki/templates/index.md'
    },
    {
        match_func = function() return true end,  -- Always applies
        source_filename = '/home/pohlrabi/wiki/templates/default.md' 
    }
}
-- Set the wiki templates in the global variable
vim.g.wiki_templates = wiki_templates

vim.g.wiki_root = '~/wiki/knowledge'
