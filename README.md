# StereoKit.Templates

These [StereoKit](https://stereokit.net) templates are designed to be used with the `dotnet new` command for command-line and environments like Visual Studio Code, and also work with Visual Studio 2022's "New Project" interface! You do not need to clone this repository, these templates can be installed easily via the NuGet package.

## Install

```bash
# Install the templates!
dotnet new install StereoKit.Templates
```

### Pre-requisites

If you don't have the .NET SDK, or the `dotnet` command, you can install this via winget:

```bash
winget install Microsoft.DotNet.SDK.9
# Restart the Terminal to refresh your Path variable
```

On Linux, it may be as simple as this! If not, check [Microsoft's instructions](https://learn.microsoft.com/en-us/dotnet/core/install/linux) for installing `dotnet` on your Linux distribution.

```bash
sudo apt-get install dotnet-sdk-9.0
```

## Usage

The `sk-net` template is a good place to start. It works with VR on Windows and Linux, and provides a good Simulator for development.

```bash
# Create a .NET Core based StereoKit project, and run it
mkdir SKProjectName
cd SKProjectName
dotnet new sk-net
dotnet run
```

### Android Projects

The `sk-multi` template can also deploy to Android devices. While this experience is mostly seamless when using Visual Studio 2022, using CLI or VS Code is not as simple as `dotnet run`. Instead, you must build an apk and install that:

```bash
# Start with an multiplatform project
dotnet new sk-multi
# You _can_ still run the StereoKit Simulator like this
dotnet run
# To run on Android, just run the Android flavored project!
dotnet run --project Projects\Android\SKProjectName.Android.csproj
```

#### Publishing an APK

You can also build and deploy an APK like this! This was the only way to do it in the past, but may still be useful in some scenarios.

```bash
# The build command for making the Android APK
dotnet publish -c Release Projects\Android\SKProjectName.Android.csproj

# Install on device
adb install Projects\Android\bin\Release\net9.0-android\publish\com.companyname.skprojectname-Signed.apk
# Run the APK on device
adb shell monkey -p com.companyname.skprojectname 1
```

Additional information about signing apks while building like this [can be found here](https://learn.microsoft.com/en-us/dotnet/maui/android/deployment/publish-cli).

### Items

```bash
# Add an unlit shader named "test_shader" to the Assets folder
dotnet new skshader-unlit -n test_shader -o Assets

# Add an shader with default lighting named "test_lit_shader" to the Assets
# folder
dotnet new skshader-lit -n test_lit_shader -o Assets

# Add a basic IStepper template called SomeSystem
dotnet new skstepper -n SomeSystem.cs
```

## Templates

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