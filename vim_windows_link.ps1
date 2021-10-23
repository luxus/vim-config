Write-Output "Current dir: " $PSScriptRoot
cmd /c mklink $HOME"\AppData\Local\nvim\init.vim" $PSScriptRoot"\.vimrc"
cmd /c mklink $HOME"\AppData\Local\nvim\coc-settings.json" $PSScriptRoot"\.coc-settings.json"

Write-Output $env:APPDATA"\..\Local\nvim\fnl"

cmd /c mklink /D $env:APPDATA"\..\Local\nvim\fnl" $PSScriptRoot"\fnl"

cmd /c mklink $HOME"\.vimrc" $PSScriptRoot"\.vimrc"

cmd /c mklink $HOME"\.vsvimrc" $PSScriptRoot"\.vsvimrc"
