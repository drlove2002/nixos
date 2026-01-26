-- use vimtex to determine if we are in a math context
local function math()
  return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

return {

  s({ trig = ";O", snippetType = "autosnippet", desc = "mathcal O", wordTrig = false }, {
    t("\\mathcal{O}"),
  }, { condition = math }),
  s({ trig = ";i", snippetType = "autosnippet", desc = "infinity", wordTrig = false }, {
    t("\\infty"),
  }, { condition = math }),
  s({ trig = ";N", snippetType = "autosnippet", desc = "nabla", wordTrig = false }, {
    t("\\nabla"),
  }, { condition = math }),
  s({ trig = "div", snippetType = "autosnippet", desc = "nabla", wordTrig = false }, {
    t("\\nabla\\cdot"),
  }, { condition = math }),
  s({ trig = "grad", snippetType = "autosnippet", desc = "gradient", wordTrig = false }, {
    t("\\nabla"),
  }, { condition = math }),
  s({ trig = "curl", snippetType = "autosnippet", desc = "curl", wordTrig = false }, {
    t("\\nabla\\times"),
  }, { condition = math }),
  s(
    { trig = ";I", snippetType = "autosnippet", desc = "integral with infinite or inserted limits", wordTrig = false },
    fmta(
      [[
            <>
            ]],
      {
        c(1, {
          t("\\int_{-\\infty}^\\infty", { key = "integral over all reals" }),
          sn(nil, fmta([[ \int_{<>}^{<>} ]], { i(1), i(2) }), { key = "integral with insert-node limits" }),
        }),
      }
    )
  ),
  --postfixes for vectors, hats, etc. The match pattern is '\\' plus the default (so that hats get put on greek letters, etc)
  postfix(
    {
      trig = "hat",
      match_pattern = [[[\\%w%.%_%-%"%']+$]],
      snippetType = "autosnippet",
      dscr = "postfix hat when in math mode",
    },
    { l("\\hat{" .. l.POSTFIX_MATCH .. "}") },
    { condition = math }
  ),
  postfix(
    {
      trig = "vec",
      match_pattern = [[[\\%w%.%_%-%"%']+$]],
      snippetType = "autosnippet",
      dscr = "postfix vec when in math mode",
    },
    { l("\\vec{" .. l.POSTFIX_MATCH .. "}") },
    { condition = math }
  ),

  postfix(
    { trig = "df", snippetType = "autosnippet", desc = "postfix differential (physics package)" },
    { l("\\d{" .. l.POSTFIX_MATCH .. "}") },
    { condition = math }
  ),
  postfix(
    { trig = "diff", snippetType = "autosnippet", desc = "postfix differential (physics package)" },
    { l("\\dd{" .. l.POSTFIX_MATCH .. "}") },
    { condition = math }
  ),
}

