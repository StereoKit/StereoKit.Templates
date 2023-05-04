# StereoKit.Templates

These [StereoKit](https://stereokit.net) templates are designed to be used with the `dotnet new` command, for easy use via command-line and environments like Visual Studio Code! The NuGet package for these templates do _not_ need to be referenced from your project, but instead should be installed for `dotnet` to recognize them.

## Usage

```bash
# Install the templates!
dotnet new --install StereoKit.Templates

# Create a .NET Core based StereoKit project, and run it
mkdir StereoKitProjectName
dotnet new sk-net
dotnet run

# Add an unlit shader named "test_shader" to the Assets folder
dotnet new skshader-unlit -n test_shader -o Assets
```

## Pre-requisites

The only pre-requisite for this is the .NET SDK! If you don't have the `dotnet` command, you can install this via winget:

```bash
winget install Microsoft.DotNet.SDK.7
# Restart the Terminal to refresh your Path variable
```

VS Code can also pair nicely with these templates, but they work just as well with Visual Studio "Prime".

### Project templates:

|Id       |Project    | Description                                        |
|---------|-----------|----------------------------------------------------|
|sk-net   |.NET Core  |Simpler project for Windows and Linux desktop XR.   |
|sk-multi |Multitarget|Cross-platform project for Android/Windows/Linux XR.|
|sk-sketch|.NET Core  |Bare-bones XR template for small code sketches.     |

### Item templates:

|Id            |Type  | Description                                           |
|--------------|------|-------------------------------------------------------|
|skstepper     |C#    |A simple empty class that implements IStepper.         |
|skshader-lit  |Shader|A basic shader that uses StereoKit's built-in lighting.|
|skshader-unlit|Shader|A simple shader without any lighting.                  |