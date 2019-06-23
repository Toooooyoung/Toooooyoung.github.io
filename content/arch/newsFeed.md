---
title: "新鲜事系统"
date: 2019-06-21T18:50:30+08:00
tags:
    - system design
    - interview
    - news feed
categories:
    - system design
    - interview
    - jiuzhang
type: posts
---

新鲜事系统: 主动关注用户，并获取所有关注人发布的状态消息等
常用APP：
- Facebook
- Twitter
- instgram
- 微信盆友圈
- 微博
<!--more-->

# 需求
1. publish/get post
2. follow/unfollow user
3. like
    1. like a post/comment
    2. get num of likes
4. comment/like on a post/comment recursively
5. rank feed

# 数据模型

