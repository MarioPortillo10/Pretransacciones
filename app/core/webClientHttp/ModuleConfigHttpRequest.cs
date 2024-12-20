using System.Collections.Generic;

public class ModuleConfigHttpRequest
{
    public string BaseUrl { get; set; }
    public Dictionary<string, string> Headers { get; set; }
    public string BearerToken { get; set; }

    public ModuleConfigHttpRequest(string baseUrl)
    {
        BaseUrl = baseUrl;
        Headers = new Dictionary<string, string>();
    }

    public void AddHeader(string key, string value)
    {
        if (!Headers.ContainsKey(key))
        {
            Headers.Add(key, value);
        }
        else
        {
            Headers[key] = value;
        }
    }
}
