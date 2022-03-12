$listenAddress = Get-Content "~/.nvim-listen-address"
Write-Output $listenAddress
$env:NVIM_LISTEN_ADDRESS = $listenAddress

nvr --remote .\.gitignore
