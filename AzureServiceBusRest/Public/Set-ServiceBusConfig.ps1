Function Set-ServiceBusConfig
{
	<#
    .SYNOPSIS
        Sets the configuration for further ServiceBus calls
    .DESCRIPTION
        Sets the configuration for further ServiceBus calls
    #>
	
	[cmdletbinding()]
	param(
		[parameter(ValueFromPipelineByPropertyName = $True)]
        [String]$Namespace,
		[parameter(ValueFromPipelineByPropertyName = $True)]
        [String]$Queue,
		[parameter(ValueFromPipelineByPropertyName = $True)]
        [String]$PolicyName,
		[parameter(ValueFromPipelineByPropertyName = $True)]
        [String]$Key
	)
	
	$script:Namespace = $Namespace
	$script:Queue = $Queue
	$script:PolicyName = $PolicyName
	$script:Key = $Key
	$script:SasExpiration = ""
	$script:SasToken = ""
}