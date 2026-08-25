# QoderCnHarness

> Java 17 + Maven 项目脚手架，以 Maven Archetype 形式发布，内置 OpenSpec 变更管理流程与 QoderCn AI 协作体系。

---

## 特性

- **Java 17 + Maven** 基础工程结构
- **OpenSpec 变更生命周期**：propose → apply → verify → archive
- **QoderCn AI 代理集成**：内置 Skills、Agents、评审标准
- **文档驱动**：架构、产品规则、开发规范分目录管理
- **受保护区域**：配置文件、数据库脚本、密钥等高风险区域有明确护栏

---

## 快速开始

### 方式一：IDEA 中通过 Maven Archetype 创建（推荐）

1. **File → New → New Project**
2. 左侧选择 **Maven Archetype**
3. 点击 **Add Archetype**，填写：
   - **GroupId**: `com.github.twofoursixoone`
   - **ArtifactId**: `qoder-cn-harness-archetype`
   - **Version**: `1.0.0`
4. 选中后填写你自己的项目信息（GroupId、ArtifactId），点击 **Create**

> 首次使用需要在 `settings.xml` 中配置 GitHub Packages 认证，详见下方配置说明。

### 方式二：命令行创建

```bash
mvn archetype:generate \
  -DarchetypeGroupId=com.github.twofoursixoone \
  -DarchetypeArtifactId=qoder-cn-harness-archetype \
  -DarchetypeVersion=1.0.0 \
  -DgroupId=com.yourcompany \
  -DartifactId=your-project
```

---

## 生成后的项目结构

```
your-project/
├─ AGENTS.md                  ← AI 导航地图（入口）
├─ REVIEW.md                  ← 评审标准
├─ docs/                      ← 项目知识库
│  ├─ architecture/           ← 架构知识 & 隐性约定
│  ├─ product/                ← 产品规则
│  └─ standards/              ← 测试 & 数据库规范
├─ openspec/                  ← OpenSpec 变更管理
│  ├─ changes/                ← 进行中的 change
│  └─ specs/                  ← 当前系统工作原理
├─ .qoder/                    ← QoderCn AI 配置
│  ├─ agents/                 ← 子代理定义
│  └─ skills/                 ← Skill 定义
├─ src/                       ← 源代码
└─ pom.xml                    ← Maven 配置
```

---

## 工作流

所有需求变更走 OpenSpec 流程：

```
/opsx:propose → /opsx:apply → /opsx:verify → /opsx:archive
```

| 阶段 | 职责 | 产出物 |
|------|------|--------|
| **propose** | 需求拆解 | proposal.md、design.md、tasks.md |
| **apply** | 实施代码变更 | 代码改动 |
| **verify** | 对齐校验 | 验证报告 |
| **archive** | 归档 change | 移动到 archive/ |

---

## GitHub Packages 配置

本 Archetype 发布在 GitHub Packages，使用前需配置 Maven 认证。

### 1. 生成 Personal Access Token

1. 打开 https://github.com/settings/tokens
2. 点击 **Generate new token (classic)**
3. 勾选 `read:packages` 权限
4. 生成后复制 Token

### 2. 配置 settings.xml

编辑 `~/.m2/settings.xml`：

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

---

## 本地开发（维护 Archetype 本身）

```bash
# 编译
mvn compile

# 安装到本地仓库
mvn install

# 发布到 GitHub Packages
mvn deploy
```

---

## License

MIT
