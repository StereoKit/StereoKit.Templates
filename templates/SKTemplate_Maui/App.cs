﻿using StereoKit;

namespace SKTemplate_Maui;

public class App
{
	public SKSettings Settings => new SKSettings {
		appName           = "SKTemplate_Maui",
		assetsFolder      = "Assets",
		displayPreference = DisplayMode.MixedReality
	};

	Pose  cubePose = new Pose(0, 0, -0.5f);
	Model cube;
	Matrix   floorTransform = Matrix.TS(0, -1.5f, 0, new Vec3(30, 0.1f, 30));
	Material floorMaterial;

	public void Init()
	{
		// Create assets used by the app
		cube = Model.FromMesh(
			Mesh.GenerateRoundedCube(Vec3.One * 0.1f, 0.02f),
			Material.UI);

		floorMaterial = new Material("floor.hlsl");
		floorMaterial.Transparency = Transparency.Blend;
	}

	public void Step()
	{
		if (SK.System.displayType == Display.Opaque)
			Mesh.Cube.Draw(floorMaterial, floorTransform);

		UI.Handle("Cube", ref cubePose, cube.Bounds);
		cube.Draw(cubePose.ToMatrix());
	}
}