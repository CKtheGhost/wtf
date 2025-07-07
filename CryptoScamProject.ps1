#requires -Version 7.5.1
<#
.SYNOPSIS
  Scaffold a new Crypto Scam Analysis React/TSX project structure

.DESCRIPTION
  Creates a root folder, then the src/, types/, analysisPipelines/ and UI/ subfolders,
  and populates each with an empty .tsx or .ts file.

.PARAMETER ProjectPath
  Path to the new project directory. Defaults to ".\CryptoScamProject".

.EXAMPLE
  .\New-CryptoScamProject.ps1 -ProjectPath "C:\Users\You\Projects\CryptoScamAnalysis"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string] $ProjectPath = ".\CryptoScamProject"
)

# Resolve full path
$fullPath = Resolve-Path -Path $ProjectPath -ErrorAction SilentlyContinue
if (-not $fullPath) {
    $fullPath = [System.IO.Path]::GetFullPath($ProjectPath)
}

Write-Host "Scaffolding new project at:" $fullPath -ForegroundColor Cyan

# Define directory structure
$directories = @(
    "$fullPath\src",
    "$fullPath\src\types",
    "$fullPath\src\analysisPipelines",
    "$fullPath\src\UI"
)

# Create directories
foreach ($dir in $directories) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    Write-Host "  ▶ Created directory" $dir
}

# Define files to create
$files = @(
    "$fullPath\src\crypto-scam-analysis.tsx",
    "$fullPath\src\types\types.ts",
    "$fullPath\src\analysisPipelines\analysisPipelines.ts",
    "$fullPath\src\UI\FeedbackComponents.tsx",
    "$fullPath\src\UI\ChartProps.ts",
    "$fullPath\src\UI\OverviewCharts.tsx",
    "$fullPath\src\UI\ForensicsCharts.tsx",
    "$fullPath\src\UI\TransactionsTable.tsx",
    "$fullPath\src\UI\NetworkSankey.tsx",
    "$fullPath\src\UI\TimelineChart.tsx"
)

# Create files
foreach ($file in $files) {
    if (-not (Test-Path $file)) {
        New-Item -ItemType File -Path $file -Force | Out-Null
        Write-Host "  ◦ Created file" $file
    } else {
        Write-Host "  ◦ Skipped (already exists)" $file -ForegroundColor Yellow
    }
}

Write-Host "`nProject scaffold complete!" -ForegroundColor Green
