using System;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;

public class ApiService
{
    private readonly HttpClient _httpClient;

    public ApiService()
    {
        _httpClient = new HttpClient();
    }

    public async Task<string> GetAsync(string url)
    {
        var response = await _httpClient.GetAsync(url);
        return await response.Content.ReadAsStringAsync();
    }

    public async Task<string> PostAsync(string url, string data)
    {
        var response = await _httpClient.PostAsync(url, new StringContent(data));
        return await response.Content.ReadAsStringAsync();
    }

    public async Task<T> GetAsync<T>(string url) where T : class
    {
        var response = await _httpClient.GetAsync(url);
        var json = await response.Content.ReadAsStringAsync();
        return JsonConvert.DeserializeObject<T>(json);
    }

    public async Task<T> PostAsync<T>(string url, string data) where T : class
    {
        var response = await _httpClient.PostAsync(url, new StringContent(data));
        var json = await response.Content.ReadAsStringAsync();
        return JsonConvert.DeserializeObject<T>(json);
    }
}