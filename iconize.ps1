# Chemin du dossier courant
$dossierCourant = Get-Location

# Création du dossier "iconize/devicon" s'il n'existe pas
$dossierIcons = Join-Path $dossierCourant "icons"
$cheminPack = Join-Path $dossierCourant "iconize/devicon"
if (-not (Test-Path $cheminPack)) {
	New-Item -ItemType Directory -Path $cheminPack | Out-Null
}

# Vide le dossier packs
Remove-Item -Path (Join-Path $cheminPack "*") -Recurse

# Liste des dossiers de premier niveau du dossier courant
$dossiers = Get-ChildItem -Path $dossierIcons -Directory

foreach ($dossier in $dossiers) {
	
	# Chemin du fichier original
	$nomFichierOriginal = "$($dossier.Name)/$($dossier.Name)-original.svg"
	$nomFichierPlain = "$($dossier.Name)/$($dossier.Name)-plain.svg"
	$nomFichierOriginalWordmark = "$($dossier.Name)/$($dossier.Name)-original-wordmark.svg"
	$nomFichierPlainWordmark = "$($dossier.Name)/$($dossier.Name)-plain-wordmark.svg"

	$nomFichierDestination = "$($dossier.Name).svg"
	$cheminDestination = Join-Path $cheminPack $nomFichierDestination

	$cheminFichierOriginal = Join-Path $dossierIcons $nomFichierOriginal
	$cheminFichierPlain = Join-Path $dossierIcons $nomFichierPlain
	$cheminFichierOriginalWordmark = Join-Path $dossierIcons $nomFichierOriginalWordmark
	$cheminFichierPlainWordmark = Join-Path $dossierIcons $nomFichierPlainWordmark

	# Vérification des chemins, puis copie
	if (Test-Path $cheminFichierOriginal -PathType Leaf) {
		Copy-Item -Path $cheminFichierOriginal -Destination $cheminDestination -Force
		Write-Output "Fichier '$nomFichierOriginal' copié."
	} elseif (Test-Path $cheminFichierPlain -PathType Leaf) {
		Copy-Item -Path $cheminFichierPlain -Destination $cheminDestination -Force
		Write-Output "Fichier '$nomFichierPlain' copié."
	} elseif (Test-Path $cheminFichierOriginalWordmark -PathType Leaf) {
		Copy-Item -Path $cheminFichierOriginalWordmark -Destination $cheminDestination -Force
		Write-Output "Fichier '$nomFichierOriginalWordmark' copié."
	} elseif (Test-Path $cheminFichierPlainWordmark -PathType Leaf) {
		Copy-Item -Path $cheminFichierPlainWordmark -Destination $cheminDestination -Force
		Write-Output "Fichier '$nomFichierPlainWordmark' copié."
	} else {
		Write-Output "*****************  Fichier '$dossier' non copié ! *****************"
	}
}
