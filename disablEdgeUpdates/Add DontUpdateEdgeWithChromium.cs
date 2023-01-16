class DontUpdateEdgeWithChromium {
   public void AddRegistryKey()
    {
        try
        {
            RegistryKey key = Registry.LocalMachine.CreateSubKey("SOFTWARE\\Microsoft\\EdgeUpdate");
            key.SetValue("DoNotUpdateToEdgeWithChromium", 1, RegistryValueKind.DWord);
            key.Close();
            Console.WriteLine("Registry key added successfully.");
        }
        catch (Exception ex)
        {
            Console.WriteLine("An error occurred while adding the registry key: " + ex.Message);
        }
    }
}