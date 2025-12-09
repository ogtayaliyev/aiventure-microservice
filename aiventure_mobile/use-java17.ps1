# Script pour utiliser Java 17 pour ce projet Flutter
# Ajustez le chemin vers votre installation Java 17
$env:JAVA_HOME = "C:\Program Files\Eclipse Adoptium\jdk-17.0.12.7-hotspot"  # Modifiez ce chemin après installation
$env:Path = "$env:JAVA_HOME\bin;$env:Path"

Write-Host "Java 17 activé pour cette session" -ForegroundColor Green
java -version
