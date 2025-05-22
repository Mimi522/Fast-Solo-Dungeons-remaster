$files = Get-ChildItem -Recurse -File | Where-Object { $_.Extension -match "\.js$|\.json$" }

Write-Output '{'
Write-Output '  "files": {'

for ($i = 0; $i -lt $files.Count; $i++) {
    $file = $files[$i]
    $hash = (Get-FileHash -Algorithm SHA256 $file.FullName).Hash.ToLower()
    $relativePath = $file.FullName.Substring((Get-Location).Path.Length + 1).Replace("\", "/")
    $comma = if ($i -lt $files.Count - 1) { "," } else { "" }
    Write-Output "    `"$relativePath`": `"$hash`"$comma"
}

Write-Output '  }'
Write-Output '}'
