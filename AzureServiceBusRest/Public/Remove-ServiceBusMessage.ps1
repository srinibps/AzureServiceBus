function Remove-ServiceBusMessage
{
    <#
    .SYNOPSIS
        Completes processing on a locked message and deletes it from the queue or subscription.
    .DESCRIPTION
        This operation completes the processing of a locked message and deletes it from the queue or subscription. This operation should only be called after successfully processing a previously locked message, in order to maintain At-Least-Once delivery assurances.
    .PARAMETER Message
        This should be the message object returned by Get-ServiceMessagePeekLock or GetServiceBusMessageReceiveDelete
    .LINK
        https://msdn.microsoft.com/en-us/library/azure/hh780768.aspx
    #>

    param (
    	$Message,
        [ref]$Config
    )

    $Url =  "https://{0}.servicebus.windows.net/{1}/messages/{2}/{3}" -f $Config.Value.Namespace, $Config.Value.Queue, $Message.MessageId, $Message.LockToken
    $response = SendWebRequest -Url $Url -Method DELETE -Config ([ref]$Config.Value)
}