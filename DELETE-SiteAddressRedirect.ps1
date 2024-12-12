###################################
# ##### Script Overview: #####
###################################

# This PowerShell script connects to a SharePoint Online (SPO) environment and removes the site address rename redirect


# 1. This command connects to the SharePoint Online Administration Center at the specified URL

Connect-SPOService -Url https://ORGcorp-admin.sharepoint.com

# 2. his command retrieves SharePoint sites that use the REDIRECTSITE#0 template. 
# The template type REDIRECTSITE#0 typically indicates a site that redirects to another location. 
# This command might be used to identify or list sites with that specific template for further management.


Get-SPOSite -Template REDIRECTSITE#0

# 3. Assign the URL of a specific SharePoint site to a variable

$siteAddress = "https://contoso.sharepoint.com/sites/OldSiteName"

# 4. Remove SharePoint site specifics
Remove-SPOSite -Identity $siteAddress
