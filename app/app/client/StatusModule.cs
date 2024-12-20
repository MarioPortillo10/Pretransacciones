public class StatusModule : ApiModuleManager
{
    private readonly ModuleConfigHttpRequest _config;

    public StatusModule()
    {
        // Configuración predeterminada
        _config = new ModuleConfigHttpRequest("https://api.example.com")
        {
            BearerToken = "tu_token_bearer_aqui",
            Headers = new Dictionary<string, string>
            {
                { "Custom-Header", "CustomValue" }
            }
        };
    }

    private void ConfigureRequest()
    {
        WebClientManager.Configure(_config);
    }

    public string GetStatus()
    {
        // Configurar antes de la solicitud
        ConfigureRequest();
        string url = UrlHelper.CleanUrl(_config.BaseUrl, "status");
        return WebClientManager.Get(url);
    }

    public string UpdateStatus(string newStatus)
    {
        // Configurar antes de la solicitud
        ConfigureRequest();
        string url = UrlHelper.CleanUrl(_config.BaseUrl, "status");
        var data = new { status = newStatus };
        return WebClientManager.Post(url, data);
    }
}
