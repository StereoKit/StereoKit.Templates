// To run:
// dotnet run
// dotnet run -p:Android=1

using StereoKit;

SK.Initialize();
SK.Run(() => {
	Mesh.Sphere.Draw(Material.Default, Matrix.TS(0, 0, -0.5f, 0.1f));
});