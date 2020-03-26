$CURRENTDIR = Get-Location
. "$CURRENTDIR\common.ps1"

mkdir -Path "$CURRENTDIR/gmad-extracted" -ErrorAction SilentlyContinue | Out-Null

$GMOD_GMA_LIST = Get-ChildItem "$GARRYSMOD_DIR" -Filter *.gma
$GMOD_GMA_COUNT = ($GMOD_GMA_LIST | Measure-Object).Count
$GMAD_EXEC ="$GMAD_BASEDIR\gmad.exe"

Write-Output "Found $GMOD_GMA_COUNT .gma files in `"$GARRYSMOD_DIR`" "

$GMOD_GMA_LIST |
ForEach-Object {
    $filepath = $_.FullName
    $filename = $_.BaseName
    mkdir -Path "$CURRENTDIR/gmad-extracted/$filename" -ErrorAction SilentlyContinue | Out-Null
    & $GMAD_EXEC extract -file $filepath -out "$CURRENTDIR/gmad-extracted/$filename"
}
