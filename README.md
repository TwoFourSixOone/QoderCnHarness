# QoderCnHarness

> Java 17 + Maven 项目脚手架，内置 OpenSpec 变更管理流程与 QoderCn AI 协作体系。

## 特性

- **Java 17 + Maven** 基础工程结构
- **OpenSpec 变更生命周期**：propose → apply → verify → archive
- **QoderCn AI 代理集成**：内置 skills、agents、评审标准
- **文档驱动**：架构、产品规则、开发规范分目录管理
- **受保护区域**：配置文件、数据库脚本、密钥等高风险区域有明确护栏

## 快速开始

### 方式一：作为 GitHub Template Repository 使用

1. 点击右上角 **Use this template** → **Create a new repository**
2. 克隆新仓库到本地
3. 全局替换项目名称：
    ```powershell
    替换 pom.xml 中的 groupId 和 artifactId
    替换 AGENTS.md 中的项目名称
    按需修改 docs/ 下的文档内
    ```powershell
4. 开始你的第一个变更：/opsx:propose 你的需求描述
### 方式二：直接克隆
    ```powershell
    bash git clone https://github.com/<your-username>/QoderCnHarness.git
    cd QoderCnHarness
    mvn compile
    ```powershell
## 目录结构
```
    ├─ AGENTS.md ← AI 导航地图（入口） 
    ├─ REVIEW.md ← 评审标准 
    ├─ docs/ ← 项目知识库 
    │ ├─ architecture/ ← 架构知识 & 隐性约定 
    │ ├─ product/ ← 产品规则 
    │ └─ standards/ ← 测试 & 数据库规范 
    ├─ openspec/ ← OpenSpec 变更管理 
    │ ├─ changes/ ← 进行中的 change 
    │ └─ specs/ ← 当前系统工作原理 
    ├─ .qoder/ ← QoderCn AI 配置 
    │ ├─ agents/ ← 子代理定义 
    │ └─ skills/ ← Skill 定义 
    ├─ src/ ← 源代码 
    └─ pom.xml ← Maven 配置
```

## 工作流

所有需求变更走 OpenSpec 流程：
```aiignore
/opsx:propose → /opsx:apply → /opsx:verify → /opsx:archive
```
| 阶段 | 职责 | 产出物 |
|------|------|--------|
| propose | 需求拆解 | proposal.md、design.md、tasks.md |
| apply | 实施代码变更 | 代码改动 |
| verify | 对齐校验 | 验证报告 |
| archive | 归档 change | 移动到 archive/ |

## License

MIT
