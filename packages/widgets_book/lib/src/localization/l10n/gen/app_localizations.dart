import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// Application Name
  ///
  /// In de, this message translates to:
  /// **'Menu Master'**
  String get appName;

  /// No description provided for @common_cancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get common_cancel;

  /// No description provided for @common_confirm.
  ///
  /// In de, this message translates to:
  /// **'Bestätigen'**
  String get common_confirm;

  /// No description provided for @common_next.
  ///
  /// In de, this message translates to:
  /// **'Next'**
  String get common_next;

  /// No description provided for @common_confirm_message.
  ///
  /// In de, this message translates to:
  /// **'Sind Sie sicher??'**
  String get common_confirm_message;

  /// No description provided for @common_detail.
  ///
  /// In de, this message translates to:
  /// **'Detail'**
  String get common_detail;

  /// No description provided for @common_edit.
  ///
  /// In de, this message translates to:
  /// **'Edit'**
  String get common_edit;

  /// No description provided for @common_delete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get common_delete;

  /// No description provided for @common_error.
  ///
  /// In de, this message translates to:
  /// **'Etwas ist schief gelaufen'**
  String get common_error;

  /// No description provided for @common_fetchError.
  ///
  /// In de, this message translates to:
  /// **'Leider konnten keine Daten zu dieser Anfrage gefunden werden...'**
  String get common_fetchError;

  /// No description provided for @common_field_date.
  ///
  /// In de, this message translates to:
  /// **'Datum'**
  String get common_field_date;

  /// No description provided for @common_field_mandatory.
  ///
  /// In de, this message translates to:
  /// **'Dieses Feld ist obligatorisch.'**
  String get common_field_mandatory;

  /// No description provided for @common_field_empty.
  ///
  /// In de, this message translates to:
  /// **'Bitte geben Sie einen Wert ein'**
  String get common_field_empty;

  /// No description provided for @common_field_time.
  ///
  /// In de, this message translates to:
  /// **'Zeit'**
  String get common_field_time;

  /// No description provided for @common_form_validation.
  ///
  /// In de, this message translates to:
  /// **'Einige Felder sind leer oder ungültig.'**
  String get common_form_validation;

  /// No description provided for @common_reset.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get common_reset;

  /// No description provided for @common_refresh.
  ///
  /// In de, this message translates to:
  /// **'Aktualisieren'**
  String get common_refresh;

  /// No description provided for @common_save.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get common_save;

  /// No description provided for @common_search.
  ///
  /// In de, this message translates to:
  /// **'Suche'**
  String get common_search;

  /// No description provided for @common_search_term.
  ///
  /// In de, this message translates to:
  /// **'Geben Sie einen Suchbegriff ein'**
  String get common_search_term;

  /// No description provided for @common_select.
  ///
  /// In de, this message translates to:
  /// **'Wähle'**
  String get common_select;

  /// No description provided for @common_submit.
  ///
  /// In de, this message translates to:
  /// **'Submit'**
  String get common_submit;

  /// No description provided for @common_was_success.
  ///
  /// In de, this message translates to:
  /// **'war erfolgreich'**
  String get common_was_success;

  /// No description provided for @common_upload.
  ///
  /// In de, this message translates to:
  /// **'Hochladen'**
  String get common_upload;

  /// No description provided for @common_upload_progress.
  ///
  /// In de, this message translates to:
  /// **'wird hochgeladen'**
  String get common_upload_progress;

  /// No description provided for @common_validate.
  ///
  /// In de, this message translates to:
  /// **'Bitte valides ID format eingeben'**
  String get common_validate;

  /// No description provided for @common_menu.
  ///
  /// In de, this message translates to:
  /// **'Menü Anzeigen / Schließen'**
  String get common_menu;

  /// No description provided for @forgot_password_text.
  ///
  /// In de, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password_text;

  /// No description provided for @login_enter_your_email.
  ///
  /// In de, this message translates to:
  /// **'Enter your Email address for to reset \n the password'**
  String get login_enter_your_email;

  /// No description provided for @reset_password_button_text.
  ///
  /// In de, this message translates to:
  /// **'Reset password'**
  String get reset_password_button_text;

  /// No description provided for @login_now_button_text.
  ///
  /// In de, this message translates to:
  /// **'login now'**
  String get login_now_button_text;

  /// No description provided for @success_appbar_text.
  ///
  /// In de, this message translates to:
  /// **'Success'**
  String get success_appbar_text;

  /// No description provided for @password_reset_title_text.
  ///
  /// In de, this message translates to:
  /// **'Password updated'**
  String get password_reset_title_text;

  /// No description provided for @password_updated_text.
  ///
  /// In de, this message translates to:
  /// **'Your password has been updated. please \n login to continue using the app. '**
  String get password_updated_text;

  /// No description provided for @common_go_back.
  ///
  /// In de, this message translates to:
  /// **'Zurück zum vorherigen Bildschirm'**
  String get common_go_back;

  /// No description provided for @common_unknown_user.
  ///
  /// In de, this message translates to:
  /// **'Unbekannter Benutzername'**
  String get common_unknown_user;

  /// No description provided for @common_success.
  ///
  /// In de, this message translates to:
  /// **'Success'**
  String get common_success;

  /// No description provided for @common_got_it.
  ///
  /// In de, this message translates to:
  /// **'GOT IT'**
  String get common_got_it;

  /// No description provided for @common_try_again.
  ///
  /// In de, this message translates to:
  /// **'TRY AGAIN'**
  String get common_try_again;

  /// No description provided for @common_no_internet.
  ///
  /// In de, this message translates to:
  /// **'No Internet'**
  String get common_no_internet;

  /// No description provided for @common_no_internet_description.
  ///
  /// In de, this message translates to:
  /// **'Just like a reliable ingredient, a stable internet connection is essential. Please check your internet connection and try again'**
  String get common_no_internet_description;

  /// No description provided for @home_screen_title.
  ///
  /// In de, this message translates to:
  /// **'Home'**
  String get home_screen_title;

  /// No description provided for @info_appNames.
  ///
  /// In de, this message translates to:
  /// **'Name Anwendung'**
  String get info_appNames;

  /// No description provided for @info_appVersion.
  ///
  /// In de, this message translates to:
  /// **'Software Version'**
  String get info_appVersion;

  /// No description provided for @info_buildNumber.
  ///
  /// In de, this message translates to:
  /// **'Build Nummer'**
  String get info_buildNumber;

  /// No description provided for @info_buildSignature.
  ///
  /// In de, this message translates to:
  /// **'Build Signatur'**
  String get info_buildSignature;

  /// No description provided for @info_infoName.
  ///
  /// In de, this message translates to:
  /// **'Über...'**
  String get info_infoName;

  /// No description provided for @info_notSet.
  ///
  /// In de, this message translates to:
  /// **'nicht bekannt'**
  String get info_notSet;

  /// No description provided for @info_packageName.
  ///
  /// In de, this message translates to:
  /// **'Paket Name'**
  String get info_packageName;

  /// No description provided for @signup_verify_your_email.
  ///
  /// In de, this message translates to:
  /// **'Please verify your email'**
  String get signup_verify_your_email;

  /// No description provided for @splash_loading.
  ///
  /// In de, this message translates to:
  /// **'LOADING...'**
  String get splash_loading;

  /// No description provided for @signup_create_account.
  ///
  /// In de, this message translates to:
  /// **'Create account'**
  String get signup_create_account;

  /// No description provided for @signup_email_and_password_for_signup.
  ///
  /// In de, this message translates to:
  /// **'Email and Password for sign up.'**
  String get signup_email_and_password_for_signup;

  /// No description provided for @signup_already_have_account.
  ///
  /// In de, this message translates to:
  /// **'Already have account?'**
  String get signup_already_have_account;

  /// No description provided for @signup_email_address.
  ///
  /// In de, this message translates to:
  /// **'Email address'**
  String get signup_email_address;

  /// No description provided for @signup_password.
  ///
  /// In de, this message translates to:
  /// **'Password'**
  String get signup_password;

  /// No description provided for @signup_confirm_password.
  ///
  /// In de, this message translates to:
  /// **'Confirm Password'**
  String get signup_confirm_password;

  /// No description provided for @signup_button.
  ///
  /// In de, this message translates to:
  /// **'sign up'**
  String get signup_button;

  /// No description provided for @signup_by_signing_up.
  ///
  /// In de, this message translates to:
  /// **'By Signing up you agree to our '**
  String get signup_by_signing_up;

  /// No description provided for @signup_terms_condition.
  ///
  /// In de, this message translates to:
  /// **'Terms Conditions'**
  String get signup_terms_condition;

  /// No description provided for @signup_and.
  ///
  /// In de, this message translates to:
  /// **' & '**
  String get signup_and;

  /// No description provided for @signup_privacy_policy.
  ///
  /// In de, this message translates to:
  /// **'Privacy Policy.'**
  String get signup_privacy_policy;

  /// No description provided for @signup_an_email_verification_link_sent.
  ///
  /// In de, this message translates to:
  /// **'An email Verification Link has been sent to your account.'**
  String get signup_an_email_verification_link_sent;

  /// No description provided for @account_created.
  ///
  /// In de, this message translates to:
  /// **'Account Created'**
  String get account_created;

  /// No description provided for @account_created_verified.
  ///
  /// In de, this message translates to:
  /// **'Account Verified'**
  String get account_created_verified;

  /// No description provided for @account_created_your_account_has_been_created.
  ///
  /// In de, this message translates to:
  /// **'Your account has been created successfully. \nNow you can set up your profile'**
  String get account_created_your_account_has_been_created;

  /// No description provided for @account_created_setup_profile.
  ///
  /// In de, this message translates to:
  /// **'Setup profile'**
  String get account_created_setup_profile;

  /// No description provided for @login_title.
  ///
  /// In de, this message translates to:
  /// **'Login'**
  String get login_title;

  /// No description provided for @login_enter_your_phone_number_or_email.
  ///
  /// In de, this message translates to:
  /// **'Enter your Phone number or Email address for sign in.'**
  String get login_enter_your_phone_number_or_email;

  /// No description provided for @login_forgot_password.
  ///
  /// In de, this message translates to:
  /// **'Forgot Password?'**
  String get login_forgot_password;

  /// No description provided for @login_sign_in.
  ///
  /// In de, this message translates to:
  /// **'Sign in'**
  String get login_sign_in;

  /// No description provided for @login_dont_have_account.
  ///
  /// In de, this message translates to:
  /// **'Don’t have account?'**
  String get login_dont_have_account;

  /// No description provided for @login_create_new_account.
  ///
  /// In de, this message translates to:
  /// **'Create new account.'**
  String get login_create_new_account;

  /// No description provided for @setup_profile.
  ///
  /// In de, this message translates to:
  /// **'Setup profile'**
  String get setup_profile;

  /// No description provided for @setup_profile_enter_the_required_information_to_complete.
  ///
  /// In de, this message translates to:
  /// **'Enter the required information to complete the profile setup process'**
  String get setup_profile_enter_the_required_information_to_complete;

  /// No description provided for @setup_profile_upload_profile_photo.
  ///
  /// In de, this message translates to:
  /// **'Upload profile photo'**
  String get setup_profile_upload_profile_photo;

  /// No description provided for @setup_profile_full_name.
  ///
  /// In de, this message translates to:
  /// **'FULL NAME'**
  String get setup_profile_full_name;

  /// No description provided for @setup_profile_personal_info.
  ///
  /// In de, this message translates to:
  /// **'Personal Info'**
  String get setup_profile_personal_info;

  /// No description provided for @setup_profile_phone_number.
  ///
  /// In de, this message translates to:
  /// **'PHONE NUMBER'**
  String get setup_profile_phone_number;

  String get setup_profile_phone;

  /// No description provided for @setup_profile_address.
  ///
  /// In de, this message translates to:
  /// **'Address'**
  String get setup_profile_address;

  /// No description provided for @setup_profile_country.
  ///
  /// In de, this message translates to:
  /// **'COUNTRY'**
  String get setup_profile_country;

  /// No description provided for @setup_profile_select_country.
  ///
  /// In de, this message translates to:
  /// **'Select country'**
  String get setup_profile_select_country;

  /// No description provided for @setup_profile_state.
  ///
  /// In de, this message translates to:
  /// **'State'**
  String get setup_profile_state;

  String get setup_profile_state_region;

  /// No description provided for @setup_profile_street_address.
  ///
  /// In de, this message translates to:
  /// **'STREET ADDRESS (OPTIONAL)'**
  String get setup_profile_street_address;

  /// No description provided for @setup_profile_subscription.
  ///
  /// In de, this message translates to:
  /// **'Subscription'**
  String get setup_profile_subscription;

  /// No description provided for @setup_profile_select_your_monthly_subscription.
  ///
  /// In de, this message translates to:
  /// **'SELECT YOUR MONTHLY SUBSCRIPTION'**
  String get setup_profile_select_your_monthly_subscription;

  /// No description provided for @setup_profile_free.
  ///
  /// In de, this message translates to:
  /// **'Free'**
  String get setup_profile_free;

  /// No description provided for @setup_profile_upload_and_view_two_recipes.
  ///
  /// In de, this message translates to:
  /// **'Upload & view two recipes'**
  String get setup_profile_upload_and_view_two_recipes;

  /// No description provided for @setup_profile_premium_$35_per_month.
  ///
  /// In de, this message translates to:
  /// **'Premium \$35 / Month'**
  String get setup_profile_premium_$35_per_month;

  /// No description provided for @setup_profile_create_upload_and_view_unlimited_recipes.
  ///
  /// In de, this message translates to:
  /// **'Create, Upload & View unlimited recipes'**
  String get setup_profile_create_upload_and_view_unlimited_recipes;

  /// No description provided for @setup_profile_about.
  ///
  /// In de, this message translates to:
  /// **'About'**
  String get setup_profile_about;

  /// No description provided for @setup_profile_tell_more_about_you.
  ///
  /// In de, this message translates to:
  /// **'TELL MORE ABOUT YOU'**
  String get setup_profile_tell_more_about_you;

  /// No description provided for @setup_profile_save_profile.
  ///
  /// In de, this message translates to:
  /// **'SAVE PROFILE'**
  String get setup_profile_save_profile;

  /// No description provided for @welcome_title.
  ///
  /// In de, this message translates to:
  /// **'Welcome'**
  String get welcome_title;

  /// No description provided for @welcome_tailored_just_for_you.
  ///
  /// In de, this message translates to:
  /// **'Tailored just for You'**
  String get welcome_tailored_just_for_you;

  /// No description provided for @welcome_goodbye_labour_intensive_processes.
  ///
  /// In de, this message translates to:
  /// **'Goodbye labour-intensive processes. Hello streamlined efficiency. Unique recipes with portion sizes tailored to suit feeding pre-school children and a supportive community of like minded cooks.'**
  String get welcome_goodbye_labour_intensive_processes;

  /// No description provided for @welcome_got_it.
  ///
  /// In de, this message translates to:
  /// **'Got it  '**
  String get welcome_got_it;

  /// No description provided for @home_search_for_plans_recipes.
  ///
  /// In de, this message translates to:
  /// **'Search for plans & recipes'**
  String get home_search_for_plans_recipes;

  /// No description provided for @home_welcome_to_menu_master.
  ///
  /// In de, this message translates to:
  /// **'Welcome to Menu Master'**
  String get home_welcome_to_menu_master;

  /// No description provided for @home_menu_master_recipes.
  ///
  /// In de, this message translates to:
  /// **'Menu Master Recipes'**
  String get home_menu_master_recipes;

  /// No description provided for @home_view_menu_master_recipes.
  ///
  /// In de, this message translates to:
  /// **'View menu master recipes'**
  String get home_view_menu_master_recipes;

  /// No description provided for @home_menu.
  ///
  /// In de, this message translates to:
  /// **'Menu'**
  String get home_menu;

  /// No description provided for @home_my_recipes.
  ///
  /// In de, this message translates to:
  /// **'My Recipes'**
  String get home_my_recipes;

  /// No description provided for @home_my_revolving_menu.
  ///
  /// In de, this message translates to:
  /// **'My revolving menu'**
  String get home_my_revolving_menu;

  /// No description provided for @home_view_all_my_recipes.
  ///
  /// In de, this message translates to:
  /// **'View all my recipes'**
  String get home_view_all_my_recipes;

  /// No description provided for @home_recently_added.
  ///
  /// In de, this message translates to:
  /// **'Recently added'**
  String get home_recently_added;

  /// No description provided for @home_recipes_recently_added_by.
  ///
  /// In de, this message translates to:
  /// **'Recipes Recently added by '**
  String get home_recipes_recently_added_by;

  /// No description provided for @home_crepe_quiche_cups.
  ///
  /// In de, this message translates to:
  /// **'Crepe quiche cups'**
  String get home_crepe_quiche_cups;

  /// No description provided for @home_breakfast.
  ///
  /// In de, this message translates to:
  /// **'Breakfast'**
  String get home_breakfast;

  /// No description provided for @home_details.
  ///
  /// In de, this message translates to:
  /// **'Details'**
  String get home_details;

  /// No description provided for @nav_bar_recipes.
  ///
  /// In de, this message translates to:
  /// **'Recipes'**
  String get nav_bar_recipes;

  /// No description provided for @nav_bar_menus.
  ///
  /// In de, this message translates to:
  /// **'Menus'**
  String get nav_bar_menus;

  /// No description provided for @nav_bar_profile.
  ///
  /// In de, this message translates to:
  /// **'Profile'**
  String get nav_bar_profile;

  /// No description provided for @all_recipes_title.
  ///
  /// In de, this message translates to:
  /// **'All Recipes'**
  String get all_recipes_title;

  /// No description provided for @all_recipes_list_of_all_recipes.
  ///
  /// In de, this message translates to:
  /// **'List of all recipes'**
  String get all_recipes_list_of_all_recipes;

  /// No description provided for @all_recipes_select_category.
  ///
  /// In de, this message translates to:
  /// **'Select Category'**
  String get all_recipes_select_category;

  /// No description provided for @all_recipes_filters.
  ///
  /// In de, this message translates to:
  /// **'Filters'**
  String get all_recipes_filters;

  /// No description provided for @all_recipes_select_filters.
  ///
  /// In de, this message translates to:
  /// **'Select Filters'**
  String get all_recipes_select_filters;

  /// No description provided for @all_recipes_reset_filters.
  ///
  /// In de, this message translates to:
  /// **'Reset Filters'**
  String get all_recipes_reset_filters;

  /// No description provided for @all_recipes_select_one_or_more.
  ///
  /// In de, this message translates to:
  /// **'Select one or more filters from the following list that are applicable.'**
  String get all_recipes_select_one_or_more;

  /// No description provided for @all_recipes_apply_filters.
  ///
  /// In de, this message translates to:
  /// **'APPLY FILTERS'**
  String get all_recipes_apply_filters;

  /// No description provided for @all_recipes_applied_filters.
  ///
  /// In de, this message translates to:
  /// **'Applied Filters'**
  String get all_recipes_applied_filters;

  /// No description provided for @all_recipes_clear_filters.
  ///
  /// In de, this message translates to:
  /// **'Clear Filters'**
  String get all_recipes_clear_filters;

  /// No description provided for @create_recipe_title.
  ///
  /// In de, this message translates to:
  /// **'Create recipe'**
  String get create_recipe_title;

  /// No description provided for @create_recipe_create_a_recipe.
  ///
  /// In de, this message translates to:
  /// **'Create a recipe'**
  String get create_recipe_create_a_recipe;

  /// No description provided for @create_recipe_enter_the_basic_information_of_your_recipe.
  ///
  /// In de, this message translates to:
  /// **'Enter the basic information of your recipe i.e; photos, name, description etc.'**
  String get create_recipe_enter_the_basic_information_of_your_recipe;

  /// No description provided for @create_recipe_basic_info.
  ///
  /// In de, this message translates to:
  /// **'BASIC INFO'**
  String get create_recipe_basic_info;

  /// No description provided for @create_recipe_category_filters.
  ///
  /// In de, this message translates to:
  /// **'CATEGORY & FILTERS'**
  String get create_recipe_category_filters;

  /// No description provided for @create_recipe_step_1_4.
  ///
  /// In de, this message translates to:
  /// **'(Step 1/4)'**
  String get create_recipe_step_1_4;

  /// No description provided for @create_recipe_step_2_4.
  ///
  /// In de, this message translates to:
  /// **'(Step 2/4)'**
  String get create_recipe_step_2_4;

  /// No description provided for @create_recipe_step_3_4.
  ///
  /// In de, this message translates to:
  /// **'(Step 3/4)'**
  String get create_recipe_step_3_4;

  /// No description provided for @create_recipe_step_4_4.
  ///
  /// In de, this message translates to:
  /// **'(Step 4/4)'**
  String get create_recipe_step_4_4;

  /// No description provided for @create_recipe_upload_photos.
  ///
  /// In de, this message translates to:
  /// **'Upload photos'**
  String get create_recipe_upload_photos;

  /// No description provided for @create_recipe_tap_to_upload_the_photos.
  ///
  /// In de, this message translates to:
  /// **'(tap to upload the photos)'**
  String get create_recipe_tap_to_upload_the_photos;

  /// No description provided for @create_recipe_recipe_name.
  ///
  /// In de, this message translates to:
  /// **'RECIPE NAME'**
  String get create_recipe_recipe_name;

  /// No description provided for @create_recipe_asteric.
  ///
  /// In de, this message translates to:
  /// **' *'**
  String get create_recipe_asteric;

  /// No description provided for @create_recipe_give_your_recipe_a_name.
  ///
  /// In de, this message translates to:
  /// **'Give your recipe a name'**
  String get create_recipe_give_your_recipe_a_name;

  /// No description provided for @create_recipe_recipe_description.
  ///
  /// In de, this message translates to:
  /// **'RECIPE DESCRIPTION'**
  String get create_recipe_recipe_description;

  /// No description provided for @create_recipe_introduce_your_recipe_add_notes.
  ///
  /// In de, this message translates to:
  /// **'Introduce your recipe, add notes, cooking tips, serving suggestions, etc...'**
  String get create_recipe_introduce_your_recipe_add_notes;

  /// No description provided for @create_recipe_prep_time.
  ///
  /// In de, this message translates to:
  /// **'PREP TIME'**
  String get create_recipe_prep_time;

  /// No description provided for @create_recipe_how_long_does_it_takes_to_prepare.
  ///
  /// In de, this message translates to:
  /// **'How long does it take to prepare this recipe?'**
  String get create_recipe_how_long_does_it_takes_to_prepare;

  /// No description provided for @create_recipe_hours_0.
  ///
  /// In de, this message translates to:
  /// **'Hours: 0'**
  String get create_recipe_hours_0;

  /// No description provided for @create_recipe_minutes_0.
  ///
  /// In de, this message translates to:
  /// **'Minutes: 0'**
  String get create_recipe_minutes_0;

  /// No description provided for @create_recipe_cook_time.
  ///
  /// In de, this message translates to:
  /// **'COOK TIME'**
  String get create_recipe_cook_time;

  /// No description provided for @create_recipe_how_long_does_it_takes_to_cook.
  ///
  /// In de, this message translates to:
  /// **'How long does it take to cook this recipe?'**
  String get create_recipe_how_long_does_it_takes_to_cook;

  /// No description provided for @create_recipe_empty_name_validation.
  ///
  /// In de, this message translates to:
  /// **'Please enter a recipe name'**
  String get create_recipe_empty_name_validation;

  /// No description provided for @create_recipe_empty_description_validation.
  ///
  /// In de, this message translates to:
  /// **'Please enter recipe description'**
  String get create_recipe_empty_description_validation;

  /// No description provided for @create_recipe_empty_hours_validation.
  ///
  /// In de, this message translates to:
  /// **'Please enter hours'**
  String get create_recipe_empty_hours_validation;

  /// No description provided for @create_recipe_empty_minutes_validation.
  ///
  /// In de, this message translates to:
  /// **'Please enter minutes'**
  String get create_recipe_empty_minutes_validation;

  /// No description provided for @create_recipe_select_a_category.
  ///
  /// In de, this message translates to:
  /// **'Select a Category'**
  String get create_recipe_select_a_category;

  /// No description provided for @create_recipe_allergies.
  ///
  /// In de, this message translates to:
  /// **'Allergies'**
  String get create_recipe_allergies;

  /// No description provided for @create_recipe_ingredients.
  ///
  /// In de, this message translates to:
  /// **'INGREDIENTS'**
  String get create_recipe_ingredients;

  /// No description provided for @create_recipe_add_ingredients_for.
  ///
  /// In de, this message translates to:
  /// **'ADD INGREDIENTS FOR '**
  String get create_recipe_add_ingredients_for;

  /// No description provided for @create_recipe_qty.
  ///
  /// In de, this message translates to:
  /// **'Qty'**
  String get create_recipe_qty;

  /// No description provided for @create_recipe_nzd.
  ///
  /// In de, this message translates to:
  /// **'NZD'**
  String get create_recipe_nzd;

  /// No description provided for @create_recipe_view_nutritional_values.
  ///
  /// In de, this message translates to:
  /// **'View nutritional values'**
  String get create_recipe_view_nutritional_values;

  /// No description provided for @create_recipe_estimated_cost.
  ///
  /// In de, this message translates to:
  /// **'Estimated cost'**
  String get create_recipe_estimated_cost;

  /// No description provided for @create_recipe_List_of_children_with.
  ///
  /// In de, this message translates to:
  /// **'LIST OF CHILDREN WITH'**
  String get create_recipe_List_of_children_with;

  /// No description provided for @create_recipe_name.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get create_recipe_name;

  /// No description provided for @create_recipe_room_name.
  ///
  /// In de, this message translates to:
  /// **'Room Name'**
  String get create_recipe_room_name;

  /// No description provided for @create_recipe_got_it.
  ///
  /// In de, this message translates to:
  /// **'GOT IT'**
  String get create_recipe_got_it;

  /// No description provided for @create_recipe_add_edit_filters.
  ///
  /// In de, this message translates to:
  /// **'ADD / EDIT FILTERS'**
  String get create_recipe_add_edit_filters;

  /// No description provided for @create_recipe_no_ingredients_added_yet.
  ///
  /// In de, this message translates to:
  /// **'No ingredients added yet'**
  String get create_recipe_no_ingredients_added_yet;

  /// No description provided for @create_recipe_nutrition_information.
  ///
  /// In de, this message translates to:
  /// **'NUTRITION INFORMATION'**
  String get create_recipe_nutrition_information;

  /// No description provided for @create_recipe_nutrition_per_child.
  ///
  /// In de, this message translates to:
  /// **'Nutrition per child'**
  String get create_recipe_nutrition_per_child;

  /// No description provided for @create_recipe_daily_value.
  ///
  /// In de, this message translates to:
  /// **'Daily Value'**
  String get create_recipe_daily_value;

  /// No description provided for @create_recipe_prep_steps.
  ///
  /// In de, this message translates to:
  /// **'PREP STEPS'**
  String get create_recipe_prep_steps;

  /// No description provided for @create_recipe_add_preparation_steps.
  ///
  /// In de, this message translates to:
  /// **'ADD PREPARATION STEPS'**
  String get create_recipe_add_preparation_steps;

  /// No description provided for @create_recipe_step.
  ///
  /// In de, this message translates to:
  /// **'Step'**
  String get create_recipe_step;

  /// No description provided for @create_recipe_finish_and_review.
  ///
  /// In de, this message translates to:
  /// **'FINISH & REVIEW'**
  String get create_recipe_finish_and_review;

  /// No description provided for @review_recipe.
  ///
  /// In de, this message translates to:
  /// **'Review recipe'**
  String get review_recipe;

  /// No description provided for @review_recipe_title.
  ///
  /// In de, this message translates to:
  /// **'Review'**
  String get review_recipe_title;

  /// No description provided for @review_recipe_make_changes.
  ///
  /// In de, this message translates to:
  /// **'MAKE CHANGES'**
  String get review_recipe_make_changes;

  /// No description provided for @review_recipe_publish_recipe.
  ///
  /// In de, this message translates to:
  /// **'PUBLISH RECIPE'**
  String get review_recipe_publish_recipe;

  /// No description provided for @review_recipe_ingredients_for.
  ///
  /// In de, this message translates to:
  /// **'INGREDIENTS FOR'**
  String get review_recipe_ingredients_for;

  /// No description provided for @review_recipe_preparation_step.
  ///
  /// In de, this message translates to:
  /// **'PREPARATION STEPS'**
  String get review_recipe_preparation_step;

  /// No description provided for @messages_error.
  ///
  /// In de, this message translates to:
  /// **'Error'**
  String get messages_error;

  /// No description provided for @create_recipe_please_select_images.
  ///
  /// In de, this message translates to:
  /// **'Please select recipe images.'**
  String get create_recipe_please_select_images;

  /// No description provided for @create_recipe_please_select_category.
  ///
  /// In de, this message translates to:
  /// **'Please select a category.'**
  String get create_recipe_please_select_category;

  /// No description provided for @create_recipe_please_add_ingredients.
  ///
  /// In de, this message translates to:
  /// **'Please add ingredients.'**
  String get create_recipe_please_add_ingredients;

  /// No description provided for @create_recipe_please_add_preparation_steps.
  ///
  /// In de, this message translates to:
  /// **'Please add preparation steps.'**
  String get create_recipe_please_add_preparation_steps;

  /// No description provided for @all_recipes_upgrade_your_plan.
  ///
  /// In de, this message translates to:
  /// **'Upgrade your plan to view more recipes'**
  String get all_recipes_upgrade_your_plan;

  /// No description provided for @all_recipes_get_premium_now.
  ///
  /// In de, this message translates to:
  /// **'Get premium now'**
  String get all_recipes_get_premium_now;

  /// No description provided for @all_recipes_get_premium.
  ///
  /// In de, this message translates to:
  /// **'Get premium'**
  String get all_recipes_get_premium;

  /// No description provided for @create_recipe_free_recipes.
  ///
  /// In de, this message translates to:
  /// **'Free Recipes:'**
  String get create_recipe_free_recipes;

  /// No description provided for @create_recipe_free_limit_reached.
  ///
  /// In de, this message translates to:
  /// **'FREE LIMIT REACHED'**
  String get create_recipe_free_limit_reached;

  /// No description provided for @create_recipe_you_have_created_2_2_recipes.
  ///
  /// In de, this message translates to:
  /// **'You have created 2/2 free recipes. Unlock'**
  String get create_recipe_you_have_created_2_2_recipes;

  /// No description provided for @create_recipe_premium.
  ///
  /// In de, this message translates to:
  /// **'premium'**
  String get create_recipe_premium;

  /// No description provided for @create_to_create_and_view_unlimited_recipes.
  ///
  /// In de, this message translates to:
  /// **'to create & view unlimited recipes.'**
  String get create_to_create_and_view_unlimited_recipes;

  /// No description provided for @forgot_password_password_reset_email_sent.
  ///
  /// In de, this message translates to:
  /// **'Password Reset Email Sent'**
  String get forgot_password_password_reset_email_sent;

  /// No description provided for @forgot_password_to_reset_your_password.
  ///
  /// In de, this message translates to:
  /// **'To reset your password please check your email and follow the link.'**
  String get forgot_password_to_reset_your_password;

  /// No description provided for @messages_logged_in.
  ///
  /// In de, this message translates to:
  /// **'Logged in'**
  String get messages_logged_in;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
