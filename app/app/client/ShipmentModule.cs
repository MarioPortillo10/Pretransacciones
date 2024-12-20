public class ShipmentModule : ApiModuleManager
{
    private readonly ModuleConfigHttpRequest _config;

    public ShipmentModule()
    {
        // Configuración predeterminada
        _config = new ModuleConfigHttpRequest("http://localhost:")
        {
            BearerToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IkNhYmHDsWFzX2luZ2VuaW8iLCJzdWIiOjIsInJvbGVzIjpbImNsaWVudGUiXSwiaWF0IjoxNzI5ODg0ODc3LCJleHAiOjE3Mjk5NzEyNzd9.8i_Uu28Ih9ZyY_AF3b4iu0Y-8UfFM2L9OuLDyFslhGk",
            Headers = new Dictionary<string, string>
            {
                { "Content-Type", "application/json" }
            }
        };
    }

    private void ConfigureRequest()
    {
        WebClientManager.Configure(_config);
    }

    public string GetShipmentByCodeGen(string codegen)
    {
        // Configurar antes de la solicitud
        ConfigureRequest();
        string url = UrlApi.CleanUrl(_config.BaseUrl, "shipping")
                   .AddParamAsUrl("codegen")
                   .Build();
        return WebClientManager.Get(url);
    }

}
