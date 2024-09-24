import 'package:get/get.dart';
import 'package:rento/screens/chats/chat.dart';
import 'package:rento/screens/chats/chatsList.dart';
import 'package:rento/screens/home/home_screen.dart';
import 'package:rento/screens/onboarding/initial_screen.dart';
import 'package:rento/screens/onboarding/login.dart';
import 'package:rento/screens/onboarding/login_home.dart';
import 'package:rento/screens/onboarding/onboarding.dart';
import 'package:rento/screens/onboarding/profile_infor.dart';
import 'package:rento/screens/onboarding/splash_screen.dart';
import 'package:rento/screens/search/search_screen.dart';
import 'package:rento/screens/settings/personal_information_screen.dart';
import 'package:rento/screens/settings/settings_screen.dart';

class RouteManagement {
  static const String initial = '/';
  static const String loginHome = '/loginHome';
  static const String login = '/login';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String splash = '/splash';
  static const String settings = '/settings';
  static const String personalInformation = '/personalInformation';
  static const String search = '/search';
  static const String chat = '/chat';
  static const String chatList = '/chatList';
   static const String profileInfo = '/profileInfo';

  static List<GetPage> routes = [
    GetPage(
        name: splash,
        page: () => SplashScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: initial,
        page: () => InitialScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: loginHome,
        page: () => LoginHome(),
        transition: Transition.noTransition),
    GetPage(
        name: login, page: () => Login(), transition: Transition.noTransition),
    GetPage(
        name: onboarding,
        page: () => Onboarding(),
        transition: Transition.noTransition),
    GetPage(
        name: home,
        page: () => HomeScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: settings,
        page: () => SettingsScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: personalInformation,
        page: () => PersonalInformationScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: search,
        page: () => SearchScreen(),
        transition: Transition.noTransition),
    GetPage(name: chat, page: () => ChatScreen()),

    GetPage(name: chatList, page: () => ChatsList(),),
        GetPage(name: profileInfo, page: () => ProfileInfo(),transition: Transition.noTransition),
  ];
}
