$env.JAVA_HOME = "/usr/lib/jvm/java-8-temurin/"
# Set the Android SDK root
$env.ANDROID_SDK_ROOT = "/home/xhuyz/Android/Sdk"
# Append Android tools to PATH
$env.PATH = ($env.PATH | append [
    "/home/xhuyz/Android/Sdk/cmdline-tools/bin/"
    "/home/xhuyz/Android/Sdk/build-tools"
    "/home/xhuyz/Android/Sdk/emulator"
    "/home/xhuyz/Android/Sdk/platform-tools"
    "/home/xhuyz/Android/Sdk/system-images"
])
#install fcitx5 -gtk -qt 
$env.GTK_IM_MODULE = "fcitx"
$env.QT_IM_MODULE = "fcitx"
$env.XMODIFIERS = "@im=fcitx"
#gemini-api-key
$env.GEMINI_API_KEY = "AIzaSyCKGnVqNkS728xMndahoCNW1avU8M1YUik"



