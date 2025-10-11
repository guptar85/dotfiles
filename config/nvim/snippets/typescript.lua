local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- 🧾 Basic console.log
  s("cl", fmt("console.log('{}', {});", { i(1, "label"), i(2, "value") })),

  -- 🧠 Log typeof
  s("clt", fmt("console.log('{}', typeof {});", { i(1, "label"), i(2, "variable") })),

  -- 🧩 JSON stringify log
  s("clj", fmt("console.log('{}:', JSON.stringify({}, null, 2));", { i(1, "objLabel"), i(2, "obj") })),

  -- ⚙️ Function entry/exit
  s("clf", fmt(
    [[
console.log('➡️ Entering {}()');
{}
console.log('⬅️ Exiting {}()');
]],
    { i(1, "functionName"), i(2, "-- code here"), i(1) }
  )),

  -- 🕒 Timestamped log
  s("clts", fmt("console.log(`[${{new Date().toISOString()}}] {}:`, {});", { i(1, "label"), i(2, "data") })),

  -- 🧨 Try/Catch
  s("try", fmt(
    [[
try {{
  {}
}} catch (error) {{
  console.error('❌ Error in {}:', error);
}}
]],
    { i(1, "-- code"), i(2, "functionName") }
  )),

  -- 🚀 Async function template
  s("async", fmt(
    [[
async function {}({}) {{
  try {{
    {}
  }} catch (error) {{
    console.error('❌ Error in async {}:', error);
  }}
}}
]],
    { i(1, "fetchData"), i(2, "params"), i(3, "-- code"), i(1) }
  )),

  -- 🪶 TODO marker
  s("todo", fmt("-- TODO: {}", { i(1, "describe what to fix") })),
}
