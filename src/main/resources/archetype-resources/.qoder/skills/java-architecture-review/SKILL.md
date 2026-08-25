---
name: java-architecture-review
description: 检查Java项目分层架构是否规范，包括Controller是否包含业务逻辑、Service职责是否单一、是否存在跨层调用等问题。在代码变更完成后需要架构审查时使用，或当用户要求进行架构检查时触发。
---

# Java Architecture Review — Java 分层架构检查

## 职责

**只负责检查 Java 分层架构是否规范**，确保各层职责清晰、不混乱。

本 skill 不检查 SQL 风险（由 `/sql-risk-review` 负责），不做通用代码评审（由 `@reviewer` 负责）。

---

## 检查规则

### 规则 1：Controller 层纯净性

**Controller 只能做以下事情：**
- 接收 HTTP 请求
- 参数基础校验（如 `@Valid`）
- 调用 Service 层方法
- 封装并返回响应

**禁止：**
- 在 Controller 中编写业务逻辑（if/else 业务判断、循环处理等）
- 直接调用 DAO/Repository 层
- 直接操作数据库
- 包含复杂的类型转换或数据处理逻辑

**检查方法：**
- 扫描 `*Controller.java` 文件
- 检查方法体长度（超过 20 行需关注）
- 检查是否包含业务关键词（如 `if` 业务判断、`for` 数据处理）
- 检查是否直接注入了 `Repository` / `Mapper` / `Dao`

### 规则 2：Service 层职责单一性

**Service 应该：**
- 只包含一个业务域的逻辑
- 方法职责清晰，一个方法做一件事
- 通过依赖注入使用其他 Service 或 DAO

**禁止：**
- 一个 Service 负责多个不相关的业务域（"过胖"的 Service）
- 方法超过 50 行（建议拆分）
- Service 之间出现循环依赖

**检查方法：**
- 统计 Service 中注入的依赖数量（超过 8 个需关注）
- 检查方法长度和复杂度
- 分析类名是否暗示了过宽的职责（如 `XxxAllService`、`XxxManager`）

### 规则 3：DAO/Repository 层纯净性

**DAO 只能做：**
- 数据查询
- 数据增删改
- SQL 执行

**禁止：**
- 包含业务逻辑判断
- 调用 Service 层方法
- 包含数据转换（应在 Service 或专门的 Converter 中完成）

### 规则 4：分层调用方向

**合法的调用方向：**
```
Controller → Service → DAO/Repository
```

**禁止的调用方向：**
- Controller → DAO（跨层调用）
- DAO → Service（反向调用）
- DAO → Controller（反向调用）

---

## 执行步骤

### Step 1：扫描变更文件

```bash
git diff --name-only
```

筛选出 `*.java` 文件。

### Step 2：逐文件检查

对每个变更的 Java 文件，按上述 4 条规则逐一检查。

### Step 3：读取架构规范

读取 `docs/architecture/index.md` 确认项目分层规范。

### Step 4：输出检查报告

```markdown
## 架构分层检查报告

### 检查范围
- 检查文件数：[N]
- 涉及模块：[模块列表]

### 发现的问题
| 序号 | 严重程度 | 文件 | 违反规则 | 问题描述 | 建议修复 |
|------|----------|------|----------|----------|----------|
| 1    | 高/中/低 | ...  | 规则 X   | ...      | ...      |

### 架构健康度
- Controller 纯净性：✅ 通过 / ❌ 存在问题
- Service 职责单一性：✅ 通过 / ❌ 存在问题
- DAO 纯净性：✅ 通过 / ❌ 存在问题
- 分层调用方向：✅ 通过 / ❌ 存在问题

### 总结
[整体评价和建议]
```

---

## 严重程度定义

| 等级 | 定义 |
|------|------|
| **高** | Controller 包含业务逻辑、跨层调用 |
| **中** | Service 职责过重、方法过长 |
| **低** | 命名不规范、建议性优化 |
