---
name: opsx-archive
description: OpenSpec 变更归档。将已完成的 change 移动到 archive 目录。当 verify 通过且用户确认归档时使用。
---

# OpenSpec Archive — 变更归档

## 职责

将已完成的 change 归档到 `openspec/changes/archive/`。**归档后只读，不可修改。**

---

## 前置检查

1. change 已通过 `/opsx-verify`（结论为"对齐"）
2. 用户已明确说"归档"

未通过 verify 则拒绝归档。

---

## 执行步骤

### Step 1：确认归档条件

检查 verify 报告结论。未找到则提醒用户先验证。

### Step 2：执行归档

将 change 目录整体移动到 archive：

```
openspec/changes/<change-name>/ → openspec/changes/archive/<change-name>/
```

### Step 3：归档前提醒

> 归档前，是否还有新的隐性约定需要补充到 `implicit-contracts.md`？

### Step 4：输出归档报告

包含：change 名称、归档位置、需求摘要、Task 完成情况、当前进行中的其他 change。

---

## 注意事项

- 归档前提醒用户补充隐性约定
- 避免与 archive 中已有 change 重名
- 归档本质是移动目录，不修改文件内容
