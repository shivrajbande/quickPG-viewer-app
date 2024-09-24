import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rento/constants/app_constants.dart';
import 'package:rento/controllers/bottom_nav_controller.dart';
import 'package:rento/controllers/chat_controller.dart';
import 'package:rento/controllers/home_controller.dart';
import 'package:rento/controllers/language_controller.dart';
import 'package:rento/controllers/login_controller.dart';
import 'package:rento/controllers/search_controller.dart';
import 'package:rento/controllers/settings_controller.dart';
import 'package:rento/models/language_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  Get.lazyPut(() async => await SharedPreferences.getInstance());
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => BottomNavController());
  Get.lazyPut(() => SettingsController());
  Get.lazyPut(() => SearchGetController());
  Get.lazyPut(
    () => ChatController(),
  );
  Map<String, Map<String, String>> _languages = Map();
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle.loadString(
        'assets/translations/${languageModel.languageCode}-${languageModel.countryCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);

    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });

    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return _languages;
}
