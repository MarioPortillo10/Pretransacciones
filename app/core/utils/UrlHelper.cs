public static class UrlHelper
{
    public static string CleanUrl(string baseUrl, string endpoint)
    {
        if (string.IsNullOrEmpty(baseUrl) || string.IsNullOrEmpty(endpoint))
        {
            throw new ArgumentException("La URL base y el endpoint no pueden ser nulos o vacíos.");
        }

        return $"{baseUrl.TrimEnd('/')}/{endpoint.TrimStart('/')}";
    }
}
