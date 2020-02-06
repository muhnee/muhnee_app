# muhnee

The Native Version of Muhnee

## Development Setup

# How to run

## iOS

Initialise an instance of an iOS Simulator or connect physical iOS device, navigate to the cloned repo and run from root:

```sh
# from terminal

open -a simulator

cd desktop/muhnee-app
flutter run -d "iPhone"
```

## Android

### Keychain Certificate Setup

1. Download the `google-services.json` [here](https://console.firebase.google.com/u/0/project/muhnee-app/settings/general/android:com.muhneeapp.muhnee.budget) and move it to the directory `<PROJECT-ROOT>/android/app`
2. Get the Android Keychain by:

   ```
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass a
   ndroid
   ```

3. Copy either the SHA1 or the SHA256 certificate fingerprint onto the Android App on [Firebase Console](https://console.firebase.google.com/u/0/project/muhnee-app/settings/general/android:com.muhneeapp.muhnee.budget)

### Development

If you have a device plugged in run:

```
flutter run
```

### Releasing

1. Create a Keystore

   If you have an existing keystore, skip to the next step. If not,create one by running the following at the command line:

   On Mac/Linux, use the following command:

   ```sh
   keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
   ```

   On Windows, use the following command:

   ```sh
   keytool -genkey -v -keystore c:/Users/USER_NAME/key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000
   ```

2. Create a file named <app dir>/android/key.properties that contains a reference to your keystore:

   ```
   storePassword=<password from previous step>
   keyPassword=<password from previous step>
   keyAlias=key
   storeFile=<location of the key store file, such as /Users/<user name>/key.jks>
   ```

3. You will also need to update the SHA1/SHA256 Certificate Fingerprint in Firebase Console with the signing certificate.

   To get the certificate run:

   macOS/Linux:

   ```sh
   keytool -list -v -alias key -keystore ~/key.jks
   ```

   Windows:

   ```sh
   keytool -list -v -alias key -keystore c:/Users/USER_NAME/key.jks
   ```
