<#
.Description
For a full test, try this
.\Test.ps1 -reinstall -mode new

For just a reinstall
.\Test.ps1 -reinstall

To test the templates without build/reinstall
.\Test.ps1 -mode run_in_place
#>

param(
    [ValidateSet('run_in_place','build_in_place','new','none')]
    [string]$mode = 'none',
    [ValidateSet('all','sk-multi','sk-net','sk-sketch','sk-maui')]
    [string]$template = 'all',
    [switch]$reinstall = $false
)

$fileData = Get-Content -path "$PSScriptRoot\StereoKit.Templates.csproj" -Raw;
$fileData -match '<PackageVersion>(?<ver>.*)</PackageVersion>' | Out-Null
$version = $Matches.ver

Write-Host "Testing StereoKit.Templates $version"

if ($reinstall -eq $true) {
    & dotnet new uninstall StereoKit.Templates
    & dotnet pack --configuration Release
    & dotnet new install "$PSScriptRoot\bin\Release\StereoKit.Templates.$version.nupkg"
}

if ($mode -eq 'run_in_place') {
    if ($template -eq 'all' -or $template -eq 'sk-maui') {
        Push-Location -Path "$PSScriptRoot\templates\SKTemplate_Maui"
        & dotnet run --framework=net7.0
        Pop-Location
        if ($LASTEXITCODE -ne 0) { return $LASTEXITCODE }
    }

    if ($template -eq 'all' -or $template -eq 'sk-multi') {
        Push-Location -Path "$PSScriptRoot\templates\SKTemplate_Multi"
        & dotnet run
        & dotnet build Projects/Android/SKTemplate_Multi_Android.csproj
        Pop-Location
        if ($LASTEXITCODE -ne 0) { return $LASTEXITCODE }
    }

    
    if ($template -eq 'all' -or $template -eq 'sk-net') {
        Push-Location -Path "$PSScriptRoot\templates\SKTemplate_Net"
        & dotnet run
        Pop-Location
        if ($LASTEXITCODE -ne 0) { return $LASTEXITCODE }
    }

    if ($template -eq 'all' -or $template -eq 'sk-net') {
        Push-Location -Path "$PSScriptRoot\templates\SKTemplate_Sketch"
        & dotnet run
        Pop-Location
        if ($LASTEXITCODE -ne 0) { return $LASTEXITCODE }
    }
} elseif ($mode -eq 'build_in_place') {
    
    if ($template -eq 'all' -or $template -eq 'sk-maui') {
        #Push-Location -Path "$PSScriptRoot\templates\SKTemplate_Maui"
        #& dotnet workload restore
        #& dotnet build --framework=net7.0
        #Pop-Location
        #if ($LASTEXITCODE -ne 0) { return $LASTEXITCODE }
    }

    if ($template -eq 'all' -or $template -eq 'sk-multi') {
        Push-Location -Path "$PSScriptRoot\templates\SKTemplate_Multi"
        & dotnet workload restore
        & dotnet build
        & dotnet build Projects/Android/SKTemplate_Multi_Android.csproj
        Pop-Location
        if ($LASTEXITCODE -ne 0) { return $LASTEXITCODE }
    }

    if ($template -eq 'all' -or $template -eq 'sk-net') {
        Push-Location -Path "$PSScriptRoot\templates\SKTemplate_Net"
        & dotnet build
        Pop-Location
        if ($LASTEXITCODE -ne 0) { return $LASTEXITCODE }
    }

    if ($template -eq 'all' -or $template -eq 'sk-sketch') {
        Push-Location -Path "$PSScriptRoot\templates\SKTemplate_Sketch"
        & dotnet build
        Pop-Location
        if ($LASTEXITCODE -ne 0) { return $LASTEXITCODE }
    }
} elseif($mode -eq 'new') {
    if (!(Test-Path -Path 'test')) {
        New-Item -Path . -Name 'test' -ItemType "directory" | Out-Null
    }

    Push-Location -Path "$PSScriptRoot\test"
    if (!(Test-Path -Path 'multi')) {
        New-Item -Path . -Name 'multi' -ItemType "directory" | Out-Null
    }
    if (!(Test-Path -Path 'net')) {
        New-Item -Path . -Name 'net' -ItemType "directory" | Out-Null
    }
    if (!(Test-Path -Path 'sketch')) {
        New-Item -Path . -Name 'sketch' -ItemType "directory" | Out-Null
    }
    if (!(Test-Path -Path 'maui')) {
        New-Item -Path . -Name 'maui' -ItemType "directory" | Out-Null
    }
    Pop-Location

    if ($template -eq 'all' -or $template -eq 'sk-multi') {
        Push-Location -Path "$PSScriptRoot\test\multi"
        & dotnet new sk-multi
        & dotnet run
        & dotnet build Projects/Android/multi_Android.csproj
        Pop-Location
    }

    if ($template -eq 'all' -or $template -eq 'sk-net') {
        Push-Location -Path "$PSScriptRoot\test\net"
        & dotnet new sk-net
        & dotnet run
        Pop-Location
    }

    if ($template -eq 'all' -or $template -eq 'sk-sketch') {
        Push-Location -Path "$PSScriptRoot\test\sketch"
        & dotnet new sk-sketch
        & dotnet run
        Pop-Location
    }

    if ($template -eq 'all' -or $template -eq 'sk-maui') {
        Push-Location -Path "$PSScriptRoot\test\maui"
        & dotnet new sk-maui
        & dotnet run --framework=net7.0
        Pop-Location
    }

    Remove-Item -Path "$PSScriptRoot\test" -Recurse -Force | Out-Null
}