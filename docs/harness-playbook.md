# Harness 操作手册

> 以「给项目新增一个用户管理模块」为例，完整演示 Harness 开发流程的每一步操作。  
> 本手册面向团队成员，照着做就能跑通整套流程。

---

## 流程总览

```
你提出需求
    │
    ▼
① /opsx-propose ──────── 需求拆解，生成工件
    │
    ▼
② 人工审查 proposal ──── 检查边界、隐性约定、任务拆分
    │
    ▼
③ 补充隐性约定 ────────── 写入 implicit-contracts.md
    │
    ▼
④ 确认 design ─────────── 审查技术方案
    │
    ▼
⑤ /opsx-apply ─────────── 按 tasks 逐步写代码
    │
    ▼
⑥ 专项审查（4 项分开执行）
    ├─ /prepare-review
    ├─ /java-architecture-review
    ├─ /sql-risk-review
    └─ @reviewer
    │
    ▼
⑦ /opsx-verify ─────────── 核对实现与工件是否对齐
    │
    ▼
⑧ /opsx-archive ────────── 归档 change
    │
    ▼
⑨ 沉淀新隐性约定 ──────── 写入 implicit-contracts.md
```

---

## 背景设定

产品经理提了一个需求：

> "我们需要加一个用户管理功能，支持用户注册、查询、批量禁用。"

你的项目已经搭好了 Harness 骨架（AGENTS.md、docs/、openspec/、.qoder/ 全部就位）。

---

## ① /opsx-propose — 需求拆解

### 你要做什么

打开 QoderCn，输入：

```
/opsx-propose 新需求：用户管理模块，支持注册、查询、批量禁用
```

### AI 会自动做的事

1. 读取 `AGENTS.md`、`docs/architecture/index.md`、`docs/architecture/implicit-contracts.md`、`docs/product/index.md`、`docs/standards/database.md`
2. 在 `openspec/changes/` 下创建 change 目录：

```
openspec/changes/2026-08-24_add-user-management/
├─ specs/
├─ proposal.md     ← 需求拆解
├─ design.md       ← 技术方案
└─ tasks.md        ← 任务节点
```

3. 生成三个工件文件

### 生成后你要检查什么

AI 会提醒你审查，重点关注：

- [ ] 需求边界是否正确（有没有多做或少做）
- [ ] 是否遗漏了隐性约定
- [ ] tasks 拆分是否合理、可执行

### 本例中会发生什么

AI 生成的第一版 proposal 大致如下：

```
proposal.md:
  功能范围：注册、查询、批量禁用
  遗漏：密码加密方式未说明、批量禁用的数量上限未定义

design.md:
  分层设计：Controller → Service → Repository
  遗漏：未考虑 status=null 的历史数据兼容

tasks.md:
  Task 1: 创建 User 实体类和 DTO
  Task 2: 创建 UserRepository
  Task 3: 创建 UserService
  Task 4: 创建 UserController
  Task 5: 编写单元测试
```

**第一版 proposal 往往只是草案，不要急着执行。** 进入下一步。

---

## ② 人工审查 proposal — 关键把关

### 你要做什么

仔细审查 AI 生成的 proposal.md，找出问题并告诉 AI 修正。

### 本例中的操作

你发现两个问题，于是对 AI 说：

> "第一，批量禁用我说的是一次最多禁 100 个，不是全量禁。第二，注册的时候密码要加密存储，这个你没提到。"

AI 根据你的反馈修正 proposal.md 和 design.md。

### 审查清单

| 检查项 | 本例中的情况 |
|--------|-------------|
| 需求边界对不对 | 批量禁用需要加上数量上限 100 |
| 有没有遗漏隐性约定 | 密码需要加密存储 |
| 是否把多个问题混成一个 change | 本次只有一个需求，拆分合理 |
| tasks 是否足够可执行 | 5 个 task 粒度合理 |

### 如果 proposal 拆错了怎么办

> **果断废弃，重新 propose。** 不要硬着头皮继续，否则后续返工成本更高。

你可以说：

```
这个 proposal 不对，废弃掉，重新拆解。
需求范围缩小，只做注册和查询，批量禁用下个迭代再做。
```

AI 会废弃当前 change，重新创建。

---

## ③ 补充隐性约定 — 知识显性化

### 你要做什么

在审查 proposal 的过程中，如果你想起了项目中"大家都知道但没人写下来"的约定，**立刻让 AI 记下来**。

### 本例中的操作

你对 AI 说：

> "帮我记一条隐性约定——用户表 status 字段，0 表示正常，1 表示禁用。但历史数据里有些 status=null 的老用户，前端展示时要当成正常处理，不能当成禁用。"

### AI 会自动做的事

将这条约定写入 `docs/architecture/implicit-contracts.md`：

```markdown
### 约定 #1：用户 status 字段的 null 语义

- **约定内容**：status=0 表示正常，status=1 表示禁用。
  但历史数据中 status=null 的老用户，前端展示时视为"正常"。
  即 null 和 0 在展示层面等价，但在数据库层面不等价。
- **影响范围**：UserService 查询逻辑、批量禁用逻辑
- **违反后果**：前端联调时老用户被错误显示为"禁用"状态
- **发现时间**：2026-08-24
```

### 什么时候需要补充隐性约定

| 触发时机 | 举例 |
|----------|------|
| 联调踩坑后 | "status=null 和 status=0 前端表现不一样" |
| 修完诡异 bug 后 | "deleted 字段历史数据有 2=归档 这个值" |
| 审查 proposal 时想起来 | "批量接口前端传数组不传逗号字符串" |
| 迭代回顾时 | "这个迭代踩了哪些坑，有没有要记的" |

---

## ④ 确认 design — 审查技术方案

### 你要做什么

审查修正后的 design.md，确认技术方案可行。

### 本例中的审查要点

| 检查项 | 本例中的情况 | 是否 OK |
|--------|-------------|---------|
| 批量禁用加了 WHERE 条件和数量上限 | 上限 100 | ✅ |
| 密码用 BCrypt 加密 | design 中已补充 | ✅ |
| 查询逻辑处理了 status=null 兼容 | 在 UserRepository 中用 OR 处理 | ✅ |
| 分层符合架构规范 | Controller → Service → Repository | ✅ |
| 隐性约定已对齐 | 约定 #1 已检查 | ✅ |

### 确认无误后

对 AI 说：

```
design 没问题，开始 apply。
```

---

## ⑤ /opsx-apply — 代码实施

### 你要做什么

输入命令：

```
/opsx-apply
```

### AI 会自动做的事

按 tasks.md 的 5 个任务节点，逐步生成代码：

| Task | 操作 | 自动检查 |
|------|------|----------|
| Task 1 | 创建 User.java、UserCreateRequest.java、UserVO.java | mvn compile |
| Task 2 | 创建 UserRepository.java | mvn compile |
| Task 3 | 创建 UserService.java | mvn compile |
| Task 4 | 创建 UserController.java | mvn compile |
| Task 5 | 创建 UserServiceTest.java | mvn compile + mvn test |

每完成一个 Task，自动编译检查，通过后才进入下一个。

### 生成的代码文件

```
src/main/java/com/example/
├─ model/User.java
├─ dto/UserCreateRequest.java
├─ dto/UserVO.java
├─ repository/UserRepository.java
├─ service/UserService.java
└─ controller/UserController.java

src/test/java/com/example/
└─ service/UserServiceTest.java
```

### AI 完成后会输出实施报告

```
Apply 实施报告：
  Task 1~5 全部完成 ✅
  mvn compile: ✅ 通过
  mvn test: ✅ 通过
  隐性约定 #1: ✅ 已在 UserRepository 查询中处理

建议下一步：
  1. /prepare-review
  2. /java-architecture-review
  3. /sql-risk-review
  4. @reviewer
```

### 本阶段你不需要做什么

AI 按 tasks 范围写代码，你只需要等它完成。如果编译失败，AI 会自动修复。

---

## ⑥ 专项审查 — 四项分开执行

代码写完后，**不要一次性打包审查**，依次执行以下 4 项：

### 6.1 /prepare-review — 生成评审摘要

输入：

```
/prepare-review
```

AI 输出：

```
评审摘要：
  变更文件数：7 个
  变更行数：+486 -0
  任务覆盖：5/5 全部完成
  隐性约定：涉及 #1（status null 语义）→ 已处理
  风险提示：无高风险操作
```

**你的动作**：看一眼摘要，确认变更范围符合预期。

---

### 6.2 /java-architecture-review — 架构检查

输入：

```
/java-architecture-review
```

AI 扫描所有新增的 Java 文件，输出检查报告。

**本例中发现的问题**：

```
❌ 中等问题 | UserController.java:28 | 违反规则 1
问题：Controller 的 register() 方法中包含密码加密逻辑（BCrypt 调用）
建议：密码加密应放在 UserService 层，Controller 只负责接收参数和返回响应
```

**你的动作**：对 AI 说：

```
把密码加密逻辑从 Controller 移到 Service。
```

AI 修正代码。

---

### 6.3 /sql-risk-review — SQL 风险检查

输入：

```
/sql-risk-review
```

AI 检查数据层操作，输出风险报告。

**本例中发现的问题**：

```
🔴 高风险 | UserService.java:67 | 批量禁用
问题：批量禁用方法中 WHERE 条件使用 IN 子句，但未限制输入数量上限
风险：传入大量 ID 可能导致 SQL 过长或性能问题
建议：在 Service 入口增加数量校验，超过 100 直接拒绝
```

**你的动作**：对 AI 说：

```
加上数量校验，超过 100 抛异常。
```

AI 修正代码。

---

### 6.4 @reviewer — 独立代码审查

输入：

```
@reviewer 审查本次用户管理模块的全部代码变更
```

reviewer 子代理做一轮只读审查。

**本例中发现的问题**：

```
⚠️ 警告 | UserService.java:45
问题：register() 方法没有对用户名重复做唯一性校验
建议：在插入前查询是否已存在同名用户，或加数据库唯一索引
```

**你的动作**：对 AI 说：

```
在 UserService.register() 中加上用户名重复检查。
```

AI 修正代码。

---

### 专项审查小结

| 审查项 | 发现的问题 | 处理方式 |
|--------|-----------|----------|
| /prepare-review | 无异常 | 确认变更范围 |
| /java-architecture-review | Controller 写了业务逻辑 | 移到 Service |
| /sql-risk-review | 批量操作无数量上限 | 加上校验 |
| @reviewer | 缺少用户名唯一性校验 | 补充检查逻辑 |

> **核心原则：每项审查只解决自己范围内的问题，不要混在一起。**

---

## ⑦ /opsx-verify — 对齐校验

所有审查问题修正后，执行对齐校验。

### 你要做什么

输入：

```
/opsx-verify
```

### AI 会自动做的事

逐项核对代码实现与 change 工件是否一致：

```
Proposal 对齐：
  ✅ 用户注册 — 已实现，密码已加密
  ✅ 用户查询 — 已实现，status=null 兼容处理
  ✅ 批量禁用 — 已实现，WHERE 条件 + 数量上限 100

Tasks 对齐：
  ✅ Task 1~5 全部完成

隐性约定对齐：
  ✅ 约定 #1（status null 语义）— 已在查询中处理

超出范围的改动：无

结论：✅ 对齐
```

### 如果结论是"部分偏离"怎么办

AI 会列出偏离项，你根据情况决定：
- 偏离合理（比如修复审查发现的问题）→ 接受偏离，继续归档
- 偏离不合理 → 让 AI 修正后重新 verify

---

## ⑧ /opsx-archive — 归档

### 你要做什么

确认 verify 通过后，输入：

```
/opsx-archive
```

### AI 会自动做的事

1. 确认 verify 结论为"对齐"
2. 提醒你是否还有隐性约定需要补充
3. 将 change 目录移动到 archive：

```
openspec/changes/2026-08-24_add-user-management/
    → openspec/changes/archive/2026-08-24_add-user-management/
```

4. 输出归档报告

### 归档前别忘了

AI 会提醒你：

> 归档前，是否还有新的隐性约定需要补充？

如果有，进入第 ⑨ 步。如果没有，直接完成归档。

---

## ⑨ 沉淀新隐性约定 — 知识沉淀

### 你要做什么

回想整个开发过程，有没有新发现的隐性约定。

### 本例中的操作

你对 AI 说：

> "再记一条——批量操作接口，前端传的是 ID 数组，不是逗号分隔的字符串。"

AI 写入 `docs/architecture/implicit-contracts.md`：

```markdown
### 约定 #2：批量操作接口的参数格式

- **约定内容**：所有批量操作接口的 ID 参数统一使用 JSON 数组格式（如 [1,2,3]），
  不使用逗号分隔字符串。
- **影响范围**：所有批量操作接口
- **违反后果**：前端传参格式不匹配，接口报 400 错误
- **发现时间**：2026-08-24
```

### 这条约定会在什么时候发挥作用

下次你再让 AI 做批量操作相关的需求时，AI 在 `/opsx-propose` 阶段会读取 `implicit-contracts.md`，自动遵循这条约定，不会再犯同样的错误。

**这就是知识沉淀的价值——踩一次坑，永远不踩第二次。**

---

## 命令速查表

| 阶段 | 命令 | 谁执行 | 产出 |
|------|------|--------|------|
| 需求拆解 | `/opsx-propose` | 你触发，AI 执行 | proposal.md + design.md + tasks.md |
| 代码实施 | `/opsx-apply` | 你触发，AI 执行 | 代码文件 |
| 评审摘要 | `/prepare-review` | 你触发，AI 执行 | 评审摘要报告 |
| 架构检查 | `/java-architecture-review` | 你触发，AI 执行 | 架构检查报告 |
| SQL 检查 | `/sql-risk-review` | 你触发，AI 执行 | SQL 风险报告 |
| 代码审查 | `@reviewer` | 你触发，AI 执行 | 代码审查报告 |
| 对齐校验 | `/opsx-verify` | 你触发，AI 执行 | 验证报告 |
| 归档 | `/opsx-archive` | 你触发，AI 执行 | 归档完成 |

## 人工操作速查表

| 阶段 | 你要做什么 | 不能省 |
|------|-----------|--------|
| propose 后 | 审查 proposal，检查边界和隐性约定 | ✅ 必须 |
| design 后 | 审查技术方案，确认可以落地 | ✅ 必须 |
| apply 后 | 等待，不需要介入 | 可以不管 |
| 审查后 | 根据报告指示 AI 修正问题 | ✅ 必须 |
| verify 后 | 确认对齐结论 | ✅ 必须 |
| archive 前 | 补充新的隐性约定 | ✅ 强烈建议 |

---

## Skill 定义文件位置

如果需要调整某个 Skill 的执行逻辑，可以编辑对应的 `SKILL.md` 文件：

| 命令 | 定义文件 |
|------|----------|
| `/opsx-propose` | `.qoder/skills/opsx-propose/SKILL.md` |
| `/opsx-apply` | `.qoder/skills/opsx-apply/SKILL.md` |
| `/opsx-verify` | `.qoder/skills/opsx-verify/SKILL.md` |
| `/opsx-archive` | `.qoder/skills/opsx-archive/SKILL.md` |
| `/prepare-review` | `.qoder/skills/prepare-review/SKILL.md` |
| `/java-architecture-review` | `.qoder/skills/java-architecture-review/SKILL.md` |
| `/sql-risk-review` | `.qoder/skills/sql-risk-review/SKILL.md` |
| `@reviewer` | `.qoder/agents/reviewer.md` |

> 这些文件都纳入版本控制，团队成员共享同一套 Skill 定义。
