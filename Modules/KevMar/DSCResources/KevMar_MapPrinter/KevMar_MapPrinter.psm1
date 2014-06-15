
#######################################################################
# The Get-TargetResource cmdlet.
#######################################################################
function Get-TargetResource
{
    [CmdletBinding()]
	[OutputType([System.Collections.Hashtable])]
    param
	(	
        # Network path to printer
        [parameter(Mandatory)]
        [string] $Path
	)
    
    $printer = Get-WmiObject Win32_Printer | Where-Object{$_.Name -eq $Path}	
    if($printer){
       Write-Verbose "Printer $path found"
       return @{
            Name = $printer.Name
        }
    } else {
        Write-Verbose "Not found"
        return $null;
    }
}

######################################################################## 
# The Set-TargetResource cmdlet.
########################################################################
function Set-TargetResource
{
    
    [CmdletBinding()]
	param
	(	
        # Network path of printer
        [parameter(Mandatory)]
        [string] $Path,

        # Should the printer be created or deleted
		[ValidateSet("Present","Absent")]
		[String]$Ensure = "Present"
	)

    if($Ensure -eq "Present"){     
        Write-Verbose "Adding printer $path"
        rundll32 printui.dll,PrintUIEntry /ga /n$path /z
    } 
    else #$Ensure -eq "Absent"
    {
        Write-Verbose "Removing printer $path"
         rundll32 printui.dll,PrintUIEntry /gd /n$path
    }
}

#######################################################################
# The Test-TargetResource cmdlet.
#######################################################################
function Test-TargetResource
{
	[CmdletBinding()]
	param
	(	
        # Network path to printer
        [parameter(Mandatory)]
        [string] $Path,

        # Should the printer be created or deleted
		[ValidateSet("Present","Absent")]
		[String]$Ensure = "Present"
	)

    $printer = Get-TargetResource -Path $Path

    # found printer and there should be one
    if($printer -ne $null -and $Ensure -eq "Present"){
        Write-Verbose "found printer and there should be one"
        return $true
    }

    # no printer should be found
    elseif($printer -eq $null -and $Ensure -eq "Absent"){
        Write-Verbose "no printer should be found"
        return $true
    }

    # everything else indicates test failed
    Write-Verbose "Test for resource failed"
    return $false
    
}

Export-ModuleMember -Function *-TargetResource

