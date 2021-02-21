Write-Output "Current dir: " $PSScriptRoot
cmd /c mklink $HOME"\AppData\Local\nvim\init.vim" $PSScriptRoot"\.vimrc"

cmd /c mklink $HOME"\.vimrc" $PSScriptRoot"\.vimrc"

cmd /c mklink $HOME"\.vsvimrc" $PSScriptRoot"\.vsvimrc"
