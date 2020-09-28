# File from:
# https://github.com/exercism/configlet/commit/c70be6269e71512ef0c041644f2814ad1a0e2981

Function DownloadUrl ([string] $FileName, $Headers) {
    $latestUrl = "https://api.github.com/repos/exercism/configlet/releases/latest"
    $json = Invoke-RestMethod -Headers $Headers -Uri $latestUrl
    $json.assets | Where-Object { $_.browser_download_url -match $FileName } | Select-Object -ExpandProperty browser_download_url
}

Function Headers {
    If ($GITHUB_TOKEN) { @{ Authorization = "Bearer ${GITHUB_TOKEN}" } } Else { @{ } }
}

Function Arch {
    If ([Environment]::Is64BitOperatingSystem) { "64bit" } Else { "32bit" }
}

$arch = Arch
$headers = Headers
$fileName = "configlet-windows-$arch.zip"
$outputDirectory = "bin"
$outputFile = Join-Path -Path $outputDirectory -ChildPath $fileName
$zipUrl = DownloadUrl -FileName $fileName -Headers $headers

Invoke-WebRequest -Headers $headers -Uri $zipUrl -OutFile $outputFile
Expand-Archive $outputFile -DestinationPath $outputDirectory -Force
Remove-Item -Path $outputFile
