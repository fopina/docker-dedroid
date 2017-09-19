# DeDroid

Docker image to easily decompile (and recompile) Android APKs

This image contains the following tools:
* [apktool](https://ibotpeaches.github.io/Apktool/)
* zipalign and apksigner ([Android SDK](https://developer.android.com/studio/index.html#downloads))

### Usage

Start the shell inside the container, mapping the APK directory to `/work`
```
docker run --rm -v PATH_TO_APK_DIR:/work -ti fopina/dedroid sh
```
All the tools are in the `PATH` (in `/dedroid` directory), so you just go ahead and do `apktool d APK`


There's also an helper script:
```
$ docker run --rm fopina/dedroid helper > /usr/local/bin/dedroid
$ chmod a+x /usr/local/bin/dedroid
$ dedroid
Usage: dedroid d APK_FILE OUTPUT_DIR
       dedroid b INPUT_DIR APK_FILE

"d" will unpack the APK to OUTPUT_DIR and decode .dex to smali
"b" will rebuild APK from INPUT_DIR, zipalign it and sign it with new self-signed certificate

$ dedroid d some.test.apk tempdir
.... make changes in the smali files inside tempdir .....
$ dedroid b tempdir new.some.test.apk
.... ready to be installed in device/emulator!
```
