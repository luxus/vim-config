Write-Output "Current dir: " $PSScriptRoot
cmd /c mklink $HOME"\AppData\Local\nvim\init.vim" $PSScriptRoot"\.vimrc"

Write-Output $env:APPDATA"\..\Local\nvim\fnl"

cmd /c mklink /D $env:APPDATA"\..\Local\nvim\fnl" $PSScriptRoot"\fnl"

cmd /c mklink $HOME"\.vimrc" $PSScriptRoot"\.vimrc"

cmd /c mklink $HOME"\.vsvimrc" $PSScriptRoot"\.vsvimrc"
