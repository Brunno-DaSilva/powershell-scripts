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
   if(Test-Path -Path .npmrc){
    $file = Get-Content .npmrc
    if ($file -notmatch "ca=") {
        Write-Host ".npmrc file found. Adding ca value..." -ForegroundColor White -BackgroundColor DarkGreen
        Add-Content -Path .npmrc -Value `n'ca="" '
    } else {
        Write-Host ".npmrc already contains the value. No modifications made"  -ForegroundColor White -BackgroundColor Red
    }
}
  Set-Location $initpath
}