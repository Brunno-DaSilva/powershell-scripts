<# 
=> Description: 
=> This script gets a list of dependencies that needs upgrade
#>

$folders = Get-ChildItem ".\" -Directory
$initPath = '.\'

foreach ($entry in $folders) { 
  $name = $entry.FullName
  Write-Host $name
  if($name -Match "-int-"){
      Write-Host "Skipping int repo" -ForegroundColor White -BackgroundColor Red
      continue
  }
  Set-Location $name
  if(Test-Path -Path package.json){
      Write-Host "package.json found running npm list..." -ForegroundColor DarkBlue -BackgroundColor Cyan
      npm list lodash tinymce openssl xmldom sanitize-html
  }
  Set-Location $initpath
}