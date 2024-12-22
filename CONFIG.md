# Saved Settings to not die later

- export JAVA_HOME=$(/usr/libexec/java_home -v 17)
- ndkVersion in [android/app/gradle](./android/app/gradle) is `"27.0.12077973"`

## AndroidManifest Permissions

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.INTERNET" />
```
