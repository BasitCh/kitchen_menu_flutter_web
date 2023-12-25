
echo "================================================================================"
echo "==============================START============================================="
echo "================================================================================"
# date +%s

# To run this command in windows/mac terminal use
# ./project.sh

# Flutter pub get for admin
cd admin/menumaster_admin
flutter clean
flutter pub get

cd ..
cd ..

# Flutter pub get for manager

cd manager/menumaster_manager
flutter clean
flutter pub get

cd ..
cd ..

# Flutter pub get for widgetbook

cd packages/widgets_book
flutter clean
flutter pub get

cd ..
cd ..

# Flutter pub get for main
flutter clean
flutter pub get

#(cd app_features/accounts/app-account/src && pwd && flutter pub get --suppress-analytics && flutter pub run build_runner build --delete-conflicting-outputs)
#(cd app_features/accounts/app-account/src/widgets && pwd && flutter pub get)


# date +%s
echo "================================================================================"
echo "================================END============================================="
echo "================================================================================"