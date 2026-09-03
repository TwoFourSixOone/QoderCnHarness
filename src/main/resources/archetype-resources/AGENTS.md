# ${artifactId} — AI 导航地图

> 本文件是 AI 进入仓库后的**第一份导航文件**，告诉 AI "先看什么、按什么流程做"。  
> 项目知识、业务规则、隐性约定等详细内容统一放在 `docs/` 目录下，本文件只做导航。

---

## 1. 仓库概述

- **项目名称**：${artifactId}
- **技术栈**：Java 17 + Maven
- **工作流**：OpenSpec 变更生命周期管理
- **AI 平台**：QoderCn

---

## 2. AI 进入仓库后的必读顺序

1. **本文件（AGENTS.md）** — 了解工作流和入口
2. **`docs/architecture/index.md`** — 了解项目整体架构
3. **`docs/architecture/implicit-contracts.md`** — 了解隐性业务约定（**关键**）
4. **`docs/standards/testing.md`** — 了解测试规范
5. **`docs/standards/database.md`** — 了解数据库与 SQL 规范
6. **`docs/product/index.md`** — 了解产品规则与业务逻辑边界

---

## 3. 核心工作流：OpenSpec 变更生命周期

**铁律：没有 change，不允许直接开始开发。**

所有需求变更必须走 OpenSpec 流程：

```
/opsx:propose → /opsx:apply → /opsx:verify → /opsx:archive
```

| 阶段 | 职责 | 产出物 |
|------|------|--------|
| **propose** | 需求拆解，生成变更工件 | `proposal.md`、`design.md`、`tasks.md` |
| **apply** | 按已确认方案实施代码变更 | 代码改动 |
| **verify** | 核对实现与工件是否对齐 | 验证报告 |
| **archive** | 归档已完成的 change | 移动到 `openspec/changes/archive/` |

### 关键规则

- `openspec/changes/` 下每个子目录对应一个进行中的 change
- 第一版 proposal 往往只是草案，**人工审查不能省**，必要时果断废弃重来
- apply 阶段**只做 tasks.md 范围内的事**，不允许自行扩展
- verify 只检查"实现与工件是否对齐"，**不是代码评审**

---

## 4. 实现、评审、验证 — 必须分离

以下职责**严禁混在一起**，必须分开执行：

| 职责 | 执行方式 | 说明 |
|------|----------|------|
| OpenSpec 对齐校验 | `/opsx:verify` | 只检查实现与 change 工件是否一致 |
| PR 评审摘要 | `/prepare-review` | 整理本次变更内容，方便人工评审 |
| 架构分层检查 | `/java-architecture-review` | 检查 Java 分层架构是否规范 |
| SQL 风险审查 | `/sql-risk-review` | 检查 SQL、批量操作等数据层风险 |
| 独立代码审查 | `@reviewer` 子代理 | 只读、独立的代码质量审查 |

---

## 5. 受保护区域

以下目录/文件属于**高风险区域**，AI 不得直接修改：

- `src/main/resources/application*.yml` / `application*.properties` — 配置文件
- `src/main/resources/db/` / `sql/` — 数据库脚本
- `deploy/` / `infra/` — 部署相关文件
- `secrets/` — 密钥文件
- `openspec/changes/archive/` — 已归档的 change（只读）

如需修改上述文件，必须通过 change 流程并经人工审批。

---

## 6. 安全命令白名单

**允许执行**的命令：
- `mvn compile`、`mvn test`、`mvn package -DskipTests`
- `git status`、`git diff`、`git log`

**禁止执行**的命令：
- `git push`（除非人工明确要求）
- `rm -rf`、`drop`、`truncate` 等破坏性命令
- 任何生产部署相关命令

---

## 7. 目录结构速览

```
repo/
├─ AGENTS.md                  ← 你正在看的文件
├─ REVIEW.md                  ← 评审标准
├─ docs/                      ← 项目知识库
│  ├─ architecture/           ← 架构知识 & 隐性约定
│  ├─ product/                ← 产品规则
│  └─ standards/              ← 测试 & 数据库规范
├─ openspec/                  ← OpenSpec 变更管理
│  ├─ changes/                ← 进行中的 change
│  └─ specs/                  ← 当前系统工作原理
├─ src/                       ← 源代码
└─ pom.xml                    ← Maven 配置
```

---

## 8. 核心原则（十六字诀）

> **需求先工件化，知识先显性化，执行先加护栏，评审与验证必须分离。**
