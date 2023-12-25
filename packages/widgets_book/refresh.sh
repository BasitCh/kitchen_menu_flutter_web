
echo "================================================================================"
echo "==============================START============================================="
echo "================================================================================"
# date +%s


flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs

#(cd app_features/accounts/app-account/src && pwd && flutter pub get --suppress-analytics && flutter pub run build_runner build --delete-conflicting-outputs)
#(cd app_features/accounts/app-account/src/widgets && pwd && flutter pub get)


# date +%s
echo "================================================================================"
echo "================================END============================================="
echo "================================================================================"