import 'package:rento/models/language_model.dart';

class AppConstants {
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
      languageName: 'Telugu',
      countryCode: 'IN',
      languageCode: 'te',
    ),
    LanguageModel(
      languageName: 'Hindi',
      countryCode: 'IN',
      languageCode: 'hi',
    ),
  ];
}

class AppEnvironment {
//  static const String apiEnv = "https://rento-backend-3hwp.onrender.com";
  static const String apiEnv = "http://localhost:3000";
}

class SharedPrefKeys {
  static const String accessToken = "AccessToken";
  static const String refreshToken = "RefreshToken";
  static const String accessTokenExpiry = "TokenExpiry";
  static const String refreshTokenExpiry = "RefreshTokenExpiry";
  static const String uidID = "uid";
  static const String pid = 'pid';
  static const String isFirstTimeLoggedIn = 'IsFirstTimeLoggedIn';
  static const String senderChatId = "senderChatId";
  static const String userImage = "UserImage";
  static const String userName = "UserName";
  static const String isLoggedIn = "IsLoggedIn";
}

class APIResponseKeys {
  static const String accessToken = "accessToken";
  static const String refreshToken = "refreshToken";
  static const String accessTokenExpiry = "tokenExpiry";
  static const String refreshTokenExpiry = "refreshTokenExpiry";
  static const String uidID = "uid";
  static const String pid = 'pid';
  static const String chatID = "chatID";
}

class APIStore {
  static const String verifyToken = "/viewer/profile/verifyToken";
  static const String registerUser = "/viewer/profile/registerUser";
  static const String verifyuser = "/viewer/profile/verifyuser";
  static const String createProfile = "/viewer/profile/createProfile";
  static const String getProperties = "/viewer/property/getAllProperties";
  static const String filterOptions = "/viewer/property/filterOptions";
  static const String searchProperties = "/viewer/property/searchHostel";
  static const String refreshToken = "/viewer/profile/refreshToken";
  static const String getChatId = "/viewer/profile/getChatId/";
  static const String getUserChats = "/owmer/profile/chats/";
}
