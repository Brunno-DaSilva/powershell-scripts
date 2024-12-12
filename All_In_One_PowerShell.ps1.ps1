# System Information
# Get detailed system info including OS version, architecture, etc.
Get-ComputerInfo

# View System Event Logs
# Retrieve system event logs for diagnostics
Get-WinEvent -LogName System

# Check Disk Space
# Displays disk space usage on all drives
Get-PSDrive -PSProvider FileSystem

# Check Running Processes
# Lists all running processes with their status and resource usage
Get-Process

# End a Process by Name or ID
# Terminates a specific process (e.g., Notepad)
Stop-Process -Name "notepad"
# Or terminate by process ID
Stop-Process -Id 1234

# Network Troubleshooting
# Ping a remote server or website to test connectivity
Test-Connection -ComputerName www.google.com

# Check IP Configuration (IP address, DNS servers, etc.)
Get-NetIPConfiguration

# Release and Renew IP Address
# Release the current IP address (useful for troubleshooting network issues)
Release-NetIPAddress -InterfaceAlias "Ethernet"
# Renew the IP address (gets a new one from the DHCP server)
Renew-NetIPAddress -InterfaceAlias "Ethernet"

# Flush DNS Cache
# Clears the DNS cache, which can resolve DNS-related issues
Clear-DnsClientCache

# View DNS Server Configuration
# Displays DNS servers that the system is using
Get-DnsClientServerAddress

# Get Detailed Network Adapter Information
# Provides network adapter details, including connection status and speed
Get-NetAdapter | Select-Object Name, Status, LinkSpeed

# Check Firewall Status
# Get the status of Windows Firewall
Get-NetFirewallProfile

# Services Management
# List All Running Services
Get-Service

# Start a Service (e.g., Windows Update Service)
Start-Service -Name "wuauserv"

# Stop a Service (e.g., Windows Update Service)
Stop-Service -Name "wuauserv"

# Restart a Service (e.g., Remote Desktop Service)
Restart-Service -Name "TermService"

# Check System Uptime
# Displays how long the system has been running
(Get-Date) - (gcim Win32_OperatingSystem).LastBootUpTime

# Test the User's Permissions to a File/Folder
# Checks if the current user has access to a folder
Test-Path "C:\Users\Public\Documents"

# Check Active Directory User Account Status (for domain users)
# Checks if a user account is enabled, locked out, etc.
Get-ADUser -Identity "username" -Properties LockoutTime, Enabled

# Get Installed Software List
# Retrieves a list of installed programs on the system
Get-WmiObject -Class Win32_Product | Select-Object Name, Version

# Remote Desktop Diagnostics (Check RDP Status)
# Checks if the RDP service is running on the remote machine
Get-Service -Name TermService

# PowerShell Version
# Displays the version of PowerShell currently in use
$PSVersionTable.PSVersion

# View Network Interface List
# Displays a list of network interfaces and their status
Get-NetAdapter | Select-Object Name, Status, MacAddress

# Reset Network Settings
# Reset network settings to default to troubleshoot network issues
netsh int ip reset
netsh winsock reset

# Enable/Disable Windows Firewall (Use with caution)
# Enable Windows Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
# Disable Windows Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
