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

## 快速开始

### 方式一：作为 GitHub 模板仓库（推荐）

1. 点击右上角 **Use this template** → **Create a new repository**
2. 克隆新仓库到本地：
   ```bash
   git clone https://github.com/<your-username>/<your-repo>.git
   cd <your-repo>
   ```
3. 修改项目信息：
   - `pom.xml`：替换 `groupId` 和 `artifactId`
   - `AGENTS.md`：替换项目名称
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

## 项目结构

```
your-project/
├─ AGENTS.md              ← AI 导航地图（入口文件）
├─ REVIEW.md              ← 代码评审标准
├─ docs/                  ← 项目知识库
│  ├─ architecture/       ← 架构设计 & 隐性约定
│  ├─ product/            ← 产品规则
│  └─ standards/          ← 测试 & 数据库规范
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

## 环境要求

- Java 17+
- Maven 3.6+
- 推荐使用 IntelliJ IDEA

---

## License

MIT
