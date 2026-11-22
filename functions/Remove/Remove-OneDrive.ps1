<#
.SYNOPSIS
    Completely uninstalls OneDrive and removes all related components.

.DESCRIPTION
    This function performs a thorough removal of OneDrive by killing OneDrive and Explorer processes,
    running the OneDriveSetup.exe uninstaller from both SysWOW64 and System32 paths,
    deleting OneDrive data directories from LocalAppData, ProgramData, and the system drive,
    removing the File Explorer pinned namespace registry entries for both 64-bit and 32-bit CLSIDs,
    and creating a registry policy to disable file sync.
    Finally, it restarts Explorer to refresh the shell.

.NOTES
    This function requires administrator privileges.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Remove-OneDrive {
	taskkill /f /im OneDrive.exe
	taskkill /f /im explorer.exe

	if (Test-Path "$env:SystemRoot\SysWOW64\OneDriveSetup.exe") {
    	& "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" /uninstall
	} else {
    	& "$env:SystemRoot\System32\OneDriveSetup.exe" /uninstall
	}

	Remove-Item "$env:LOCALAPPDATA\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
	Remove-Item "$env:PROGRAMDATA\Microsoft OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
	Remove-Item "$env:SystemDrive\OneDriveTemp" -Recurse -Force -ErrorAction SilentlyContinue

	reg add 'HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0 /f
	reg add 'HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0 /f

	Set-RegistryValue -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' -Name 'DisableFileSyncNGSC' -Type DWord -Value 1

	Start-Process explorer.exe

	Write-Ok 'OneDrive Removed!'
}
