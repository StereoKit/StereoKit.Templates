# StereoKit.Templates

These [StereoKit](https://stereokit.net) templates are designed to be used with the `dotnet new` command, for easy use via command-line and environments like Visual Studio Code! The NuGet package for these templates do _not_ need to be referenced from your project, but instead should be installed for `dotnet` to recognize them.

## Usage

```bash
# Install the templates!
dotnet new --install StereoKit.Templates

# Create a .NET Core based StereoKit project, and run it
mkdir StereoKitProjectName
dotnet new sk-netcore
dotnet run

# Add an unlit shader named "test_shader" to the Assets folder
dotnet new skshader-unlit -n test_shader -o Assets
```

### Project templates:

|Id        |Project    | Description                                        |
|----------|-----------|----------------------------------------------------|
|sk-netcore|.NET Core  |Simpler project for Windows and Linux desktop XR.   |
|sk-multi  |Multitarget|Cross-platform project for Android/Windows/Linux XR.|

### Item templates:

|Id            |Type  | Description                                           |
|--------------|------|-------------------------------------------------------|
|skstepper     |C#    |A simple empty class that implements IStepper.         |
|skshader-lit  |Shader|A basic shader that uses StereoKit's built-in lighting.|
|skshader-unlit|Shader|A simple shader without any lighting.                  |