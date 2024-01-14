
cd ..
cd ..
echo "Deleting existing builds"
flutter clean
echo "Updating dependencies"
flutter pub upgrade
echo "Building development ipa for iOS"
flutter build ipa --target lib/main_development.dart
echo "Opening Xcode in the generated Runner.xcarchive file"
open build/ios/archive/Runner.xcarchive