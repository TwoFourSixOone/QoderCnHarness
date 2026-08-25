<#
.SYNOPSIS
    QoderCnHarness 脚手架初始化脚本
.DESCRIPTION
    替换项目模板中的占位信息为你的项目名称
.EXAMPLE
    .\init.ps1 -GroupId "com.yourcompany" -ArtifactId "your-project" -ProjectName "YourProject"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$GroupId,

    [Parameter(Mandatory=$true)]
    [string]$ArtifactId,

    [Parameter(Mandatory=$true)]
    [string]$ProjectName
)

Write-Host "🚀 初始化项目: $ProjectName ($GroupId:$ArtifactId)" -ForegroundColor Green

$pomPath = Join-Path $PSScriptRoot "pom.xml"
$pomContent = Get-Content $pomPath -Raw
$pomContent = $pomContent -replace '<groupId>com\.example</groupId>', "<groupId>$GroupId</groupId>"
$pomContent = $pomContent -replace '<artifactId>QoderCnHarness</artifactId>', "<artifactId>$ArtifactId</artifactId>"
Set-Content -Path $pomPath -Value $pomContent -NoNewline
Write-Host "  ✅ pom.xml 已更新"

$agentsPath = Join-Path $PSScriptRoot "AGENTS.md"
$agentsContent = Get-Content $agentsPath -Raw
$agentsContent = $agentsContent -replace 'QoderCnHarness', $ProjectName
Set-Content -Path $agentsPath -Value $agentsContent -NoNewline
Write-Host "  ✅ AGENTS.md 已更新"

$readmePath = Join-Path $PSScriptRoot "README.md"
if (Test-Path $readmePath) {
    $readmeContent = Get-Content $readmePath -Raw
    $readmeContent = $readmeContent -replace 'QoderCnHarness', $ProjectName
    Set-Content -Path $readmePath -Value $readmeContent -NoNewline
    Write-Host "  ✅ README.md 已更新"
}

Write-Host ""
Write-Host "🎉 初始化完成！项目已配置为: $ProjectName" -ForegroundColor Green
Write-Host ""
Write-Host "下一步：" -ForegroundColor Yellow
Write-Host "  1. 按需修改 docs/ 下的文档内容"
Write-Host "  2. 运行 'mvn compile' 验证项目结构"
Write-Host "  3. 开始你的第一个变更: /opsx:propose <需求描述>"