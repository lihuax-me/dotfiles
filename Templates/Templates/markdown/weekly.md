---
title: "{{_file_name_}}"
type: "weekly"
author: {{_author_}}
date: {{_lua:os.date("%Y-%m-%dT%H:%M:%S")_}}
updated: {{_lua:os.date("%Y-%m-%dT%H:%M:%S")_}}
week: 20{{_lua:os.date("%y")_}}W{{_weeknum_}}
tags: [weekly]
cssclasses: [cards, cards-cols-3]
---

## goal

- [ ] 
- [ ] 
- [ ] 

## dataview

```dataviewjs
// helper: escape special chars so tasks不会破坏html
function escapeHtml(str) {
  return str.replace(/[&<>"']/g, function(m) {
    switch (m) {
      case "&": return "&amp;";
      case "<": return "&lt;";
      case ">": return "&gt;";
      case '"': return "&quot;";
      case "'": return "&#039;";
    }
  });
}

// 1) 当前周
const week = dv.current().week ?? dv.current().file.frontmatter.week;

// 2) 抓取本周日记
const pages = dv.pages('"diary/20{{_lua:os.date("%y")_}}"')
  .where(p => p.type === "diary" && p.week === week)
  .sort(p => p.file.name, 'asc');

// 3) 表头 & 行数据
const headers = ["Day", "Meta", "Habits", "Progress"];
const rows = [];

for (const p of pages) {
  const tasks = (p.file.tasks ?? []).filter(t => t.text.includes("#habit"));
  if (tasks.length === 0) continue;

  const done  = tasks.filter(t => t.completed).length;
  const total = tasks.length;
  const rate  = total ? Math.round(100 * done / total) : 0;

  // ---- Meta（mood + weather）
  const mood = p.mood ?? "-";
  const weather = Array.isArray(p.weather) ? p.weather.join(" ") : (p.weather ?? "-");
  const meta = `Mood: ${mood} | Weather: ${weather}`;

  // ---- Habits
  const habitsEl = document.createElement("div");
  habitsEl.innerHTML = tasks
    .map(t => `${t.completed ? "[x]" : "[ ]"} ${escapeHtml(t.text)}`)
    .join("<br>");

  // ---- Progress
  const progressEl = document.createElement("div");
  const barWrap = document.createElement("div");
  barWrap.className = "dv-card-progress";
  const bar = document.createElement("div");
  bar.className = "bar";
  bar.style.width = `${rate}%`;
  barWrap.appendChild(bar);

  const txt = document.createElement("div");
  txt.className = "dv-progress-text";
  txt.textContent = `${done}/${total} (${rate}%)`;

  progressEl.appendChild(barWrap);
  progressEl.appendChild(txt);

  // ---- row
  rows.push([
    p.file.link,     // Day
    meta,            // Meta
    habitsEl,        // Habits
    progressEl       // Progress
  ]);
}

// 4) render table
dv.table(headers, rows);
```

## review

* 成果：
* 问题：
* 下周唯一优先：

## navigator

{{_sunday_}}  
{{_monday_}}  
{{_tuesday_}}  
{{_wednesday_}}  
{{_thursday_}}  
{{_friday_}}  
{{_saturday_}}  

<<[[20{{_lua:os.date("%y")_}}W{{_lastweeknum_}}]] || [[20{{_lua:os.date("%y")_}}W{{_nextweeknum_}}]]>>
