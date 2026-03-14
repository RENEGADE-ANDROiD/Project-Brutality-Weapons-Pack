<#
.SYNOPSIS
    Packages the Project Brutality Weapons Pack into a clean .pk3 file.
.DESCRIPTION
    Creates a pk3 (zip) archive of the mod, excluding reference-only directories,
    build artifacts, and non-runtime files that would cause class collisions or
    parser errors when loaded alongside PB Staging.
#>

param(
    [string]$OutputPath = ".\PBWP.pk3"
)

$ErrorActionPreference = "Stop"

$projectRoot = $PSScriptRoot

$excludeDirs = @(
    "PB_Staging",
    ".git",
    ".cursor",
    ".vscode",
    "agent-transcripts"
)

$excludeFiles = @(
    "build_pk3.ps1",
    "AGENTS.md",
    "CHANGELOG.md",
    "AGENTIC_CHANGELOG.md",
    ".gitignore",
    ".DS_Store"
)

$excludeExtensions = @(
    ".md"
)

if (Test-Path $OutputPath) {
    Remove-Item $OutputPath -Force
    Write-Host "Removed existing $OutputPath"
}

$allFiles = Get-ChildItem -Path $projectRoot -Recurse -File

$filtered = $allFiles | Where-Object {
    $relativePath = $_.FullName.Substring($projectRoot.Length + 1)
    $parts = $relativePath -split '[/\\]'

    $excluded = $false
    foreach ($dir in $excludeDirs) {
        if ($parts[0] -eq $dir) {
            $excluded = $true
            break
        }
    }
    if ($excluded) { return $false }

    if ($_.Name -in $excludeFiles) { return $false }

    if ($_.Extension -in $excludeExtensions -and $parts.Count -eq 1) { return $false }

    return $true
}

$tempDir = Join-Path $env:TEMP "pbwp_pk3_build_$(Get-Random)"
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

try {
    foreach ($file in $filtered) {
        $relativePath = $file.FullName.Substring($projectRoot.Length + 1)
        $destPath = Join-Path $tempDir $relativePath
        $destDir = Split-Path $destPath -Parent
        if (-not (Test-Path $destDir)) {
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        }
        Copy-Item $file.FullName -Destination $destPath
    }

    Compress-Archive -Path "$tempDir\*" -DestinationPath $OutputPath -Force
    $finalSize = (Get-Item $OutputPath).Length / 1MB
    Write-Host "Built $OutputPath ($([math]::Round($finalSize, 2)) MB) with $($filtered.Count) files"
    Write-Host "Excluded directories: $($excludeDirs -join ', ')"
} finally {
    Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
}
