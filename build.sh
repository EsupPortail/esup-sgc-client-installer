#! /bin/bash

rm -rf esup-sgc-client
rm -rf esup-nfc-tag-desktop
rm -rf esup-nfc-tag-keyboard

git clone https://github.com/EsupPortail/esup-sgc-client.git
git clone https://github.com/EsupPortail/esup-nfc-tag-desktop.git
git clone https://github.com/EsupPortail/esup-nfc-tag-keyboard.git	   

sed -i -e "s&https://esup-sgc.univ-ville.fr&$1&g" esup-sgc-client/src/main/resources/esupsgcclient.properties
sed -i -e "s&https://esup-nfc-tag.univ-ville.fr&$2&g" esup-sgc-client/src/main/resources/esupsgcclient.properties esup-nfc-tag-desktop/src/main/resources/esupnfctag.properties esup-nfc-tag-keyboard/src/main/resources/esupnfctagkeyboard.properties
sed -i -e "s&https://esup-sgc.univ-ville.fr/manager/{0}&$1/manager/{0}&g" esup-nfc-tag-keyboard/src/main/resources/esupnfctagkeyboard.properties

mvn -f esup-sgc-client/pom.xml clean package
mvn -f esup-nfc-tag-desktop/pom.xml clean package
mvn -f esup-nfc-tag-keyboard/pom.xml clean package
mvn clean package

7z a target/esupsgc-installer.7z ./target/esupsgc-installer.exe
7z a target/esupsgc-installer.7z ./target/jdk

cp esup-sgc-client/target/esup-sgc-client-final.jar target/esupsgcclient-shib.jar
cp esup-nfc-tag-keyboard/target/esup-nfc-tag-keyboard-final.jar target/esupnfctagkeyboard.jar
cp esup-nfc-tag-desktop/target/esup-nfc-tag-desktop-final.jar target/esupnfctagdesktop.jar

rm -rf target/antrun target/esupsgcclient-1.0-SNAPSHOT.jar target/esupsgc-installer.exe target/esupsgc-installer.jar target/jdk target/jfx target/maven-archiver target/package.7z target/staging
rm -rf esup-sgc-client esup-nfc-tag-desktop esup-nfc-tag-keyboard
