Add-Type -Language CSharp @"
public class Message{
    public System.Int32 DeliveryCount;
    public System.Int32 EnqueuedSequenceNumber;
    public System.DateTime EnqueuedTimeUtc;
    public System.String LockToken;
    public System.DateTime LockedUntilUtc;
    public System.String MessageId;
    public System.String PartitionKey;
    public System.Int64 SequenceNumber;
    public System.String State;
    public System.Int32 TimeToLive;
    public System.String Content;
    public System.DateTime DequeuedTimeUtc;
}
"@;

$Namespace
$Queue
$PolicyName
$Key
$SasExpiration
$SasToken

#Get public and private function definition files.
    $Public = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 )
	$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 )

#Dot source the files
    Foreach($import in @($Public + $Private))
    {
        Try
        {
            . $import.fullname
        }
        Catch
        {
            Write-Error -Message "Failed to import function $($import.fullname): $_"
        }
    }
	
Export-ModuleMember -Function $Public.Basename