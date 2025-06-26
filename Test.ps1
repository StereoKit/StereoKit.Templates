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
    [ValidateSet('all','sk-multi','sk-net','sk-sketch')]
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

    if ($template -eq 'all' -or $template -eq 'sk-multi') {
        Push-Location -Path "$PSScriptRoot\templates\SKTemplate_Multi"
        & dotnet run
        & dotnet publish -c Release Projects/Android/SKTemplate_Multi_Android.csproj
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

    if ($template -eq 'all' -or $template -eq 'sk-multi') {
        Push-Location -Path "$PSScriptRoot\templates\SKTemplate_Multi"
        & dotnet workload restore
        & dotnet build
        & dotnet publish -c Release Projects/Android/SKTemplate_Multi_Android.csproj
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
    $multiName = 'Multi-with_Crazy name'
    if (!(Test-Path -Path $multiName)) {
        New-Item -Path . -Name $multiName -ItemType "directory" | Out-Null
    }
    $netName = "net project_Name"
    if (!(Test-Path -Path $netName)) {
        New-Item -Path . -Name $netName -ItemType "directory" | Out-Null
    }
    $sketchName = "Sketch Project"
    if (!(Test-Path -Path $sketchName)) {
        New-Item -Path . -Name $sketchName -ItemType "directory" | Out-Null
    }
    Pop-Location

    if ($template -eq 'all' -or $template -eq 'sk-multi') {

        Write-Host "## Testing sk-multi ##"
        Push-Location -Path "$PSScriptRoot\test\$multiName"
        & dotnet new sk-multi --allow-scripts Yes
        Write-Host "## Testing sk-multi - desktop ##"
        & dotnet run
        Write-Host "## Testing sk-multi - android ##"
        & dotnet publish -c Release "Projects/Android/$($multiName).Android.csproj"
        Pop-Location
    }

    if ($template -eq 'all' -or $template -eq 'sk-net') {
        Write-Host "## Testing sk-net ##"
        Push-Location -Path "$PSScriptRoot\test\$netName"
        & dotnet new sk-net
        & dotnet run
        Pop-Location
    }

    if ($template -eq 'all' -or $template -eq 'sk-sketch') {
        Write-Host "## Testing sk-sketch ##"
        Push-Location -Path "$PSScriptRoot\test\$sketchName"
        & dotnet new sk-sketch
        & dotnet run
        Pop-Location
    }

    Remove-Item -Path "$PSScriptRoot\test" -Recurse -Force | Out-Null
}