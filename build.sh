file=resources/esup-installer.properties

function getProperty {
   PROP_KEY=$1
   PROP_VALUE=`cat $file | grep "$PROP_KEY" | cut -d'=' -f2`
   echo $PROP_VALUE
}

rm -rf esup-sgc-client
rm -rf esup-nfc-tag-desktop
rm -rf esup-nfc-tag-keyboard
git clone https://github.com/EsupPortail/esup-sgc-client.git
git clone https://github.com/EsupPortail/esup-nfc-tag-desktop.git
git clone https://github.com/EsupPortail/esup-nfc-tag-keyboard.git	   

export JAVA_HOME=$(getProperty "JAVA_HOME")  
sed -i -e "s&https://esup-sgc.univ-ville.fr&$(getProperty "esupSgcUrl")&g" esup-sgc-client/src/main/resources/esupsgcclient.properties
sed -i -e "s&https://esup-nfc-tag.univ-ville.fr&$(getProperty "esupNfcTagServerUrl")&g" esup-sgc-client/src/main/resources/esupsgcclient.properties esup-nfc-tag-desktop/src/main/resources/esupnfctag.properties esup-nfc-tag-keyboard/src/main/resources/esupnfctagkeyboard.properties
sed -i -e "s&https://esup-sgc.univ-ville.fr/manager/{0}&$(getProperty "redirectUrlTemplate")&g" esup-nfc-tag-keyboard/src/main/resources/esupnfctagkeyboard.properties

mvn -f esup-sgc-client/pom.xml clean package
mvn -f esup-nfc-tag-desktop/pom.xml clean package
mvn -f esup-nfc-tag-keyboard/pom.xml clean package
mvn clean package

7z a target/package.7z ./target/esupsgc-installer.exe
7z a target/package.7z ./target/jdk
cat resources/sfx/7z.sfx target/package.7z > target/setup.exe



