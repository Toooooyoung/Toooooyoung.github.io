---
title: "Hugo Usage"
date: 2019-04-05T14:11:36+08:00
tags:
categories:
- hugo
---


# Grammar Usage
1. warning

    {{<admonition type="warning">}}

This is a warning

    {{</admonition>}}


2. 折叠/Read More

    <!--more-->

3. 引用

    >This is a reference
    >       def a():
    >           print(b)
    >

4. 表格

| head1 | head2 |
| --- | --- |
| key1 | v1 |
| key2 | v2 |

# Command

- `gulp serve` : liveload server
- `gulp build`: generate public files to /docs
- `gulp lunr`: generate index file for search
