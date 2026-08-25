# OpenSpec 变更目录

本目录存放所有进行中和已完成的 change。

## 目录结构

```
changes/
├─ <change-name>/           ← 每个 change 对应一个需求
│  ├─ specs/                ← 该 change 的工作原理说明
│  ├─ proposal.md           ← 需求实现提案
│  ├─ design.md             ← 技术实现方案
│  └─ tasks.md              ← 执行步骤节点
└─ archive/                 ← 已完成的 change 归档
```

## 工作流

```
/opsx:propose → /opsx:apply → /opsx:verify → /opsx:archive
```

## 命名规范

change 目录命名格式：`YYYY-MM-DD_<简短描述>`

示例：`2026-08-24_add-user-authentication`
