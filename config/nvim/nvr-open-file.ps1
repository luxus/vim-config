param (
    # $itemFileName,
    # $itemExt,
    $itemPath,
    $curLine,
    $curCol
    )

# Config for External Tools
# Command: powershell.exe
# Arguments: C:\repos\vim-config\config\nvim\nvr-open-file.ps1 -itemPath $(itemPath) -curLine $(CurLine) -curCol $(CurCol)

Write-Output "itemFileName: " $itemFileName
Write-Output "itemExt: " $itemExt
Write-Output "curLine: " $curLine
Write-Output "curCol: " $curCol
Write-Output "itemPath: " $itemPath

$listenAddress = Get-Content "~/.nvim-listen-address"
Write-Output "Listen address " $listenAddress

$env:NVIM_LISTEN_ADDRESS = $listenAddress

if ($itemPath.Length -gt 0) 
{
    nvr --remote $itemPath -c "call cursor($curLine,$curCol)"
} 
else 
{
    Write-Output "Path not specified"
    
    # For relative commands
    # nvr --remote $itemFileName$itemExt -c "call cursor($curLine,$curCol)"
}


