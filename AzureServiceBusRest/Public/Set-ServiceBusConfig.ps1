Function Set-ServiceBusConfig
{
	<#
    .SYNOPSIS
        Sets the configuration for further ServiceBus calls
    .DESCRIPTION
        Sets the configuration for further ServiceBus calls
    .PARAMETER Namespace
        The Namespace for ServiceBus. eg  https://{namespace}.servicebus.windows.net
    .PARAMETER Queue
        The Queue for the ServiceBus Namespace.  eg https://{namespace}.servicebus.windows.net/{queue}
    .PARAMETER PolicyName
        This is the policy name configured for the Namespace or Queue.
    .PARAMETER Key
        The secret key (primary or secondary) or the PolicyName provided.
    .EXAMPLE
        Set-ServiceBus -Namespace "MyNamespace" -Queue "EventQueue" -PolicyName "RootManageSharedAccessKey" -Key "SuperSecretKeyThatEndsIn="
    #>
	
	[cmdletbinding()]
	param(
        [String]$Namespace,
        [String]$Queue,
        [String]$PolicyName,
        [String]$Key
	)
	
	$script:Namespace = $Namespace
	$script:Queue = $Queue
	$script:PolicyName = $PolicyName
	$script:Key = $Key
	$script:SasExpiration = ""
	$script:SasToken = ""
}