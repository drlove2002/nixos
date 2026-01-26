local function math()
  return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

return {

  --autotrigger greek letters, with choice nodes for pi/phi, epsilon/eta, tau/theta...
  s({ trig = ";a", snippetType = "autosnippet", desc = "alpha", wordTrig = false }, {
    t("\\alpha"),
  }, { condition = math }),
  s({ trig = ";b", snippetType = "autosnippet", desc = "beta", wordTrig = false }, {
    t("\\beta"),
  }, { condition = math }),
  s({ trig = ";B", snippetType = "autosnippet", desc = "Beta", wordTrig = false }, {
    t("\\Beta"),
  }, { condition = math }),
  s({ trig = ";g", snippetType = "autosnippet", desc = "gamma", wordTrig = false }, {
    t("\\gamma"),
  }, { condition = math }),
  s({ trig = ";G", snippetType = "autosnippet", desc = "Gamma", wordTrig = false }, {
    t("\\Gamma"),
  }, { condition = math }),
  s({ trig = ";d", snippetType = "autosnippet", desc = "delta", wordTrig = false }, {
    t("\\delta"),
  }, { condition = math }),
  s({ trig = ";D", snippetType = "autosnippet", desc = "Delta", wordTrig = false }, {
    t("\\Delta"),
  }, { condition = math }),
  s({ trig = ";z", snippetType = "autosnippet", desc = "zeta", wordTrig = false }, {
    t("\\zeta"),
  }, { condition = math }),
  s({ trig = ";k", snippetType = "autosnippet", desc = "kappa", wordTrig = false }, {
    t("\\kappa"),
  }, { condition = math }),
  s({ trig = ";l", snippetType = "autosnippet", desc = "lambda", wordTrig = false }, {
    t("\\lambda"),
  }, { condition = math }),
  s({ trig = ";m", snippetType = "autosnippet", desc = "mu", wordTrig = false }, {
    t("\\mu"),
  }, { condition = math }),
  s({ trig = ";n", snippetType = "autosnippet", desc = "nu", wordTrig = false }, {
    t("\\nu"),
  }, { condition = math }),
  s({ trig = ";x", snippetType = "autosnippet", desc = "xi", wordTrig = false }, {
    t("\\xi"),
  }, { condition = math }),

  s({ trig = ";r", snippetType = "autosnippet", desc = "rho", wordTrig = false }, {
    t("\\rho"),
  }, { condition = math }),
  s({ trig = ";s", snippetType = "autosnippet", desc = "sigma", wordTrig = false }, {
    t("\\sigma"),
  }, { condition = math }),
  s({ trig = ";c", snippetType = "autosnippet", desc = "chi", wordTrig = false }, {
    t("\\chi"),
  }, { condition = math }),
  s({ trig = ";w", snippetType = "autosnippet", desc = "omega", wordTrig = false }, {
    t("\\omega"),
  }, { condition = math }),
  s({ trig = ";W", snippetType = "autosnippet", desc = "Omega", wordTrig = false }, {
    t("\\Omega"),
  }, { condition = math }),
  s({ trig = ";t", snippetType = "autosnippet", desc = "tau", wordTrig = false }, {
    t("\\tau"),
  }, { condition = math }),
  s({ trig = "\\tauh", snippetType = "autosnippet", desc = "theta", wordTrig = false }, {
    t("\\theta"),
  }, { condition = math }),
  s({ trig = ";e", snippetType = "autosnippet", desc = "epsilon", wordTrig = false }, {
    t("\\epsilon"),
  }, { condition = math }),
  s({ trig = "\\epsilont", snippetType = "autosnippet", desc = "eta", wordTrig = false }, {
    t("\\eta"),
  }, { condition = math }),

  s({ trig = ";p", snippetType = "autosnippet", desc = "pi", wordTrig = false }, {
    t("\\pi"),
  }, { condition = math }),
  s({ trig = "\\pih", snippetType = "autosnippet", desc = "phi", wordTrig = false }, {
    t("\\phi"),
  }, { condition = math }),
  s({ trig = "\\pis", snippetType = "autosnippet", desc = "psi", wordTrig = false }, {
    t("\\psi"),
  }, { condition = math }),
}

