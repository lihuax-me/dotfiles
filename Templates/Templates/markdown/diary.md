---
title: "{{_file_name_}}"
type: "diary"
author: {{_author_}}
date: {{_lua:os.date("%Y-%m-%dT%H:%M:%S")_}}
updated: {{_lua:os.date("%Y-%m-%dT%H:%M:%S")_}}
weekday: {{_lua:os.date("%A")_}}
week: 20{{_lua:os.date("%y")_}}W{{_weeknum_}}
tags: [diary]
rating: 0
mood:
  [😀, 😃, 😊, 😌, 😴, 😐, 😕, 😟, 😢, 😠, 😤, 😱, 🤔, 😎, 🤯, 🥳, 🥱, 🤒, ❤️]
weather: [, , , , , , , 󰖒, 󰢘]
---

## plan

- 08:10-09:10 英语单词
- 09:20-12:10 细胞生物学
- 14:10-17:00 分子生物学
- 17:10-18:10 政治
- 19:30-20:10 分子生物学
- 21:00-22:40 英语阅读
- 22:40-22:45 复盘

## habit track

- [ ] 早起 #habit
- [ ] 背红宝书单词(≥100) #habit
- [ ] 英语阅读做题/精读(1~2篇) #habit
- [ ] 政治课听课/做题(≥1节) #habit
- [ ] 专业课复习(≥1节) #habit
- [ ] 运动 #habit
- [ ] 早睡 #habit

## Dear diary

我感觉…  
我认为…  
我想要…

## review

- 今天做得好的：
- 可以改进的：
- 明日唯一重点：

## navigator

<<[[Diary_{{_lua:os.date("%Y-%m-%d", os.time() + (-1 * 24 * 60 * 60))_}}]] || [[Diary_{{_lua:os.date("%Y-%m-%d", os.time() + (1 * 24 * 60 * 60))_}}]]>>
