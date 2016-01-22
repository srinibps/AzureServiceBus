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
    	$Message
    )

    $Url =  "https://{0}.servicebus.windows.net/{1}/messages/{2}/{3}" -f $script:Namespace, $script:Queue, $Message.MessageId, $Message.LockToken
    $response = SendWebRequest -Url $Url -Method PUT
}