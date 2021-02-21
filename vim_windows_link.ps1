<<<<<<< HEAD

Write-Output "Current directory: " $PSScriptRoot
Write-Output "Home directory: " $PSScriptRoot
Write-Output "Linking .vimrc for Vim"
cmd /c mklink /D $HOME"\.vimrc" $PSScriptRoot"\.vimrc"
Write-Output "Linking .vsvimrc for Visual Studio"
cmd /c mklink /D $HOME"\.vsvimrc" $PSScriptRoot"\.vsvimrc"
Write-Output "Linking .vimrc for Neovim"
cmd /c mklink /D $HOME"\.config\nvim\init.vim" $PSScriptRoot"\.vimrc"
=======
Write-Output "Current dir: " $PSScriptRoot
cmd /c mklink $HOME"\AppData\Local\nvim\init.vim" $PSScriptRoot"\.vimrc"

cmd /c mklink $HOME"\.vimrc" $PSScriptRoot"\.vimrc"

cmd /c mklink $HOME"\.vsvimrc" $PSScriptRoot"\.vsvimrc"
>>>>>>> 4be0681c94e1f902c37c6982225d44732e6359c2
