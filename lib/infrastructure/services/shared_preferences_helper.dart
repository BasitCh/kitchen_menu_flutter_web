// ignore_for_file: lines_longer_than_80_chars, depend_on_referenced_packages, unnecessary_null_comparison

import 'dart:convert';

import 'package:menumaster_manager/domain/invite_chefs/invite.dart';
import 'package:menumaster_manager/domain/sign_up/pref_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Usage:
/// - initialize the Helper to create an instance for SharedPreferences: [SharedPreferenceHelper.instance.init()];
class SharedPreferenceService {
  SharedPreferenceService._internal();
  static final SharedPreferenceService _spSingleton =
      SharedPreferenceService._internal();

  static SharedPreferenceService get instance => _spSingleton;

  /// Needs to run SharedPreferenceHelper.instance.init() before.
  /// Made private to close modifications
  static late SharedPreferences _sharedPrefInstance;
  void init() {
    SharedPreferences.getInstance()
        .then((value) => _sharedPrefInstance = value);
  }

  bool get hasAppRan =>
      _sharedPrefInstance.getBool(PreferencesKey.hasAppRanKey) ?? false;
  set hasAppRan(bool? hasAppRan) {
    _sharedPrefInstance.setBool(PreferencesKey.hasAppRanKey, hasAppRan!);
  }

  /// Save User login data for feature use
  static Future<bool> saveUser(PrefUser? data) async {
    if (data != null) {
      _sharedPrefInstance = await SharedPreferences.getInstance();
      return _sharedPrefInstance.setString(
          PreferencesKey.userKey, json.encode(data.toJson()));
    } else {
      return deletePreferences(PreferencesKey.userKey);
    }
  }

  // /// Get User
  static Future<PrefUser?> getUser() async {
    late PrefUser user;
    _sharedPrefInstance = await SharedPreferences.getInstance();
    if (_sharedPrefInstance.getString(PreferencesKey.userKey) != null) {
      user = PrefUser.fromJson(
          json.decode(_sharedPrefInstance.getString(PreferencesKey.userKey)!));
    }
    return user;
  }

  static Future<bool> saveInvitedChefs(List<Invite>? data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (data != null) {
      final jsonList = data.map((obj) => obj.toJson()).toList();
      final jsonString = json.encode(jsonList);
      return pref.setString(PreferencesKey.chefsToBeInvited, jsonString);
    } else {
      return deletePreferences(PreferencesKey.chefsToBeInvited);
    }
  }

  // /// Get User
  static Future<List<Invite>?> getChefsToBeInvited() async {
    late List<Invite> chefs;
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString(PreferencesKey.chefsToBeInvited) != null) {
      final jsonString = pref.getString(PreferencesKey.chefsToBeInvited);
      if (jsonString != null && jsonString.isNotEmpty) {
        final jsonList = json.decode(jsonString) as List<dynamic>;
        chefs =
            jsonList.map((jsonObject) => Invite.fromJson(jsonObject)).toList();
      }
    }
    return chefs;
  }

  // /// to delete the preference
  static Future<bool> deletePreferences(String key) async {
    return _sharedPrefInstance.remove(key);
  }

  static Future<bool> delatePreferences() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.clear();
  }
}

class PreferencesKey {
  ///User login key to save user login data
  static String userKey = 'user';
  static String chefsToBeInvited = 'chefs_to_be_invited';

  ///a key to check if it's app has ran before. Will be true if app has ran before.
  static String hasAppRanKey = 'hasAppRan';
}
