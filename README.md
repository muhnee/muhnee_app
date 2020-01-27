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
