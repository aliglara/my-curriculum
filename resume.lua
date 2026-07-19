local contact_list_seen = false

local function joined_items(items, separator)
  local content = pandoc.Inlines({})
  for index, item in ipairs(items) do
    if index > 1 then
      content:extend(separator)
    end
    for _, block in ipairs(item) do
      if block.content then
        for _, inline in ipairs(block.content) do
          content:insert(inline)
        end
      end
    end
  end
  return content
end

function BulletList(list)
  if contact_list_seen then
    return nil
  end
  contact_list_seen = true

  local separator = pandoc.Inlines({
    pandoc.Space(),
    pandoc.Str("•"),
    pandoc.Space(),
  })
  local paragraph = pandoc.Para(joined_items(list.content, separator))

  if FORMAT:match("latex") then
    return {
      pandoc.RawBlock("latex", "\\begin{center}"),
      paragraph,
      pandoc.RawBlock("latex", "\\end{center}"),
    }
  end

  if FORMAT:match("docx") then
    return pandoc.Div(
      {paragraph},
      pandoc.Attr("", {}, {{"custom-style", "Contact"}})
    )
  end
end

function Header(header)
  if header.level ~= 3 or #header.content < 3 then
    return nil
  end

  for index, inline in ipairs(header.content) do
    if inline.t == "Space" then
      if FORMAT:match("latex") then
        header.content[index] = pandoc.RawInline("latex", "\\hfill{}")
      elseif FORMAT:match("docx") then
        header.content[index] = pandoc.RawInline(
          "openxml",
          '<w:r><w:tab/></w:r>'
        )
      end
      break
    end
  end
  return header
end
