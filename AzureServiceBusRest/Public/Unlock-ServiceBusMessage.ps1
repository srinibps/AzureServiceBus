Function Unlock-ServiceBusMessage
{
    <#
    .SYNOPSIS
        Unlocks a message for processing by other receivers on a specified queue or subscription.
    .DESCRIPTION
        Unlocks a message for processing by other receivers on a specified subscription. This operation deletes the lock object, causing the message to be unlocked. Before the operation is called, a receiver must first lock the message.
    .PARAMETER Message
        This should be the message object returned by Get-ServiceMessagePeekLock or GetServiceBusMessageReceiveDelete
    .LINK
        https://msdn.microsoft.com/en-us/library/azure/hh780737.aspx
    #>

    param(
    	$Message,
        [ref]$Config
    )

    $Url =  "https://{0}.servicebus.windows.net/{1}/messages/{2}/{3}" -f $Config.Value.Namespace, $Config.Value.Queue, $Message.MessageId, $Message.LockToken
    $response = $response = SendWebRequest -Url $Url -Method PUT -Config ([ref]$Config.Value)
}