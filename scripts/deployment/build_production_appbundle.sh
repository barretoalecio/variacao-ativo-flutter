cd ..
cd ..
echo "Deleting existing builds"
flutter clean
echo "Updating dependencies"
flutter pub upgrade
echo "Building production app bundle"
flutter build appbundle --flavor production --target lib/main_production.dart
echo "Opening file explorer in the generated folder"
open "build\app\outputs\bundle\productionRelease"