<# 
=> Description: 
=> This script install node packages
=> on every directory inside of a main direrctory 
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
  if(Test-Path -Path package.json){
      Write-Host "package.json found running npm install..."
      vsts-npm-auth -config .npmrc
      npm install
  }
  Set-Location $initpath
}