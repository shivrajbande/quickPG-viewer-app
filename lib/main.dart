import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rento/constants/app_constants.dart';
import 'package:rento/constants/messages.dart';
import 'package:rento/controllers/language_controller.dart';
import 'package:rento/firebase_options.dart';
import 'package:rento/helpers/routes.dart';
import 'package:rento/helpers/get_lp.dart' as lp;
import 'dart:io' show Platform;

import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  // self.FIREBASE_APPCHECK_DEBUG_TOKEN = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //     await FirebaseAppCheck.instance.activate(
  //     androidProvider: AndroidProvider.debug,
  //     appleProvider: AppleProvider.debug,
  //     webProvider:
  //         ReCaptchaV3Provider(''),
  //   );

  if (!kDebugMode) {
    print("in debug mode");

  //   await FirebaseAppCheck.instance.activate(
  //     androidProvider: AndroidProvider.playIntegrity,
  //     appleProvider: AppleProvider.appAttest,
  //     // webProvider:
  //     //     ReCaptchaV3Provider('8ac45f7af243da222445c891a800ae8027bf6c'),
  //   );
  // } else {

  //   await FirebaseAppCheck.instance.activate(
  //     androidProvider: AndroidProvider.debug,
  //     appleProvider: AppleProvider.debug,
  //     webProvider:
  //         ReCaptchaV3Provider('Andriod Debug Token'),
  //   );
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, Map<String, String>> languages = await lp.init();
  runApp(MyApp(languages: languages,prefs: prefs,));
}

class MyApp extends StatelessWidget {
  MyApp({required this.languages,required this.prefs});
  final Map<String, Map<String, String>> languages;
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return GetMaterialApp(
        initialRoute:
        // RouteManagement.chat,
        (prefs.getBool(SharedPrefKeys.isLoggedIn) ?? false)
            ? RouteManagement.home
            : RouteManagement.initial,
        getPages: RouteManagement.routes,
        debugShowCheckedModeBanner: false,
        locale: localizationController.locale,
        translations: Messages(languages: languages),
        fallbackLocale: Locale(AppConstants.languages[0].languageCode,
            AppConstants.languages[0].countryCode),
        title: 'Rento',
      );
    });
  }
}
