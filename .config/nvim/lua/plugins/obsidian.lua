require("obsidian").setup({
  workspaces = {
    {
      name = "wiki",
      path = "~/vaults/wiki",
      overrides = {
        notes_subdir = "knowledge",
        new_notes_location = "notes_subdir",
      },
    },
  },
  -- Id generate
  note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
  end,

  -- Frontmatter setting
  note_frontmatter_func = function(note)
    if note.title then
      note:add_alias(note.title)
    end
    local out = {
      id = note.id,
      aliases = note.aliases,
      tags = note.tags,
    }
    out.date = os.date("%Y-%m-%d")
    out.time = os.date("%H:%M:%S")
    out.author = "Pohlrabi"
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end

    return out
  end,

  -- Save when open new note
  callbacks = {
    leave_note = function(client, note)
      note:save()
    end,
  },
})