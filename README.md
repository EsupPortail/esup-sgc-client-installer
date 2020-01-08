# esup-sgc-client-installer
Permet de créer un installateur Windows pour esup-sgc-client, esup-nfc-tag-desktop et esup-nfc-tag-keyboard.

Cet installateur embarque ainsi un openjdk+openjfx pour exécuter ces différents clients.

Celà permet de faciliter l'installation de ces clients, sans recourrir au JDK d'Oracle.

Deux solutions sont disponibles pour la génération de l'installateur :

## Solution 1 : Via https://esup-sgc-client-web-installer.univ-rouen.fr/

* Il suffit de se loguer.
* Puis d'entrer vos paramètres.
* L'application se charge du reste et vous propose des liens de téléchargements.

## Solution 2 : Générer mon installateur

### s'assurer que le JAVA_HOME pointe sur un JDK 11:
```
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
```

### Build :
```
./build.sh https://esup-sgc.univ-ville.fr https://esup-nfc-tag.univ-ville.fr
```

### Prérequis :
* Maven
* JDK 11
* git
* zip
