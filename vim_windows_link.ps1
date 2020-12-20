
Write-Output "Current directory: " $PSScriptRoot
Write-Output "Home directory: " $PSScriptRoot
Write-Output "Linking .vimrc for Vim"
cmd /c mklink /D $HOME"\.vimrc" $PSScriptRoot"\.vimrc"
Write-Output "Linking .vsvimrc for Visual Studio"
cmd /c mklink /D $HOME"\.vsvimrc" $PSScriptRoot"\.vsvimrc"
Write-Output "Linking .vimrc for Neovim"
cmd /c mklink /D $HOME"\.config\nvim\init.vim" $PSScriptRoot"\.vimrc"