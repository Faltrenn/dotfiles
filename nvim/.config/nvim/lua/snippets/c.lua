local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

local ifd_snippet = s("ifd", {
  t("#if !defined("),
  f(function(args)
    return "LAMP_" .. string.upper(args[1][1]) .. "_TYPE"
  end, { 1 }),
  t({ ")", "" }),

  t({ "typedef struct {", "" }),
  t("\t"), i(2, "* struct data */"),
  t({"", "} "}),
  i(1, "/* struct name */"),
  t(";"),

  t({ "", "#define " }),
  f(function(args)
    return "LAMP_" .. string.upper(args[1][1]) .. "_TYPE"
  end, { 1 }),

  t({ "", "#endif" }),
})

ls.add_snippets("c",   { ifd_snippet })
ls.add_snippets("cpp", { ifd_snippet })
