<# 
=> Description: 
=> This script deletes all node_modules and/or lock-json files 
=> from every directory inside of a main direrctory 
=> This works well in a microservice env where you are constantly updating packages. 
#>

$folders = Get-ChildItem ".\" -Directory
$initPath = '.\'
foreach ($entry in $folders) { 
  $name = $entry.FullName
  Write-Host $name
  if($name -Match "-int-"){
      Write-Host "Skipping int repo"
      continue
  }
  Set-Location $name
  if(Test-Path -Path node_modules){
      Write-Host "node_modules directory found. Deleting..." -ForegroundColor White -BackgroundColor DarkGreen
      Remove-Item -Path "node_modules" -Recurse
      Write-Host "package-lock.json file found. Deleting..." -ForegroundColor DarkBlue -BackgroundColor Cyan
      Remove-Item -Path "package-lock.json"
  }
  elseif(Test-Path -Path package-lock.json){
      Write-Host "package-lock.json file found. Deleting..." -ForegroundColor DarkBlue -BackgroundColor Cyan
      Remove-Item -Path "package-lock.json"
  }
  else {
      Write-Host "node_modules directory and package-lock.json file not found." -ForegroundColor White -BackgroundColor Red
  }
  Set-Location $initpath
}
