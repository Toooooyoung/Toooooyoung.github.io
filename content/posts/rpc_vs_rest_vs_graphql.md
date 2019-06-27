---
title: "How to Design a Good API"
date: 2019-06-27T04:26:59+08:00
tags:
categories:
    - API
---

# 衡量API好坏的标准（5C+DV）：
1. Coupling，耦合性
2. Chattiness/performance(network latency, overload), 网络负载
3. Client complexity, 客户端复杂度
4. Congative complexity, 是否易于理解
5. Caching, 是否能够cache
6. Discoverability, 自发现, 自省(introspect)
    - 如果没用过API, 从哪里开始使用
    - 应该调哪一个API(如多版本情况)
7. Versioning， 版本管理

# 如何选择API需要考虑的问题
1. 谁使用这个API
2. API设计是为了解决什么事情

# RPC
- Remote Procedure Call: call the function on another server调用在远程服务器上的方法
- 基本元素： function

## Schema
```
Get   /listConversations
Get   /listMessages
Post  /sendMessage
Get   /getAuthor
Get   /checkMessageStatus
Get   /listConversationV2
```
## Advantages
1. 简单明了，容易理解，HTTP协议在这里时透明的，就像调用一个函数一样
2. 增加一个API只要增加一个函数就好了
3. lightweight payloads
3. 高性能，网络负载低，吞吐量大，适合公司内部微服务之间的大量消息传输

## Dis
1. 客户端和服务端耦合性高，调用API需要知道其背后函数的逻辑
2. 因此会泄露代码细节
3. 服务的可发现低，作为一个新手不知道去哪找API,如何找下一个API， API具体做什么事
4. 函数爆炸 function explosion，如果已有的函数不能满足需求，如现有的 `listConversation` 不能得到更多的消息，需要创建一个 v2版，每一个功能都要写一个新API, 造成冗余，难以维护

## Scenario
1. 适合公司内部微服务之间的大量消息传输
2. 面向命令，事务，如转账，创建，登录

# REST
- Representational State Transfer 表现层状态转移
- 架构式的设计，为了解耦客户端与服务端而设计
- 基本元素： Resource
- 定义
    - 使用URI定义一个资源
    - 使用HTTP的GET/POST/PUT/DELETE来控制资源的增删改查
    - HATEOAS: 从一个API能够找到所有其他相关的API
        - HyperTest As The Engine Of Application State
        - 返回的结果中加入对其他元素的link
        - metadata
    - 无状态
    - Cache


## Schema
```
Get /messages

{
    "href": "/messages",
    "desc": "...",
    "count": 5,
    "objects": [
        {
            "href": "/messages/1",
            "value": "message 1"
            "author: {
                "value": "author1",
                "href": "/message/1/author"
            }
    ]
        }
}
```

## Advantages
1. 解耦客户端与服务器端
2. 自省性， 在总入口增加所有可以访问的API的list, metadata
3. 不用专门写文档，API本身即文档
4. API可以演化，为一个资源增加属性不用创建新的API, 可直接升级
4. reuse http verbs/cache/content
5. 缓存已请求的信息，因为每次都是返回资源的所有信息，所以可以在有效期内可以再利用


## Dis
1. Chatty 如果想获取一条消息的的作者的信息，则要至少请求两次，会增加网络开销
2. payloads比较大，返回一些不需要的信息, 增加网络负载
3. 如果网络条件不好，会增加网络负担

## Scenario
1. Management API, 以资源/对象为模型，如管理用户
2. 面对各种各样不同客户端，如开放给公众，此时需要良好的文档和自省能力
3. 需要拥有自省（自发现性）能力

# GraphQL
- 回你想要
- 面向查询

## Advantage
1. 只返回你所想要的，所以网络开销低
2. typed schema
3. 适合图形数据结构，如人脉关系

## Dis
1. 复杂
2. 每次请求的东西可能不一样，不能做缓存
3. 版本管理
4. 现在使用太早，市场支持不够

## Scenario
1. 图形数据结构
2. 为由于payloads过大造成网络负载过高，带宽过大从而延迟过高而做优化
3. 每个客户端对payloads的需求很不一样