# 项目架构总览

> 本文件描述 QoderCnHarness 项目的整体架构设计，帮助 AI 快速了解系统全貌。

---

## 1. 项目概述

- **项目名称**：QoderCnHarness
- **技术栈**：Java 17 + Maven
- **项目定位**：Harness 工程实践示范项目

---

## 2. 项目结构

```
QoderCnHarness/
├─ src/
│  ├─ main/java/          ← 主代码目录
│  └─ main/resources/     ← 资源文件目录
├─ src/test/java/         ← 测试代码目录
├─ pom.xml                ← Maven 配置
├─ AGENTS.md              ← AI 导航地图
├─ REVIEW.md              ← 评审标准
├─ docs/                  ← 项目知识库
└─ openspec/              ← OpenSpec 变更管理
```

---

## 3. 分层架构规范

项目采用标准 Java 分层架构，各层职责如下：

### Controller 层
- **职责**：接收 HTTP 请求，参数校验，返回响应
- **禁止**：包含任何业务逻辑、直接操作数据库
- **包路径**：`com.example.controller`

### Service 层
- **职责**：核心业务逻辑处理，事务管理
- **原则**：单一职责，一个 Service 只负责一个业务域
- **包路径**：`com.example.service`

### DAO/Repository 层
- **职责**：数据访问，SQL 执行
- **禁止**：包含业务逻辑
- **包路径**：`com.example.repository` / `com.example.mapper`

### Model/Entity 层
- **职责**：数据模型定义
- **包路径**：`com.example.model` / `com.example.entity`

### DTO/VO 层
- **职责**：数据传输对象、视图对象
- **包路径**：`com.example.dto` / `com.example.vo`

### Config 层
- **职责**：配置类
- **包路径**：`com.example.config`

---

## 4. 构建与运行

```bash
# 编译
mvn compile

# 运行测试
mvn test

# 打包（跳过测试）
mvn package -DskipTests
```

---

## 5. 依赖管理

所有依赖通过 `pom.xml` 管理，当前配置：
- Java 版本：17
- 编码：UTF-8
- 构建工具：Maven
