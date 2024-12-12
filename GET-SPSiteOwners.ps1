###################################
# ##### Script Overview: #####
###################################
# 1. The first two lines of code set the URL for the SharePoint admin 
#   center and the path for the output CSV file.

# 2. The next line of code prompts the user for their 
#   SharePoint credentials using the Get-Credential cmdlet.

# 3. The Connect-SPOService cmdlet is used to connect to the SharePoint admin center 
#   using the URL and credentials specified in steps 1 and 2.

# 4. The Connect-AzureAD cmdlet is used to connect to Azure AD 
#   using the same credentials as in step 2.

# 5. The Get-SPOSite cmdlet is used to retrieve information about 
#   all site collections in the tenant, limited to a maximum of 
#   5000 (the default limit) unless the -Limit parameter is used to specify a higher limit.

# 6. An empty array called $SiteOwners is created to store 
#   the site owners data.

# 7. A ForEach-Object loop is used to iterate through each site 
#   collection returned by Get-SPOSite.

# 8. If the site is a group-connected site, the script retrieves 
#   the group owners using the Get-AzureADGroupOwner cmdlet and 
#   concatenates them into a single string separated by semicolons. 
#   If the site is not a group-connected site, the script retrieves 
#   the site owner directly from the Owner property of the site object.


# 9. The script creates a new PSObject with properties for the site
#   title, URL, and owner(s), and adds it to the $SiteOwners array.

# 10. Once all site collections have been processed, the $SiteOwners 
#   array is output to the console.

# 11. Finally, the $SiteOwners array is exported to a CSV file at 
#   the location specified in step 1 using the Export-Csv cmdlet, 
#   with the -NoTypeInformation parameter used to exclude type 
#   information from the CSV file.


#Variables for Admin Center
$AdminCenterURL = "https://trace3corp-admin.sharepoint.com"
$CSVPath = "C:\development\HubSpot_SharePoint\SharePointScripts\AllSiteOwnersAndURL.csv"
 
#Connect to SharePoint Online and Azure AD
Connect-SPOService -url $AdminCenterURL 
Connect-AzureAD  | Out-Null
   
#Get all Site Collections
$Sites = Get-SPOSite -Limit ALL
 
$SiteOwners = @()

#Get Site Owners for each site collection
$Sites | ForEach-Object {
    If($_.Template -like 'GROUP*')
    {
        $Site = Get-SPOSite -Identity $_.URL
        #Get Group Owners
        $GroupOwners = (Get-AzureADGroupOwner -ObjectId $Site.GroupID | Select-Object -ExpandProperty UserPrincipalName) -join "; "      
    }
    Else
    {
        $GroupOwners = $_.Owner
    }
    #Collect Data
    $SiteOwners += New-Object PSObject -Property @{
    'Site Title' = $_.Title
    'URL' = $_.Url
    'Owner(s)' = $GroupOwners
    }
}
#Get Site Owners
$SiteOwners
 
#Export Site Owners report to CSV
$SiteOwners | Export-Csv -path $CSVPath -NoTypeInformation