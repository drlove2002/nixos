-- ----------------------------------------------------------------------------
--test whether the parent snippet has content from a visual selection. If yes, put into a text  node, if no then start an insert node
local visualSelectionOrInsert = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, t(parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {

  s(
    { trig = "textbf", dscr = "the textbf command, either in insert mode or wrapping a visual selection" },
    fmta("\\textbf{<>}", {
      d(1, visualSelectionOrInsert),
    })
  ),
  s(
    { trig = "emph", dscr = "the emph command, either in insert mode or wrapping a visual selection" },
    fmta("\\emph{<>}", {
      d(1, visualSelectionOrInsert),
    })
  ),

  s(
    { trig = "href", snippetType = "snippet", dscr = "href with placeholders to remind you of the order" },
    fmta([[\href{<>}{<>}]], {
      i(1, "url"),
      i(2, "display name"),
    })
  ),

  --autotrigger latex quotation marks
  s(
    { trig = "quote", snippetType = "snippet", desc = "quotation marks (enquote)" },
    fmta([[\enquote{<>}]], {
      i(1, "text"),
    })
  ),
}
