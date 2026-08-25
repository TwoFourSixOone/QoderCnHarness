---
name: opsx-verify
description: OpenSpec 对齐校验。核对代码实现是否与 change 工件（proposal.md、design.md、tasks.md）一致。当代码实施完成后需要验证对齐时使用。
---

# OpenSpec Verify — 对齐校验

## 职责

**只检查"实现有没有和 OpenSpec 工件对上"。**

- ✅ 检查：功能点是否全部实现
- ✅ 检查：技术方案是否被正确实施
- ✅ 检查：tasks 节点是否全部完成
- ✅ 检查：隐性约定是否被遵循
- ❌ 不检查：代码质量（@reviewer 负责）
- ❌ 不检查：架构分层（/java-architecture-review 负责）
- ❌ 不检查：SQL 风险（/sql-risk-review 负责）

---

## 前置检查

1. `openspec/changes/` 下存在进行中的 change
2. change 中包含 proposal.md、design.md、tasks.md
3. 代码已经通过 `/opsx-apply` 实施

---

## 执行步骤

### Step 1：读取 change 工件

提取 proposal 功能点、design 方案要点、tasks 节点列表、相关隐性约定。

### Step 2：逐项核对

- **Proposal 对齐**：每个功能点 → 是否实现 → 代码位置
- **Design 对齐**：每个方案要点 → 是否符合
- **Tasks 对齐**：每个节点 → 是否完成
- **隐性约定对齐**：每条相关约定 → 是否遵循

### Step 3：检查超出范围的改动

对比变更文件列表与 tasks 预估文件，标记超范围改动。

### Step 4：输出验证报告

结论三档：
- ✅ **对齐** — 可以进入归档
- ⚠️ **部分偏离** — 需修正后重新 verify
- ❌ **严重偏离** — 建议重新 propose

---

## 注意事项

- verify **不是代码评审**，不关注代码质量，只关注"有没有按方案做"
- 发现偏离时明确列出偏离项，不做大段评论
- 偏离严重时建议用户废弃当前 change 重新 propose
