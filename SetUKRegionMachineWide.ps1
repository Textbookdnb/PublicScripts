<#
Notes:
This script will setup windows OS for English UK Language settings. It will set the Date and time format
as well as the Keyboard layout.

This feature is in preview, and it is recommended that you test in a validation environment
before using in production.

A reboot is required after running this script for the configuration to take effect.
#>

#variables
$regionalsettingsURL = "https://raw.githubusercontent.com/Textbookdnb/PublicScripts/refs/heads/main/GBRegion.xml"
$RegionalSettings = "C:\Windows\GBRegion.xml"

#Install The UK Language Pack (en-GB)
#Install-language en-gb

#Set Regional Location
Set-WinHomeLocation -GeoId 242

#downdload regional settings file
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($regionalsettingsURL,$RegionalSettings)


# Set Locale, language etc. 
& $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"$RegionalSettings`""

# Set languages/culture. Not needed perse.
Set-SystemPreferredUILanguage en-GB
Set-WinSystemLocale en-GB
Set-WinUserLanguageList -LanguageList en-GB -Force
Set-Culture -CultureInfo en-GB

Set-TimeZone -Name "GMT Standard Time"

# restart virtual machine to apply regional settings to current user. You could also do a logoff and login.
