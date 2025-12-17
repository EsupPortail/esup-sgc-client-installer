#! /bin/bash

rm -rf esup-sgc-client
rm -rf esup-nfc-tag-desktop
rm -rf esup-nfc-tag-keyboard

git clone https://github.com/EsupPortail/esup-sgc-client.git
git clone https://github.com/EsupPortail/esup-nfc-tag-desktop.git
git clone https://github.com/EsupPortail/esup-nfc-tag-keyboard.git	   

sed -i -e "s&https://esup-sgc-demo.univ-rouen.fr&$1&g" esup-sgc-client/esupsgcclient-core/src/main/resources/esupsgcclient.properties
sed -i -e "s&https://esup-nfc-tag-demo.univ-rouen.fr&$2&g" esup-sgc-client/esupsgcclient-core/src/main/resources/esupsgcclient.properties
sed -i -e "s&https://esup-nfc-tag.univ-ville.fr&$2&g" esup-nfc-tag-desktop/src/main/resources/esupnfctag.properties esup-nfc-tag-keyboard/src/main/resources/esupnfctagkeyboard.properties
sed -i -e "s&https://esup-sgc.univ-ville.fr/manager/{0}&$1/manager/{0}&g" esup-nfc-tag-keyboard/src/main/resources/esupnfctagkeyboard.properties


mvn -f esup-sgc-client/pom.xml clean package
mv esup-sgc-client/esupsgcclient-assembly/target/esup-sgc-client-final.jar esup-sgc-client/esupsgcclient-assembly/target/esup-sgc-client.jar
mvn -f esup-sgc-client/pom.xml -P zebra initialize
mvn -f esup-sgc-client/pom.xml -P zebra package
mv esup-sgc-client/esupsgcclient-assembly/target/esup-sgc-client-final.jar esup-sgc-client/esupsgcclient-assembly/target/esup-sgc-client-zebra.jar
mvn -f esup-sgc-client/pom.xml -P evolis-sdk package
mv esup-sgc-client/esupsgcclient-assembly/target/esup-sgc-client-final.jar esup-sgc-client/esupsgcclient-assembly/target/esup-sgc-client-evolis-sdk.jar
mvn -f esup-nfc-tag-desktop/pom.xml clean package
mvn -f esup-nfc-tag-keyboard/pom.xml clean package
mvn clean package

cd target

zip -r esup-sgc-client-installer.zip jdk
zip esup-sgc-client-installer.zip esupsgc-installer.exe

cd ../

mv esup-sgc-client/esupsgcclient-assembly/target/esup-sgc-client.jar target/
mv esup-sgc-client/esupsgcclient-assembly/target/esup-sgc-client-zebra.jar target/
mv esup-sgc-client/esupsgcclient-assembly/target/esup-sgc-client-evolis-sdk.jar target/
cp esup-nfc-tag-keyboard/target/esup-nfc-tag-keyboard-final.jar target/esupnfctagkeyboard.jar
cp esup-nfc-tag-desktop/target/esup-nfc-tag-desktop-final.jar target/esupnfctagdesktop.jar

rm -rf target/antrun target/esupsgcclient-1.0-SNAPSHOT.jar target/esupsgc-installer.exe target/esupsgc-installer.jar target/jdk target/jfx target/maven-archiver target/package.7z target/staging
rm -rf esup-sgc-client esup-nfc-tag-desktop esup-nfc-tag-keyboard
