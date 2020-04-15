rm -r game/
mkdir game
cp -r assets/ main.lua Roboto-Bold.ttf game/
cd game/
zip -9 -r game.love .
cp game.love ../../love-android/app/src/main/assets/game.love
cd ../../love-android/
export ANDROID_HOME=/home/hritiktayade/Android/Sdk/
export ANDROID_NDK_HOME=/home/hritiktayade/Android/android-ndk-r21/
./gradlew assemble

