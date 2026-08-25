---
name: opsx-propose
description: OpenSpec 变更提案流程。将需求拆解为 change 工件，生成 proposal.md、design.md、tasks.md 三个核心文件。当用户提出新需求或要求进行需求拆解时使用。
---

# OpenSpec Propose — 需求工件化

## 职责

将一个需求拆解为结构化的 change 工件，产出 proposal.md、design.md、tasks.md 三个文件。

**本阶段只产出方案，不写代码。**

---

## 执行步骤

### Step 1：读取项目知识

按顺序读取：
1. `AGENTS.md` — 了解工作流
2. `docs/architecture/index.md` — 了解架构和分层规范
3. `docs/architecture/implicit-contracts.md` — 了解隐性约定（**必须检查**）
4. `docs/product/index.md` — 了解产品规则和业务边界
5. `docs/standards/database.md` — 了解数据库规范

### Step 2：确认需求边界

与用户确认：
- 核心目标是什么
- 包含哪些功能点，不包含哪些
- 是否涉及隐性约定
- 是否需要拆分多个 change

### Step 3：创建 change 目录

在 `openspec/changes/` 下创建：

```
openspec/changes/YYYY-MM-DD_<简短描述>/
├─ specs/
├─ proposal.md
├─ design.md
└─ tasks.md
```

命名格式：`YYYY-MM-DD_<简短英文描述>`

### Step 4：生成 proposal.md

包含：需求背景、核心目标、功能范围（包含/不包含）、隐性约定检查、风险评估。

### Step 5：生成 design.md

包含：技术方案、分层设计（Controller/Service/DAO/Model）、数据库变更、异常处理、隐性约定对齐。

### Step 6：生成 tasks.md

每个 Task 明确到：具体任务描述 + 预估涉及文件。

### Step 7：提醒用户审查

> 📋 proposal/design/tasks 已生成，请审查。
> 重点关注：需求边界、隐性约定、tasks 拆分。
> 确认无误后，告诉我"开始 apply"。

---

## 注意事项

- 第一版 proposal 往往只是草案，用户要求修改时认真修正
- 需求边界理不清时，建议用户拆分成多个 change
- design 阶段要显式检查 implicit-contracts.md
- tasks 中每个任务要明确到具体文件，不能模糊
