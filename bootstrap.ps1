$ErrorActionPreference = 'Stop'

$owner = 'joao-vcthr'
$repo = 'gamwin'
$version = 'v0.1.0'

$tempRoot = Join-Path $env:TEMP 'gamwin'
$zipPath = Join-Path $tempRoot "$version.zip"
$extractPath = Join-Path $tempRoot $version

$downloadUrl = "https://github.com/$owner/$repo/archive/refs/tags/$version.zip"

if (Test-Path $tempRoot) {
    Remove-Item $tempRoot -Recurse -Force
}

New-Item -ItemType Directory -Path $tempRoot | Out-Null

Write-Host "Downloading $repo $version..."

Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath

Write-Host 'Extracting...'

Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

$projectRoot = Get-ChildItem $extractPath -Directory | Select-Object -First 1

$mainScript = Join-Path $projectRoot.FullName 'main.ps1'

if (-not (Test-Path $mainScript -PathType Leaf)) {
    throw "main.ps1 not found at: $mainScript"
}

Write-Host 'Starting...'

& $mainScript
