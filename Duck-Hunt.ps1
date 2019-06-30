Function Show-MainMenu {
    param (
        [string]$Title = "Main Menu"
        )
    Clear-Host
    [console]::BackgroundColor = "Black"
    Write-Host "================ $Title ================="
    Write-Host " "   
    
    $Options=@"
        [1] : Setup Menu 
        [2] : Hunt Menu 
        [3] : System Info Menu 
        [4] : Create Baseline #Still in Progress
        [5] : Comparison Menu #Still in Progress
        [6] : Help Menu
        [Q] : Exit the Program
"@
    

    $Options
    $selection = Read-Host "Please make a selection"
    

    switch ($selection)
        {
            '1' {
                Write-Host "Getting Setup Menu..." -ForegroundColor Cyan
                Show-SetupMenu
            }
            '2' {
                Write-Host "Getting the Hunt Menu..." -ForegroundColor Cyan
                Show-HuntMenu
            }
            '3' {
                Write-Host "Getting the System Info Menu..." -ForegroundColor Cyan
                Show-SystemInfoMenu
            }
            '4' {
                Write-Host "Getting the Hunt Menu..." -ForegroundColor Cyan
                Create-Baseline
            }
            '5' {
                Write-Host "Getting the Comparison Menu..." -ForegroundColor Cyan
                Show-ComparisonMenu
            }
            '6' {
                Write-Hosts "Quiting..." -ForegroundColor Cyan
                exit
            }
        }
    }



#The Setup Menu is complete. Needs Testing. Contents of the Setup Menu may need additional work.
Function Show-SetupMenu {
    param (
        [string]$Title = "Setup Menu"
        )
    Clear-Host
    Write-Host "================ $Title ================="
    Write-Host " "

    $options=
@" 
            [1] : Run Full Setup
            [2] : Setup Execution Policy
            [3] : Setup Working Directory
            [4] : Setup Trusted Hosts Information
            [5] : Gather Host Information
            [6] : Gather Credentials
            [7] : Gather IOC Information
            [M] : Return to the Main Menu
            [Q] : Exit the Program
"@    
    
    $Options
    $selection = Read-Host "Please make a selection "  
    
    switch ($selection)
    {
        
        '1' {
            Write-Host "Running Setup..." -ForegroundColor Cyan
            Write-Host ""
            Set-ExPol
            Set-WorkingDirectory
            Set-TrustedHosts
            Set-Hosts
            Set-Creds
            Set-IOCInformation
            Write-Host ""
            Write-Host "Setup is Complete..." -ForegroundColor Green
            Show-MainMenu
        }
        '2' {
            Set-ExPol
            Show-SetupMenu
        }
        '3' {
            Set-WorkingDirectory
            Show-SetupMenu
        }
        '4' {
            Set-TrustedHosts
            Show-SetupMenu
        }
        '5' {
            Set-Hosts
            Show-SetupMenu
        }
        '6' {
            Set-Creds
            Show-SetupMenu
        }
        '7' {
            Set-IOCInformation
            Show-SetupMenu
        }
        'M' {
            Show-MainMenu
        }
  
    }
}

Function Show-HuntMenu {
    param (
        [string]$Title = "Hunt Menu"
        )
    Clear-Host
    Write-Host "================ $Title ================="
    Write-Host " "
    $options=
@" 
            [1] : Check for Known File IOCs
            [2] : Check for Known Scheduled Task IOCs
            [3] : Check for Known Registry IOCs
            [4] : Check for Known IP Address IOCs
            [5] : Check for Known Domain Name IOCs
            [M] : Return to Main Menu
            [Q] : Exit the Program
"@

    $options
    $selection = Read-Host "Please make a selection" 
    
    switch ($selection)
    {
        
        '1' {
            Write-Host "Searching the Remote System for Known File IOCs..." -ForegroundColor Cyan
            Write-Host "Results can be Displayed to console or sent to a csv file." -ForegroundColor Yellow
            Read-Host "Do you want to Display the results to the console: yes or no"
            Find-FileIOCs
        }
        '2' {
            Write-Host "Searching the Remote System for Known Scheduled Tasks IOCs..." -ForegroundColor Cyan
            Write-Host "Results can be Displayed to console or sent to a csv file." -ForegroundColor Yellow
            Read-Host "Do you want to Display the results to the console: yes or no"
          
            Find-ScheduledTaskIOCs
        }
        '3' {
            Write-Host "Searching the Remote System for Known Registry IOCs..." -ForegroundColor Cyan
            Write-Host "Results can be Displayed to console or sent to a csv file." -ForegroundColor Yellow
            Read-Host "Do you want to Display the results to the console: yes or no"

            Find-RegistryIOCs
        }
        '4' {
            Write-Host "Searching the Remote System for Known IP Address IOCs..." -ForegroundColor Cyan
            Write-Host "Results can be Displayed to console or sent to a csv file." -ForegroundColor Yellow
            Read-Host "Do you want to Display the results to the console: yes or no"
            Find-IpIOCs
        }
        '5' {
            Write-Host "Searching the Remote System for Known Domain Name IOCs..." -ForegroundColor Cyan
            Write-Host "Results can be Displayed to console or sent to a csv file." -ForegroundColor Yellow
            Read-Host "Do you want to Display the results to the console: yes or no"
            Find-DomainIOCs
        }
        'M' {
            Show-MainMenu
        }
    }
 }
 
 Function Show-SystemInfoMenu {       
    param (
        [string]$Title = "System Information Menu"
        )
    Clear-Host
    Write-Host "================ $Title ================="
    Write-Host " "
    $options=
@" 
            [1] : List Common Registry Persistence Keys
            [2] : List Sticky Keys Registry Keys
            [3] : List All Registered Scheduled Tasks
            [4] : Find A Specific File on the C: Drive
            [5] : List Directory Contents
            [6] : List Services
            [7] : List Processes
            [8] : List AutoRuns
            [9] : Get User Information
            [10] : Get Group Information
            [11] : Get LocalGroup Information
            [12] : Get Network Shares #Still in Progress
            [13] : Get Logical Drives
            [M] : Return to the Main Menu
            [Q] : Exit the Program

"@    
    
    $options
    $selection = Read-Host "Please make a selection"
    
    switch ($selection) {
           
        '1' {
            Write-Host "Getting contents of registry keys for common persistence locations..." -ForegroundColor Cyan
            Write-Host "Results can be Displayed to console or sent to a csv file." -ForegroundColor Yellow
            $SysInfo = 'True'
            List-PersistentRegistryKeys
            $SysInfo = 'False'
        }
        '2' {
            Write-Host "Getting contents of registry keys that are set during a sticky keys attack..." -ForegroundColor yellow
            $SysInfo = 'True'
            List-StickyKeys
            $SysInfo = 'False'
        }
        '3' {
            
            $SysInfo = 'True'
            Get-SchTasks
            $SysInfo = 'False'
        }
        '4' {
            Write-Host "Checking the filesystem for a specific file..." -ForegroundColor yellow
            $SysInfo = 'True'
            Invoke-FindFile
            $SysInfo = 'False'
        }
        '5' {
            Write-Host "Listing the contents of a specified directory location..." -ForegroundColor yellow
            $SysInfo = 'True'
            Get-DirectoryContents
            $SysInfo = 'False'
        }
        '6' {
            Write-Host "List all services on the remote system..." -ForegroundColor yellow
            Write-Host "Results can be displayed to console or sent to a csv file." -ForegroundColor Yellow
            $SysInfo = 'True'
            Get-ServiceInfo
            $SysInfo = 'False'
        }
        '7' {
            Write-Host "List all autoruns on the remote system..." -ForegroundColor yellow
            $SysInfo = 'True'
            Get-ProcessInfo
            $SysInfo = 'False'
        }
        '8' {
            Write-Host "List all autoruns on the remote system..." -ForegroundColor yellow
            $SysInfo = 'True'
            Get-AutoRuns
            $SysInfo = 'False'
        }
        '9' {
            Write-Host "List all users on the remote system..." -ForegroundColor yellow
            $SysInfo = 'True'
            Get-UserInfo
            $SysInfo = 'False'
        }
        '10' {
            Write-Host "List all groups on the remote system..." -ForegroundColor yellow
            $SysInfo = 'True'
            Get-GroupInfo
            $SysInfo = 'False'
        }
        '11' {
            Write-Host "List all local groups on the remote system..." -ForegroundColor yellow
            $SysInfo = 'True'
            Get-LocalGroupInfo
            $SysInfo = 'False'
        }
        '12' {
            Write-Host "Getting network drive information on the remote system(s)" -ForegroundColor yellow
            $SysInfo = 'True'
            Get-NetworkDrives
            $SysInfo = 'False'
        }
        '13' {
            Write-Host "Getting logical drive information on the remote system(s)" -ForegroundColor yellow
            $SysInfo = 'True'
            Get-LogicalDrives
            $SysInfo = 'False'
        }
        'M' {
            Show-MainMenu
        }
    }
}    

Function Create-Baseline {
param (
        [string]$Title = "Create Baseline"
        
        )
    Clear-Host
    Write-Host "================ $Title ================="
    Write-Host " "
    Write-Host "The Baseline Menu will run a series of tasks and outputs the results of those tasks to your current working Directory."
    Write-Host "Use the Comparison Menu to run scripts that will re-run the same commands and run comparisons against this baseline."

    $Output_To_File = "yes"
    #List-PersistentRegistryKeys
    #Get-SchTasks
    #Get-ServiceInfo
    #Get-ProcessInfo
    #Get-UserInfo
    #Get-LocalGroupinfo
    #Get-NetworkDrives
    #Get-LogicalDrives        
    Get-FileSystemHash
 }        
  
Function Set-ExPol {
    Write-Host "Setup the Execution Policy on the box..." -ForegroundColor Cyan
    if((Get-ExecutionPolicy) -ne 'Unrestricted') 
    { 
        Set-ExecutionPolicy Unrestricted -Force
        Write-Host "Execution Policy is set to unrestricted." -ForegroundColor Green
    }
    else {
        Write-Host "Execution Policy is already set." -ForegroundColor Green
    }
}

Function Set-WorkingDirectory {
    
    $path = Read-Host "Please enter the path to your working directory"
    
    $global:Directory = $path
    $pathBase = $path.split('\')[!-1]
    $folder = $path.split('\')[-1]
    
    Write-Host "Checking if the current working directory exists..." -ForegroundColor Cyan 
    If ([System.IO.Directory]::Exists($Directory)) {
        Write-Host ""
        Write-Host "Current Working Directory exists at $Directory"
        
    }
    else {
        Write-Host "Current Directory doesn't exist..." -ForegroundColor Cyan
        Write-Host "Setting up your working directory @ $Directory" -ForegroundColor Cyan
        new-item -Path "$pathBase" -Name "$folder" -ItemType Directory
    }

    cd $Directory
    Write-Host ""
    Write-Host "The Working Directory is set @ $Directory" -ForegroundColor Green
} 

Function Create-HostDirectory {
   
   foreach ($h in $hosts) {
       Write-Host "Checking if the directory exists..." -ForegroundColor Cyan
        If (Test-Path $h) {
            Write-Host "The host directory already exists in your working directory: $Directory"
        
        }
        else {
            Write-Host "The host directory doesn't exist..." -ForegroundColor Cyan
            Write-Host "Creating the host directory in your working directory: $Directory..." -ForegroundColor Cyan
            new-item -Path "$Directory" -Name "$h" -ItemType Directory
            Write-Host "The host directory has been created in your working directory: $Directory..." -ForegroundColor Green
        } 
    }
}      
     
Function Set-TrustedHosts {
        Param (
        [string]$TrustedHosts
        )
        
        Write-Host "Setting up the Trusted Hosts file..." -ForegroundColor Cyan

        #Set the path for trusted Hosts
        $trustedhostpath = "WSMan:\localhost\Client\TrustedHosts"
        
        $subnet = Read-Host "Enter a subnet for your IP address range (Example: 172.16.12.*)"
        Write-Host "Checking information on Trusted Hosts..." -ForegroundColor Cyan
        #check if the $subnet is part of trusted hosts, if not, add the subnet ot 
        if((Get-Item -Path $trustedhostpath).Value -ne $subnet) 
        { 
            Write-Host "Setting Trusted Host information for Trusted Hosts..." -ForegroundColor Cyan
            Set-Item $trustedhostpath -Value * -Force 
        }
        Write-Host "Information on Trusted Host is set..." -ForegroundColor green
    }
    
Function Set-Hosts {

    Write-Host "You can specify the path to a host file or let the system discover it from the subnet provided." -ForegroundColor Cyan     
    
    $Input_Host_File = Read-Host "Do you want to specify the path to a host file?" 

    if ($Input_Host_File -eq 'yes') {

        $global:hosts = @(Get-Content (Read-Host "Please enter the path to your host file (No qoutes around patch)"))
    }
    else {
        Write-Host "This will take several minutes for a /24 Subnet." -ForegroundColor Yellow
        Invoke-PingSweep
    }

    Create-HostDirectory

    Write-Host "Hosts file has been set..." -ForegroundColor Green

}

Function Invoke-PingSweep {
    [cmdletbinding()]
    Param(
    [Parameter(Position=0,HelpMessage="Enter an IPv4 subnet ending in 0.")]
    [ValidatePattern("\d{1,3}\.\d{1,3}\.\d{1,3}\.0")]
    [string]$Subnet= ((Get-NetIPAddress -AddressFamily IPv4).Where({$_.InterfaceAlias -notmatch "Bluetooth|Loopback"}).IPAddress -replace "\d{1,3}$","0"),
 
    [ValidateRange(1,255)]
    [int]$Start = 1,
 
    [ValidateRange(1,255)]
    [int]$End = 254,
 
    [ValidateRange(1,10)]
    [Alias("count")]
    [int]$Ping = 1,
 
    [int]$Port
    )
    
    $Output_To_File = Read-Host "Do you want to output the hostnames to a host file?"

    Write-Verbose "Pinging $subnet from $start to $end"
    Write-Verbose "Testing with $ping pings(s)"
 
    #a hash table of parameter values to splat to Write-Progress
    $proghash = @{
     Activity = "Ping Sweep"
     CurrentOperation = "None"
     Status = "Pinging IP Address"
     PercentComplete = 0
    }
 
    #How many addresses need to be pinged?
    $count = ($end - $start)+1
 
    <#
    take the subnet and split it into an array then join the first
    3 elements back into a string separated by a period.
    This will be used to construct an IP address.
    #>
 
    $base = $subnet.split(".")[0..2] -join "."
 
    #Initialize a counter
    $i = 0
 
    #loop while the value of $start is <= $end
    while ($start -le $end) {
      #increment the counter
      write-Verbose $start
      $i++
      #calculate % processed for Write-Progress
      $progpercent = $progHash.PercentComplete = ($i/$count)*100
 
      #define the IP address to be pinged by using the current value of $start
      $IP = "$base.$start" 
 
      #Use the value in Write-Progress
      $proghash.currentoperation = $IP
      Write-Progress @proghash
 
      #get local IP
      $local = (Get-NetIPAddress -AddressFamily IPv4).Where({$_.InterfaceAlias -notmatch "Bluetooth|Loopback"})
  
      #test the connection
      if (Test-Connection -ComputerName $IP -Count $ping -Quiet) {
        #if the IP is not local get the MAC
        if ($IP -ne $Local.IPAddress) {
            #get MAC entry from ARP table
            Try {
                $arp = (arp -a $IP | where {$_ -match $IP}).trim() -split "\s+"
                $MAC = $arp[1]
            }
            Catch {
                #this should never happen but just in case
                Write-Warning "Failed to resolve MAC for $IP"
                $MAC = "unknown"
            }
        }
        else {
            #get local MAC
            $MAC = ($local | Get-NetAdapter).MACAddress
        }
        #attempt to resolve the hostname
        Try {
            $iphost = (Resolve-DNSName -Name $IP -ErrorAction Stop).Namehost
        }
        Catch {
            Write-Verbose "Failed to resolve host name for $IP"
            #set a value
            $iphost = "unknown"
        }
        Finally {
            #create a custom object
            if ($Output_To_File -eq 'yes') {
               [pscustomobject]@{
                IPAddress = $IP
                }
            }
            else { 
            [pscustomobject]@{
                IPAddress = $IP
                Hostname = $iphost
                MAC = $MAC
                }
            }
        
  
        }#if test ping
    #increment the value $start by 1
    $start++
    } #close while loop
  }  
} #end function
          
Function Set-Creds {
    Write-Host "Setting up Credentials to use on the remote host(s)..." -ForegroundColor Cyan
     
    $UserName = Read-Host "Enter the username to connect to the remote system(s)"
    $password = Read-Host "Enter a password to connect to the remote system(s)"
    $UserPassSecure = ConvertTo-SecureString $password -AsPlainText -Force
    $global:UserCredentials = New-Object -TypeName System.Management.Automation.PSCredential $UserName,$UserPassSecure
    Write-Host "User Credentials loaded..." -ForegroundColor Green
}
    
Function Set-IOCInformation {
    Write-Host "Gathering IOC Information..." -ForegroundColor Cyan
    Write-Host ""
            

    Write-Host "Adding IOC files to $Directory..." -ForegroundColor Cyan     
    $global:fileIOCs = @(Get-Content "$Directory\files.txt")
    $global:ipIOCs = @(Get-Content "$Directory\ips.txt")
    $global:regIOCs = @(Get-Content "$Directory\keys.txt")
    $global:taskIOCs = @(Get-Content "$Directory\jobs.txt")
    $global:domainIOCs = @(Get-Content "$Directory\Domains.txt")
    $fileCount = $fileIOCs.Count
    $ipCount = $ipIOCs.Count
    $regCount = $regIOCs.Count
    $taskCount = $taskIOCs.Count
    $domainCount = $domainIOCs.Count
    Write-Host "Loading $fileCount known file IOCs..." -ForegroundColor Yellow
    Write-Host "Loading $ipCount known IP IOCS..." -ForegroundColor Yellow
    Write-Host "Loading $regCount known Registry IOCs..." -ForegroundColor Yellow
    Write-Host "Loading $taskCount known Scheduled Task IOC..." -ForegroundColor Yellow
    Write-Host "Loading $domainCount known Domain IOCs..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "IOC Information has been set..." -ForegroundColor Green

} 
          
#Uses IOC files to search the C:\ and returns matches. WORKING!
Function Find-FileIOCs {
    Write-Host "Enumerating files that match IOCs..." -ForegroundColor Cyan
    
    $ProgressBar = @{
    Activity = "File Investigation"
    CurrentOperation = "None"
    Status = "Checking Hosts for known APT Suspicious Files"
    PercentComplete = 0
    }
    
    $i = 0
    
    foreach ($h in $hosts) {
        $i++
        $ProgressBar.PercentComplete = ($i/$hosts.Count)*100
        $ProgressBar.CurrentOperation = $h
        Write-Progress @ProgressBar

    
        $File_Results = Invoke-Command -ComputerName $h -Credential $UserCredentials -ScriptBlock {
        Get-ChildItem -Path c:\ -Include $using:fileIOCs -Recurse -Force -ErrorAction SilentlyContinue | 
        Select-Object -Property Name,Directory,CreationTime,CreationTimeUtc,LastAccessTime,LastAccessTimeUtc,LastWriteTime,LastWriteTimeUtc
        }
    }

    if ($Output_to_File -eq 'yes') {
        foreach ($result in $File_Results) {
            $result
        }
    }
    else {
        foreach ($result in $File_Results) {
            $enddate = (Get-Date).ToString("yyyyMMdd_hhmmss")
            Export-Csv -InputObject $result -Path c:\IOC_File_Results_$enddate.csv -NoTypeInformation -Append
        }
    }
    Show-HuntMenu
}
   
#Find ScheduledTasks on a system that match IOCs
Function Find-ScheduledTaskIOCs {

    Write-Host "Enumerating Scheduled Tasks that match known IOCs..." -ForegroundColor Cyan
    
    $ProgressBar = @{
    Activity = "Scheduled Task Investigation"
    CurrentOperation = "None"
    Status = "Checking for known APT Scheduled Tasks"
    PercentComplete = 0
    }
    
    $i = 0
    
    foreach ($h in $hosts) {
    $i++
    $ProgressBar.PercentComplete = ($i/$hosts.Count)*100
    $ProgressBar.CurrentOperation = $h
    Write-Progress @ProgressBar

    $Schtasks_Results = Invoke-Command -ComputerName $h -Credential $UserCredentials -ScriptBlock {
    #Look for specific jobs on a system that match Scheduled Tasks IOCS
        foreach ($task in $using:taskIOCs) {
        Get-ScheduledTask -ErrorAction SilentlyContinue | where { $_.TaskName -eq $task } | 
        Select-Object -Property * -ExpandProperty Actions | Select-Object Date,Taskname,Arguments,Execute
            }
        }

    $Schtask_Results_Count = $Schtasks_Results.Count

    Write-Host "$Schtasks_Results_Count Scheduled Task IOCs were found on the system $h"   
    }

    if ($OutPut_To_File -eq "yes") {
        foreach ($result in $Schtasks_Results) {
        $enddate = (Get-Date).ToString("yyyyMMdd_hhmmss")
        Export-Csv -InputObject $result -Path c:\IOC_Schtasks_results_$enddate.csv -NoTypeInformation -Append
        }
    }
    else {
        foreach ($result in $Schtasks_Results) {
            $result
        }
    }      
    Show-HuntMenu
}
    
#findregs will search thru the primary registry runkeys to match a list of IOCs
Function Find-RegistryIOCs {
    Write-Host "Enumerating Registry Keys that match IOCs..." -ForegroundColor Cyan
    
    $ProgressBar = @{
    Activity = "Registry Investigation"
    CurrentOperation = "None"
    Status = "Checking for known APT Registry Key\Value Pairs"
    PercentComplete = 0
    }
    
    $i = 0
    
    foreach ($h in $hosts) {
        $i++
        $ProgressBar.PercentComplete = ($i/$hosts.Count)*100
        $ProgressBar.CurrentOperation = $h
        Write-Progress @ProgressBar
        $RunKey_Results = Invoke-Command -ComputerName $h -Credential $UserCredentials -ScriptBlock {
            foreach ($ioc in $using:RegIOCs) {
            
                (Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -ErrorAction SilentlyContinue).PSObject.Properties | 
                Where { $_.Name -eq $ioc } | Select-Object -Property PSComputerName,Name,Value
                (Get-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -ErrorAction SilentlyContinue).PSObject.Properties | 
                Where { $_.Name -eq $ioc } | Select-Object -Property PSComputerName,Name,Value
 
                }
        
            }
        
            if ($Output_To_File -eq 'yes') {
                foreach ($result in $RunKey_Results) {
                    $enddate = (Get-Date).ToString("yyyyMMdd_hhmmss")
                    Export-Csv -InputObject $result -Path c:\IOC_RunKey_results_$enddate.csv -NoTypeInformation -Append
                }
            }
            else {
              foreach ($result in $RunKey_Results) {
                $result
                }
            } 
       }
    Show-HuntMenu   
}
    
#findips will loop thru each host, Get the TCP Connection Remote Addresses, and then compare those addresses to the IOC list.
Function Find-IpIOCs {
    Write-Host "Enumerating Network Connections to IPs that match IOCs..." -ForegroundColor Cyan
    
    $ProgressBar = @{
    Activity = "Network Connections Investigation"
    CurrentOperation = "None"
    Status = "Checking for known APT IPs"
    PercentComplete = 0
    }
    
    $i = 0
    
    foreach ($h in $hosts) {
        $i++
        $ProgressBar.PercentComplete = ($i/$hosts.Count)*100
        $ProgressBar.CurrentOperation = $h
        Write-Progress @ProgressBar
    
        $IP_Results = Invoke-Command -ComputerName $h -Credential $UserCredentials -ScriptBlock {
            $results = ((Get-NetTCPConnection).RemoteAddress)
            Compare-Object -ReferenceObject $using:IPIOCs -DifferenceObject $results -IncludeEqual | Where { $_.SideIndicator -eq '==' } | 
            Select -Property 'InputObject','PSComputerName'
        }
    }
    
    if ($Output_To_file -eq 'yes') {
        foreach ($result in $IP_Results) {
            $enddate = (Get-Date).ToString("yyyyMMdd_hhmmss")
            Export-Csv -InputObject $result -Path c:\IOC_IP_results_$enddate.csv -NoTypeInformation -Append
           }
    }
    else {
        foreach ($result in $IP_Results) {
            $result
        }
    }
    Show-HuntMenu
}

#finddomains will loop thru a list of domain IOCs and check the DnsClientCache of each host for each IOC
Function Find-DomainIOCs {
    Write-Host "Enumerating Domain Names that the system connected with that match IOCs..." -ForegroundColor Cyan
    
    $ProgressBar = @{
    Activity = "DNS Request Investigation"
    CurrentOperation = "None"
    Status = "Investigating known APT Domain Names"
    PercentComplete = 0
    }
    
    $i = 0
    
    foreach ($h in $hosts) {
        $i++
        $ProgressBar.PercentComplete = ($i/$hosts.Count)*100
        $ProgressBar.CurrentOperation = $h
        Write-Progress @ProgressBar
    
        $Domain_Results = Invoke-Command -ComputerName $h -Credential $UserCredentials -ScriptBlock {
            foreach ($name in $using:domainIOCs) {
            Get-DnsClientCache | Where { $_.Entry -eq $name }
            } 
        }
    }
    if ($Output_To_File -eq 'yes') {
        foreach ($result in $Domain_Results) {
            Export-Csv -InputObject $result -Path c:\IOC_Domain_results.csv -NoTypeInformation -Append
        }
    }
    else {
        foreach ($result in $Domain_Results) {
            $result
        }
    }
    Show-HuntMenu
}

#NOTE: Need to add all major persistence keys following the class...
Function List-PersistentRegistryKeys {
    Write-Host " "
    Write-Host "Enumerating Common Registry Run Keys used for Persistence..." -ForegroundColor Cyan
    Write-Host " " 
    
    $Display = Read-Host "Do you want to Display the results to the console: yes or no"
            if ($Display -eq 'yes') {
                $Output_To_File = 'yes'
            }
            else {
                $Output_To_File = 'no'
            }
        
    $ProgressBar = @{
    Activity = "Registry Key Enumeration"
    CurrentOperation = "None"
    Status = "Enumerating Registry Key\Values for Host:"
    PercentComplete = 0
    }
    
    $i = 0
    
    foreach ($h in $hosts) {
        $i++
        $ProgressBar.PercentComplete = ($i/$hosts.Count)*100
        $ProgressBar.CurrentOperation = $h
        Write-Progress @ProgressBar
        
        Invoke-Command -ComputerName $h -Credential $UserCredentials -ScriptBlock {
            #Dump all of the primary run key
            Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\ -ErrorAction SilentlyContinue
            Get-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\ -ErrorAction SilentlyContinue
        Write-Host "******************************************************************"
        }
    }

    if ($SysInfo) {
        Show-SystemInfoMenu
    }
}

#Enumerate the Registry keys that are set when sticky keys is enabled...
#NOT COMPLETE - needs testing and see if this can be more precise to the sticky keys exploit
Function  Invoke-StickyKeysCheck {
        Write-Host " "
        Write-Host "Enumerating Registry to check for sticky keys..." -ForegroundColor Cyan
        
    $ProgressBar = @{
    Activity = "Sticky Key Attack Check"
    CurrentOperation = "None"
    Status = "Enumerating Sticky Key Values for Host:"
    PercentComplete = 0
    }
    
    $i = 0
    
    foreach ($h in $hosts) {
        $i++
        $ProgressBar.PercentComplete = ($i/$hosts.Count)*100
        $ProgressBar.CurrentOperation = $h
        Write-Progress @ProgressBar
        Invoke-Command -ComputerName $h -Credential $UserCredentials -ScriptBlock {
        Get-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -ErrorAction SilentlyContinue
        Write-Host "******************************************************************"
        }
    }
    if ($SysInfo) {
        Show-SystemInfoMenu
    }
}
    
Function Get-SchTasks{
    Write-Host "Gathering all Registered Scheduled Tasks on the Remote System..." -ForegroundColor yellow
    Write-Host "Results can be Displayed to console or sent to a csv file." -ForegroundColor Yellow
            
    $Display = Read-Host "Do you want to Display the results to the console: yes or no"
            if ($Display -eq 'yes') {
                $Output_To_File = 'yes'
            }
            else {
                $Output_To_File = 'no'
            }

    $ProgressBar = @{
    Activity = "Scheduled Task Enumeration"
    CurrentOperation = "None"
    Status = "Enumerating Scheduled Tasks for host:"
    PercentComplete = 0
    }
    
    $i = 0
    
    foreach ($h in $hosts) {
        $i++
        $ProgressBar.PercentComplete = ($i/$hosts.Count)*100
        $ProgressBar.CurrentOperation = $h
        Write-Progress @ProgressBar
        Write-Host "List all scheduled tasks by Taskname and Actions..." -ForegroundColor Cyan
        Invoke-Command -ComputerName $h -Credential $UserCredentials -ScriptBlock {
        #Recursively search the c drive for the filename provided at command line
        Get-ScheduledTask -ErrorAction SilentlyContinue | Select-Object -Property * -ExpandProperty Actions | 
        Select-Object Date,Taskname,Arguments,Execute
        Write-Host "******************************************************************"
        }
    }
    if ($SysInfo) {
        Show-SystemInfoMenu
    }
}
    
Function Invoke-FindFile {
    Write-Host " "
    Write-Host "Recursively Dir the C:\ looking for a specific filename provided at the command line..." -ForegroundColor Cyan
    Invoke-Command -ComputerName $hosts -Credential $UserCredentials -ScriptBlock {
    #Recursively search the c drive for the filename provided at command line
    Get-ChildItem c:\ -Include $using:filename -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "******************************************************************"
    }
    if ($SysInfo) {
        Show-SystemInfoMenu
    }
}

Function Get-DirectoryContents {
    Write-Host " "
    Write-Host "Recursively Dir a specific path on the host(s) provided at the command line..." -ForegroundColor Cyan
    Invoke-Command -ComputerName $hosts -Credential $UserCredentials -ScriptBlock {
    #Recursively search the c drive for the filename provided at command line
    Get-ChildItem $using:path -Force -ErrorAction SilentlyContinue
    Write-Host "******************************************************************"
    }

    if ($SysInfo) {
        Show-SystemInfoMenu
    }
}

#Need to Add functionality to list just running Services
Function Get-ServiceInfo {
    $Output_To_File = Read-Host "Do you want write the results to a csv file: yes or no"
           
           
    Write-Host "Getting the Taskname,DisplayName and Status for all services on the remote system(s)..." -ForegroundColor Cyan
    $RegistryItems = Invoke-Command -ComputerName $hosts -Credential $UserCredentials -ScriptBlock {
    #Recursively search the c drive for the filename provided at command line
    Get-Service -ErrorAction SilentlyContinue | Select-Object -Property name,displayname,status
    Write-Host "******************************************************************" 
    }

    if ($Output_To_File -eq 'yes') {
        foreach ($result in $RegistryItems) {
            $enddate = (Get-Date).ToString("yyyyMMdd_hhmmss")
            Export-Csv -InputObject $result -Path c:\Services_$enddate.csv -NoTypeInformation -Append
            }
        }
    else {

        foreach ($result in $RegistryItems) {
            $result
        }
    }
    if ($SysInfo) {
        Show-SystemInfoMenu
    }
}

Function Get-ProcessInfo {
    $Output_To_File = Read-Host "Do you want write the results to a csv file: yes or no"
           
           
    Write-Host "Getting the Taskname,DisplayName and Status for all services on the remote system(s)..." -ForegroundColor Cyan
    $ProcessItems = Invoke-Command -ComputerName $hosts -Credential $UserCredentials -ScriptBlock {
        Get-WMIObject -class win32_Process | select processname,processid,commandline
    Write-Host "******************************************************************" 
    }

    if ($Output_To_File -eq 'yes') {
        foreach ($result in $ProcessItems) {
            $enddate = (Get-Date).ToString("yyyyMMdd_hhmmss")
            Export-Csv -InputObject $result -Path c:\Processes_$enddate.csv -NoTypeInformation -Append
            }
        }
    else {

        foreach ($result in $ProcessItems) {
            $result
        }
    }
    if ($SysInfo) {
        Show-SystemInfoMenu
    }
}
    
Function Get-Hotfixes {
    Write-Host "Getting information on what KBs have been patched..." -ForegroundColor Cyan
    foreach ($h in $hosts) {
        $Patch_Results = Invoke-Command -ComputerName $hosts -Credential $UserCredentials -ScriptBlock {
            Get-Hotfix
            }
        }
    if ($Output_To_File -eq "yes") {
        foreach ($result in $Patch_Results) {
        Export-Csv -InputObject $result -Path c:\Current_Hotfix_Results.csv -NoTypeInformation -Append
        }
    }
    else {
        foreach ($result in $Patch_Results) {
            $result
        }
    }
    if ($SysInfo) {
        Show-SystemInfoMenu
    }
}
    
Function Get-AutoRuns {
    Write-Host "Getting host autorun information..." -ForegroundColor Cyan
    Invoke-Command -ComputerName $hosts -Credential $UserCredentials -ScriptBlock {
        Get-CimInstance Win32_StartupCommand | Select-Object Name,command,location,User | fl
        Write-Host "******************************************************************"
    }
    if ($SysInfo) {
        Show-SystemInfoMenu
    }
}
    
Function Get-UserInfo {
    Write-Host "Getting information about users on the system..." -ForegroundColor Cyan
    Invoke-Command -ComputerName $hosts -Credential $UserCredentials -ScriptBlock {
        #If Lockout is True, the account is locked.
        #Update later so that PasswordExpires is the Date. 
        Get-CimInstance Win32_UserAccount | Select-Object Name,Fullname,Domain,Lockout,PasswordExpires,SID
    }
    if ($SysInfo) {
        Show-SystemInfoMenu
    }
}
    
Function Get-GroupInfo {
    Write-Host "Getting information about groups on the system..." -ForegroundColor Cyan
    Invoke-Command -ComputerName $hosts -Credential $UserCredentials -ScriptBlock {
        #If Lockout is True, the account is locked.
        #Update later so that PasswordExpires is the Date. 
        Get-CimInstance Win32_Group | Select-Object Name,Domain,Description,SID
    }
    if ($SysInfo) {
        Show-SystemInfoMenu
    }
}
    
Function Get-LocalGroupinfo {
    Write-Host "Getting information about what users are in the localgroup Administrators..." -ForegroundColor Cyan
    Invoke-Command -ComputerName $hosts -Credential $UserCredentials -ScriptBlock {
        Get-LocalGroupMember -Name Administrators
    }
}
 #Function Needs Testing!!! 
 Function Get-NetworkDrives {
    $Output_To_File = Read-Host "Do you want write the results to a csv file: yes or no"
    #Retrieve network drives from remote hosts
    Invoke-Command -ComputerName $hosts -Credential $UserCredentials -ScriptBlock {
        $MappedDrives = Get-WmiObject Win32_MappedLogicalDisk | Select Name, ProviderName, FileSystem, Size, FreeSpace | Format-Table
        if (!$MappedDrives) {
            Write-Host "No Network Drives were found on the remote host(s)." -ForegroundColor Yellow
            }
        else {
            if ($Output_To_File -eq "yes") {
                foreach ($result in $MappedDrives) {
                $enddate = (Get-Date).ToString("yyyyMMdd_hhmmss")
                Export-Csv -InputObject $result -Path c:\NetworkDrives_$enddate.csv -NoTypeInformation -Append
                    }
                }
                else {
                    foreach ($result in $MappedDrives) {
                        $result
                }
            }
        }
    }
    if ($SysInfo) {
        Show-SystemInfoMenu
    }
}
 
Function Get-LogicalDrives {

    $Output_To_File = Read-Host "Do you want to export the results to a csv file, yes or no?"
    $enddate = (Get-Date).ToString('yyyyMMdd_hhmmss')

    #Retrieve network drives from remote hosts
    foreach ($h in $hosts) {
        Write-Host $h
        $global:DriveInfo = Invoke-Command -ComputerName $h -Credential $UserCredentials -ScriptBlock {
            
            Get-PSDrive -PSProvider FileSystem 
        }    
    
    
        if ($Output_To_File -eq 'yes') {

            foreach ($result in $DriveInfo) {
                Export-Csv -InputObject $result -Path c:\NetworkDrives_$enddate.csv -NoTypeInformation -Append
            }
        }
        else {
            foreach ($result in $DriveInfo) {
                $result
            }
        }
    }
    if ($SysInfo) {
        Show-SystemInfoMenu
    }
}

Function Get-FileSystemHash {
    $enddate = (Get-Date).ToString("yyyyMMdd_hhmmss")
    Write-Host "Creating a baseline of the filesystem..." -ForegroundColor Cyan

    $ProgressBar = @{
    Activity = "DNS Request Investigation"
    CurrentOperation = "None"
    Status = "Investigating known APT Domain Names"
    PercentComplete = 0
    }
    
    $i = 0
    
    foreach ($h in $hosts) {
        $i++
        $ProgressBar.PercentComplete = ($i/$hosts.Count)*100
        $ProgressBar.CurrentOperation = $h
        Write-Progress @ProgressBar

         
        #Execute commands on the remote host to take an MD5 hash of all items in the C:\ and store those result in the $Hash_Results variable.
        Invoke-Command -Computername $h -Credential $UserCredentials -ScriptBlock {
            $driveRoot = Get-PSDrive -PSProvider FileSystem | Select-Object -Property Root 
            
            foreach ($drive in $driveRoot) {
                #$drive.root
                #Recursively identify the contents of C:\
                Get-ChildItem  $drive.root -Include * -Recurse -Force -ErrorAction SilentlyContinue | 
                #Take an MD5 Hash of those objects
                Get-Filehash -Algorithm MD5 -ErrorAction SilentlyContinue
            }  
        } 
        
        foreach ($result in $Hash_Results) {
            #Export the hashes to a files without the additional header
            Export-Csv -InputObject $result -Path "$Directory\$h\$($h)_HashList_$($enddate).csv" -NoTypeInformation -ErrorAction SilentlyContinue
            }

    }
    
}


Show-MainMenu