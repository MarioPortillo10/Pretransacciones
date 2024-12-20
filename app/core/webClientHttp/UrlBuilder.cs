public class UrlBuilder
{
    private string _baseUrl;
    private string _endpoint;
    private string _param;
    private Dictionary<string, string> _queryParams = new Dictionary<string, string>();

    public UrlBuilder(string baseUrl, string endpoint)
    {
        if (string.IsNullOrEmpty(baseUrl) || string.IsNullOrEmpty(endpoint))
        {
            throw new ArgumentException("La URL base y el endpoint no pueden ser nulos o vacíos.");
        }

        _baseUrl = baseUrl.TrimEnd('/');
        _endpoint = endpoint.TrimStart('/');
    }

    public UrlBuilder AddParamAsUrl(string param)
    {
        if (string.IsNullOrEmpty(param))
        {
            throw new ArgumentException("El parámetro no puede ser nulo o vacío.");
        }

        _param = param;
        return this; // Permite encadenar métodos.
    }

    public UrlBuilder AddParamAsGet(string key, string value)
    {
        if (string.IsNullOrEmpty(key) || string.IsNullOrEmpty(value))
        {
            throw new ArgumentException("La clave y el valor no pueden ser nulos o vacíos.");
        }

        _queryParams[key] = value;
        return this; // Permite encadenar métodos.
    }

    public string Build()
    {
        // Construir la URL base con el endpoint y el parámetro de URL, si existe.
        string url = string.IsNullOrEmpty(_param) ? 
                     $"{_baseUrl}/{_endpoint}" : 
                     $"{_baseUrl}/{_endpoint}/{_param}";

        // Agregar los parámetros de consulta (GET) si existen.
        if (_queryParams.Count > 0)
        {
            var queryString = string.Join("&", _queryParams.Select(kvp => $"{kvp.Key}={kvp.Value}"));
            url = $"{url}?{queryString}";
        }

        return url;
    }
}