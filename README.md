# QoderCnHarness

> Java 17 + Maven 项目脚手架，内置 OpenSpec 变更管理流程与 QoderCn AI 协作体系。

## 这是什么？

这是一个**开箱即用的 Java 项目脚手架**，预置了：

- 标准化的项目目录结构
- AI 辅助开发的完整工作流（OpenSpec）
- QoderCn AI 代理配置（Skills、Agents、评审标准）
- 文档驱动的知识管理体系

**适合场景**：快速启动一个新的 Java 后端项目，并立即拥有 AI 协作能力。

---

## 分支说明

| 分支 | 说明 | 使用方式 |
|------|------|----------|
| **main** | 原始项目结构 | 作为 GitHub 模板仓库或克隆后直接使用 |
| **original-archetype** | Maven Archetype 版本 | 通过 IDEA 的 Maven Archetype 功能创建项目 |

---

## 快速开始

### 方式一：作为 GitHub 模板仓库（推荐）

1. 点击右上角 **Use this template** → **Create a new repository**
2. 克隆新仓库到本地：
   ```bash
   git clone https://github.com/<your-username>/<your-repo>.git
   cd <your-repo>
   ```
3. 修改项目信息：
   - 运行 `init.ps1` 一键替换项目名，或手动修改以下文件：
   - `pom.xml`：替换 `groupId` 和 `artifactId`
   - `AGENTS.md`：替换项目名称
   - `QODERCN.md`：按需调整 AI 行为准则
   - `docs/`：按需修改文档内容
4. 开始开发：
   ```
   /opsx:propose 你的需求描述
   ```

### 方式二：直接克隆

```bash
git clone https://github.com/TwoFourSixOone/QoderCnHarness.git
cd QoderCnHarness
mvn compile
```

---

## 在 IDEA 中使用 Maven Archetype 创建项目

如果你想通过 IDEA 的 **New Project** 向导直接生成项目，可以使用 `original-archetype` 分支发布的 Maven Archetype。

### 前置配置

1. 生成 GitHub Personal Access Token（需要 `read:packages` 权限）：
   - 打开 https://github.com/settings/tokens
   - 点击 **Generate new token (classic)**
   - 勾选 `read:packages` 权限

2. 配置 Maven `settings.xml`（位于 `~/.m2/settings.xml`）：
   ```xml
   <settings xmlns="http://maven.apache.org/SETTINGS/1.2.0">
       <servers>
           <server>
               <id>github</id>
               <username>你的GitHub用户名</username>
               <password>你的PAT</password>
           </server>
       </servers>
   </settings>
   ```

### 在 IDEA 中创建项目

1. **File → New → New Project**
2. 左侧选择 **Maven Archetype**
3. 点击 **Add Archetype**，填写：
   - **GroupId**: `com.github.twofoursixoone`
   - **ArtifactId**: `qoder-cn-harness-archetype`
   - **Version**: `1.0.0`
4. 选中后填写你自己的项目信息（GroupId、ArtifactId），点击 **Create**

新项目会自动生成完整的目录结构，包含 OpenSpec 工作流和 QoderCn AI 配置。

---

## 项目结构

```
your-project/
├─ AGENTS.md              ← AI 导航地图（入口文件）
├─ QODERCN.md             ← AI 行为准则（定义 AI 基础行为）
├─ REVIEW.md              ← 代码评审标准
├─ init.ps1               ← 项目初始化脚本（一键替换项目名）
├─ docs/                  ← 项目知识库
│  ├─ architecture/       ← 架构设计 & 隐性约定
│  ├─ product/            ← 产品规则
│  ├─ standards/          ← 测试 & 数据库规范
│  └─ harness-playbook.md ← 操作手册（完整流程演示）
├─ openspec/              ← OpenSpec 变更管理
│  ├─ changes/            ← 进行中的变更
│  └─ specs/              ← 系统工作原理
├─ .qoder/                ← QoderCn AI 配置
│  ├─ agents/             ← 子代理定义
│  └─ skills/             ← Skill 定义
├─ src/                   ← 源代码
└─ pom.xml                ← Maven 配置
```

---

## 核心工作流：OpenSpec

所有需求变更必须走 OpenSpec 流程：

```
/opsx:propose → /opsx:apply → /opsx:verify → /opsx:archive
```

| 阶段 | 职责 | 产出物 |
|------|------|--------|
| **propose** | 需求拆解 | proposal.md、design.md、tasks.md |
| **apply** | 实施代码变更 | 代码改动 |
| **verify** | 对齐校验 | 验证报告 |
| **archive** | 归档变更 | 移动到 archive/ |

**核心原则**：需求先工件化，知识先显性化，执行先加护栏，评审与验证必须分离。

---

## 操作手册

首次使用？查看 **[Harness 操作手册](docs/harness-playbook.md)**，以「新增用户管理模块」为例，完整演示从需求拆解到代码归档的每一步操作：

1. `/opsx-propose` — 需求拆解，生成工件
2. 人工审查 proposal — 检查边界、隐性约定
3. 补充隐性约定 — 写入 `implicit-contracts.md`
4. 确认 design — 审查技术方案
5. `/opsx-apply` — 按 tasks 逐步写代码
6. 专项审查（4 项分开执行）
7. `/opsx-verify` — 核对实现与工件是否对齐
8. `/opsx-archive` — 归档 change
9. 沉淀新隐性约定 — 知识沉淀

> 照着操作手册做一遍，就能跑通整套流程。

---

## 环境要求

- Java 17+
- Maven 3.6+
- 推荐使用 IntelliJ IDEA

---

## License

MIT
