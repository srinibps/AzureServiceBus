Function Get-ServiceBusMessageReceiveDelete
{
    <#
    .SYNOPSIS
        Reads and deletes a message from a queue or subscription as an atomic operation.
    .DESCRIPTION
        This operation receives a message from a queue or subscription, and removes the message from that queue or subscription in one atomic operation.
    .LINK
        https://msdn.microsoft.com/en-us/library/azure/hh780770.aspx
    #>

    $Url =  "https://{0}.servicebus.windows.net/{1}/messages/head" -f $script:Namespace, $script:Queue
    $response = SendWebRequest -Url $Url -Method DELETE
    $message = ParseMessage($response)
    $message
}