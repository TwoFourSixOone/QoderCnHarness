---
name: opsx-apply
description: OpenSpec 代码实施流程。根据已确认的 design.md 和 tasks.md 实施代码变更，每完成一个任务节点自动编译检查。当用户确认方案并要求开始编码时使用。
---

# OpenSpec Apply — 代码实施

## 职责

根据已确认的 change 工件实施代码变更。**只做 tasks.md 范围内的事，不自行扩展。**

---

## 前置检查

1. `openspec/changes/` 下存在进行中的 change
2. 包含已确认的 proposal.md、design.md、tasks.md
3. 用户已明确说"开始 apply"或"开始写代码"

不满足则提醒用户先走 propose 流程。

---

## 执行步骤

### Step 1：读取 change 工件

读取 proposal.md、design.md、tasks.md、implicit-contracts.md。

### Step 2：逐 Task 实施

按 tasks.md 顺序，每个 Task：
1. 读取 design.md 中对应方案
2. 编写代码（遵循分层规范 + 隐性约定 + 数据库规范）
3. 执行 `mvn compile` 编译检查
4. 在 tasks.md 中标记 `[x]`

### Step 3：全部完成后

```bash
mvn compile
mvn test
```

### Step 4：输出实施报告

列出每个 Task 完成情况、编译状态、隐性约定对齐情况，建议下一步审查。

---

## 约束

**必须做：** 严格按 tasks 范围实施、每个 Task 编译检查、遵循隐性约定
**禁止做：** 超出范围改动、修改受保护文件、跳过编译检查
