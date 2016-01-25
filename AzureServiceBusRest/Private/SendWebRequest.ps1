Function SendWebRequest
{
    param
    (
        $Url,
        $Method,
        $Content,
        [ref]$Config
    )

    UpdateAzureServiceBusToken -Config ([ref]$Config.Value)

    $headers = @{ "Authorization" = $Config.Value.SasToken
                  "Host" = "{0}.servicebus.windows.net" -f $Config.Value.Namespace}

    if ($Content)
    {
        return (Invoke-WebRequest $Url -Headers $headers -Method $Method -UseBasicParsing -Body $Content -ContentType "application/atom+xml;type=entry;charset=utf-8")
    }
    else
    {
        return (Invoke-WebRequest $Url -Headers $headers -Method $Method -UseBasicParsing)    
    }
}