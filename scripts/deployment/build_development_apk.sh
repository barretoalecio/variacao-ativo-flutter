cd ..
cd ..
echo "Deleting existing builds"
flutter clean
echo "Updating dependencies"
flutter pub upgrade
echo "Building development APK"
flutter build apk --split-per-abi --flavor development --target lib/main_development.dart
echo "Opening file explorer in the generated folder"
open build/app/outputs/apk/development/release