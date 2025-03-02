$folders = @("web", "app", "cli", "service", "documentation", "research")

foreach ($folder in $folders) {
    if (-Not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder
        Write-Output "Created folder: $folder"
    } else {
        Write-Output "Folder already exists: $folder"
    }
}
