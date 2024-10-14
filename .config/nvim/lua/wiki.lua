local g = vim.g
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
g.wiki_templates = wiki_templates
g.wiki_root = '~/wiki/knowledge'
g.wiki_select_method = {
  pages = require('wiki.telescope').pages,
  tags = require('wiki.telescope').tags,
  toc = require('wiki.telescope').toc,
  links = require('wiki.telescope').links,
}

