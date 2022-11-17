using StereoKit;

class IStepperTemplate : IStepper
{
	public bool Enabled => true;

	public bool Initialize()
	{
		return true;
	}

	public void Shutdown()
	{
		
	}

	public void Step()
	{

	}
}