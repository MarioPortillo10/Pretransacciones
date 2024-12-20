
public static class UrlApi
{
    public static UrlBuilder CleanUrl(string baseUrl, string endpoint)
    {
        return new UrlBuilder(baseUrl, endpoint);
    }
}