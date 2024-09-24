import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:rento/constants/app_constants.dart';
import 'package:rento/helpers/routes.dart';
import 'package:rento/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController implements GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController mobileNumber = TextEditingController(text: "");
  final RxBool _isOtpSent = false.obs;
  final RxBool _canPop = false.obs;
  final RxInt _onboardingValue = 0.obs;
  TextEditingController otpPin = TextEditingController(text: "");
  final RxString _accessToken = RxString("");
  final RxString _refreshToken = RxString("");
  final RxString _accessTokenExpiry = RxString("");
  final RxString _refreshTokenExpiry = RxString("");
  final RxString _verificationCode = RxString("");
  final RxString _userName = "".obs;
  final TextEditingController userName = TextEditingController(text: "");
  final RxString _userImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSVTHYYxwbqYiehx33YQzoHdahZ4nCdDNigw&s".obs;
  final RxBool _isLoading = false.obs;
  final RxBool _existingUser = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // resendTapRecognizer = TapGestureRecognizer()
    //   ..onTap = _resendVerificationCode;
  }

  @override
  void dispose() {
    // resendTapRecognizer.dispose();
    super.dispose();
  }

  bool get isOtpSent => _isOtpSent.value;
  bool get canPop => _canPop.value;
  int get onboardingValue => _onboardingValue.value;

  String get accessToken => _accessToken.value;
  String get refreshToken => _refreshToken.value;
  String get accessTokenExpiry => _accessTokenExpiry.value;
  String get refreshTokenExpiry => _refreshTokenExpiry.value;
  String get verificationCode => _verificationCode.value;
  String get userImage => _userImage.value;
  bool get isLoading => _isLoading.value;
  bool get existingUser => _existingUser.value;

  set isOtpSent(value) => _isOtpSent.value = value;
  set canPop(value) => _canPop.value = value;
  set onboardingValue(value) => _onboardingValue.value = value;
  set updateAccessToken(value) => _accessToken.value = value;
  set updateRefreshToken(value) => _accessToken.value = value;
  set updateAccessTokenExpiry(value) => _accessToken.value = value;
  set updateRefreshTokenExpiry(value) => _accessToken.value = value;
  set updateVerificationCode(value) => _verificationCode.value = value;
  set resetOTPField(value) => otpPin.value = value;
  set userName(value) => _userName.value = value;
  set userImage(value) => _userImage.value = value;
  set isLoading(value) => _isLoading.value= value;
  set existingUser(value) => _existingUser.value = value;

}
