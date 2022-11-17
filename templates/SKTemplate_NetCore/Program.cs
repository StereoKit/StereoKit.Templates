﻿using System;
using StereoKit;

// Initialize StereoKit
SKSettings settings = new SKSettings
{
	appName      = "SKTemplate_NetCore",
	assetsFolder = "Assets",
};
if (!SK.Initialize(settings))
	Environment.Exit(1);


// Create assets used by the app
Pose  cubePose = new Pose(0,0,-0.5f, Quat.Identity);
Model cube     = Model.FromMesh(
	Mesh.GenerateRoundedCube(Vec3.One*0.1f, 0.02f),
	Default.MaterialUI);

Matrix   floorTransform = Matrix.TS(0, -1.5f, 0, new Vec3(30, 0.1f, 30));
Material floorMaterial  = new Material(Shader.FromFile("floor.hlsl"));
floorMaterial.Transparency = Transparency.Blend;


// Core application loop
SK.Run(() =>
{
	if (SK.System.displayType == Display.Opaque)
		Mesh.Cube.Draw(floorMaterial, floorTransform);

	UI.Handle("Cube", ref cubePose, cube.Bounds);
	cube.Draw(cubePose.ToMatrix());
});