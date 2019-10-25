# esup-sgc-client-installer
Permet de créer un installateur Windows pour esup-sgc-client, esup-nfc-tag-desktop et esup-nfc-tag-keyboard.

Cet installateur embarque ainsi un openjdk+openjfx pour exécuter ces différents clients.

Celà permet de faciliter l'installation de ces clients, sans recourrir au JDK d'Oracle.


## Modification des propriétés (chemin java11, urls esup-sgc  et esup-nfc) via le fichier :
```
resources/esup-installer.properties
```

## Build :
```
./build.sh
```

## Prérequis :
* Maven
* JDK 11
* git
* p7zip
