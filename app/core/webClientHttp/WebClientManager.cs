using System;
using System.Net;
using System.Text;
using Newtonsoft.Json;

public static class WebClientManager
{
    private static WebClient _client;

    static WebClientManager()
    {
        _client = new WebClient();
        _client.Headers[HttpRequestHeader.ContentType] = "application/json";
    }

    public static void Configure(ModuleConfigHttpRequest config)
    {
        // Limpiar cabeceras previas
        _client.Headers.Clear();

        // Establecer el Content-Type por defecto
        _client.Headers[HttpRequestHeader.ContentType] = "application/json";

        // Agregar cabeceras personalizadas
        if (config.Headers != null)
        {
            foreach (var header in config.Headers)
            {
                _client.Headers[header.Key] = header.Value;
            }
        }

        // Agregar autenticación Bearer si está configurada
        if (!string.IsNullOrEmpty(config.BearerToken))
        {
            _client.Headers[HttpRequestHeader.Authorization] = $"Bearer {config.BearerToken}";
        }
    }

    public static string Get(string url)
    {
        return _client.DownloadString(url);
    }

    public static string Post(string url, object data)
    {
        // Convertir el cuerpo de la solicitud a JSON
        string jsonData = JsonConvert.SerializeObject(data);
        return _client.UploadString(url, jsonData);
    }
}
