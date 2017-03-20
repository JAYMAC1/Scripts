Function Get-SMBSharePermissions {

    [CmdletBinding()]
    Param(
        [Parameter()]
        [String[]]$ComputerName,

        [Parameter()]
        [Switch]$Log,

        [Parameter()]
        [String]$LogPath
    )

    BEGIN{}
    PROCESS{
        ForEach($Computer in $ComputerName){
            $continue = $false
            Try {
                Write-Verbose("Trying to connect to {0}" -f $Computer)
                $shares = Get-WmiObject -Class Win32_LogicalShareSecuritySetting -ErrorAction Stop
                $continue = $true
            } Catch {
                
            }
        }
    
    }
    END{}

}

$shares = Get-WmiObject -Class Win32_LogicalShareSecuritySetting