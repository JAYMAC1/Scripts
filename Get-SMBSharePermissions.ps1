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
                Write-Waring ("Failed to connect to server {0}" -f $computer)
            }

            If($continue){
                ForEach($share in $shares){
                    
                    $Dacls = $share.getSecurityDescriptor().descriptor.dacl
                    $i = 0
                    Foreach($dacl in $dacls){
                        
                        $AccessMask = $share.getSecurityDescriptor().descriptor.dacl[$i].AccessMask
                        
                        $properties = [pscustomobject][ordered]@{
                            'ShareName'=$share.Name;
                            'Trustee'=$Trustee;
                            'TrusteeDomain'=$Domain
                            'AccessMask'=$AccessMask;
                        }
                        $i = $i + 1
                        Write-Output -InputObject $properties
                        
                    }                   
                }
            }
        }
    
    }
    END{}

}

Get-SMBSharePermissions -ComputerName lab-srv1