#***************************************
#Arguments
#%1: Package Name
#***************************************
Param
(
   [Parameter(
   Mandatory=$True,
   Position = 1
   )][string]
   $Package
)

$nuspec = Join-Path nuspec "CenterFaceDotNet.${Package}.nuspec"
if (!(Test-Path ${nuspec}))
{
   Write-Host "Error: ${nuspec} does not exist" -ForegroundColor Red
   exit -1
}

$nugetPath = Join-Path $PSScriptRoot nuget.exe
if (!(Test-Path ${nugetPath}))
{
   Write-Host "Error: ${nugetPath} does not exist" -ForegroundColor Red
   exit -1
}

Write-Host "${nuspec}" -ForegroundColor Green
Invoke-Expression "${nugetPath} pack ${nuspec}"
if ($lastexitcode -ne 0)
{
   Write-Host "Failed '${nugetPath} pack ${nuspec}" -ForegroundColor Red
   exit -1
}