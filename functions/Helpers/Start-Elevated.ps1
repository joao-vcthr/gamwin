function Start-Elevated {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ScriptsRoot,

        [Parameter(Mandatory = $true)]
        [string]$ScriptFile
        )
    Start-Process powershell.exe -Verb RunAs -Wait -ArgumentList @(
        '-NoProfile', '-ExecutionPolicy', 'Bypass',
        '-File', "`"$(Join-Path $ScriptsRoot $ScriptFile)`""
    )
}
