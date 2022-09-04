local ls = require("luasnip")

ls.snippets = {
  javascript = {
    ls.parser.parse_snippet("cl", "console.log($1)"),
    ls.parser.parse_snippet("db", "console.log($1, '\x1b[33m', '$TM_FILENAME:$TM_LINE_NUMBER', '\x1b[0m')"),
    ls.parser.parse_snippet("ca", "const $1 = ($2) => $3"),
    ls.parser.parse_snippet("cf", "const $1 = function($2) {\n  $3\n}"),
    ls.parser.parse_snippet("caf", "const $1 = async function($2) {\n  $3\n}"),
    ls.parser.parse_snippet("f", "function $1($2) {\n  $3\n}"),
    ls.parser.parse_snippet("af", "async function $1($2) {\n  $3\n}"),
    ls.parser.parse_snippet("caa", "const $1 = async ($2) => $3"),
    ls.parser.parse_snippet("co", "const $1 = {\n  $2\n}"),
    ls.parser.parse_snippet("a", "($1) => $2"),
    ls.parser.parse_snippet("s", "{\n  $1\n}"),
    ls.parser.parse_snippet("fof", "for (const $1 of $2) $3"),
    ls.parser.parse_snippet("fin", "for (const $1 in $2) $3"),
    ls.parser.parse_snippet("if", "if ($1) $2"),
    ls.parser.parse_snippet("eif", "else if ($1) $2"),
    ls.parser.parse_snippet("try", "try {\n  $1\n} catch(${2:err}) {\n  $3\n}"),
    ls.parser.parse_snippet("r", "return $1"),
  }
}

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function() return {os.date('%Y-%m-%d')} end

ls.add_snippets(nil, {
    all = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(date, {}),
        }),
    },
})
