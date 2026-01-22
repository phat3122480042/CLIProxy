$repo = "router-for-me/CLIProxyAPI"
$apiUrl = "https://api.github.com/repos/$repo/releases/latest"
Write-Host "Checking for latest version of CLIProxyAPI..."

try {
    $release = Invoke-RestMethod -Uri $apiUrl
    $asset = $release.assets | Where-Object { $_.name -match "windows" -and $_.name -match "amd64" } | Select-Object -First 1
    
    if ($null -eq $asset) {
        Write-Error "Could not find a Windows amd64 release asset."
        exit 1
    }

    $downloadUrl = $asset.browser_download_url
    $fileName = $asset.name
    Write-Host "Found version: $($release.tag_name)"
    Write-Host "Downloading: $fileName"
    
    Invoke-WebRequest -Uri $downloadUrl -OutFile $fileName
    
    if ($fileName -match ".zip") {
        Write-Host "Extracting zip file..."
        Expand-Archive -Path $fileName -DestinationPath . -Force
        # Find the exe in the extracted folder
        $exe = Get-ChildItem -Recursive -Filter "CLIProxyAPI.exe"
        if ($exe) { Move-Item $exe.FullName -Destination ".\CLIProxyAPI.exe" -Force }
    }
    elseif ($fileName -match ".tar.gz") {
        Write-Host "Extracting tar.gz (requires tar or similar tool, attempting native tar)..."
        tar -xf $fileName
        # Cleanup if needed or move
         $exe = Get-ChildItem -Recursive -Filter "CLIProxyAPI.exe" | Select-Object -First 1
        if ($exe) { Move-Item $exe.FullName -Destination ".\CLIProxyAPI.exe" -Force }
    }
    else {
        # Likely just the exe or unrecognized
        if ($fileName -match ".exe") {
            Move-Item $fileName "CLIProxyAPI.exe" -Force
        }
    }
    
    Write-Host "Installation ready. You can now run Start-CLIProxy.bat"
}
catch {
    Write-Error "An error occurred: $_"
}
