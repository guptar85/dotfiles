local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- 🕒 Auto insert today's date
local function today()
  return os.date("%Y-%m-%d")
end

return {
  -- 🧭 Daily Note Header
  s("daily", fmt(
    [[
# 🗓️ Daily Notes — {}

## ✅ Top Priorities
- [ ] {}

## 🧠 Focus Area
{}

## 🕒 Meetings / Calls
- {}

## 💭 Reflections
{}
]],
    {
      f(today, {}),
      i(1, "Key task"),
      i(2, "Main topic or goal"),
      i(3, "Meeting name / with whom"),
      i(4, "What went well / what to improve"),
    }
  )),

  -- 📋 Project Note Template
  s("project", fmt(
    [[
# 🚀 Project: {}

**Status:** {}
**Owner:** {}
**Last Updated:** {}

---

## 🎯 Objectives
- [ ] {}

## 📈 Progress
{}

## 🧩 Blockers / Risks
{}

## 🗂️ References
- {}
]],
    {
      i(1, "Project Name"),
      i(2, "In Progress / Completed"),
      i(3, "Rahul G."),
      f(today, {}),
      i(4, "Main deliverable"),
      i(5, "What has been achieved so far"),
      i(6, "Challenges / dependencies"),
      i(7, "Link to doc / Jira / wiki"),
    }
  )),

  -- 🤝 Meeting Notes
  s("meet", fmt(
    [[
# 🤝 Meeting: {}

**Date:** {}
**Attendees:** {}
**Topic:** {}

---

## 🗒️ Discussion Points
- {}

## 🎯 Action Items
- [ ] {} — **Owner:** {} (Due: {})

## 💡 Decisions
- {}

## 🧩 Next Steps
{}
]],
    {
      i(1, "Meeting name"),
      f(today, {}),
      i(2, "Rahul, Team"),
      i(3, "Main theme / topic"),
      i(4, "Main discussion points"),
      i(5, "Action item"),
      i(6, "Assignee"),
      i(7, "Due date"),
      i(8, "Key decisions made"),
      i(9, "Follow-up tasks"),
    }
  )),

  -- 📚 Wiki Page Template
  s("wiki", fmt(
    [[
# 📘 {}

## 🧭 Overview
{}

## 🧩 Key Concepts
- {}

## 🧱 Architecture / Flow
{}

## 🧠 Learnings
{}

## 🔗 References
- {}
]],
    {
      i(1, "Topic Title"),
      i(2, "What this page is about"),
      i(3, "Main ideas / components"),
      i(4, "System flow / diagram summary"),
      i(5, "Insights / takeaways"),
      i(6, "Links / resources"),
    }
  )),

  -- 🔖 Bookmark Table Entry (available in all Markdown files)
  s("bkm", fmt(
    [[
| [{}]({}) | {} | {} | {} |
]],
    {
      i(1, "Title / Label"),
      i(2, "https://"),
      f(function()
        return os.date("%d-%b-%Y")
      end, {}),
      i(3, "Short Description"),
      i(4, "Notes / Why it matters"),
    }
  )),

  -- ⚖️ Decision Log
  s("decision", fmt(
    [[
# ⚖️ Decision Log

**Date:** {}
**Topic:** {}
**Owner:** {}

## 🧩 Context
{}

## 💡 Decision
{}

## 🚀 Impact
{}

## 🧭 Alternatives Considered
- {}

## 🕒 Follow-up Actions
- [ ] {}
]],
    {
      f(today, {}),
      i(1, "Decision topic"),
      i(2, "Rahul G."),
      i(3, "Background / context"),
      i(4, "Final decision summary"),
      i(5, "Expected outcome"),
      i(6, "Other options / reasoning"),
      i(7, "Next action"),
    }
  )),

  -- 💡 Idea / Thought Template
  s("idea", fmt(
    [[
# 💡 Idea: {}

**Date:** {}
**Category:** {}

## 🧠 Description
{}

## ⚙️ Next Steps
- [ ] {}

## 🔗 References
- {}
]],
    {
      i(1, "Idea title"),
      f(today, {}),
      i(2, "Innovation / Process / Product"),
      i(3, "What’s the idea about"),
      i(4, "Next experiment / action"),
      i(5, "Links / documents"),
    }
  )),
}
