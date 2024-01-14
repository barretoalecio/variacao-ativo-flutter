cd ..
cd ..
echo "Deleting existing builds"
flutter clean
echo "Updating dependencies"
flutter pub upgrade
echo "Generating launch icon for development"
flutter pub run icons_launcher:main -f flutter_launcher_icons.yaml