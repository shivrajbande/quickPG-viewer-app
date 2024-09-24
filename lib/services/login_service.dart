import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rento/constants/app_constants.dart';
import 'package:rento/controllers/login_controller.dart';
import 'package:rento/helpers/routes.dart';
import 'package:rento/services/interceptor.dart';
import 'package:rento/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LoginController loginController = Get.find<LoginController>();

  Future<void> sendOtpPhoneNumber() async {
    String? mobileNumber = Get.find<LoginController>().mobileNumber.text;
    mobileNumber = "+91$mobileNumber";

    try {
      Get.find<LoginController>().isLoading = true;
      final Map<String, dynamic> requestBody = {
        "phoneNumber": mobileNumber,
      };

      String uri = "${AppEnvironment.apiEnv}${APIStore.registerUser}";

      var header = {
        "Content-Type": "application/json",
      };

      var response = await LocalInterceptor.interceptorPost(
        url: Uri.parse(uri),
        body: jsonEncode(requestBody),
        headers: header,
      );

      // // Send the token to the server
      // var response = await http.post(
      //   Uri.parse(uri),
      //   headers: header,
      //   body: jsonEncode(requestBody),
      // );
      if (response.statusCode == 201) {
        Get.find<LoginController>().isOtpSent = true;
      }
    } catch (error) {
      print("error is $error");
    } finally {
      Get.find<LoginController>().isLoading = false;
    }
  }

  Future<void> validateOtpSent() async {
    // final FirebaseAuth auth = FirebaseAuth.instance;

    String smsCode = Get.find<LoginController>().otpPin.text.trim();
    String? mobileNumber = Get.find<LoginController>().mobileNumber.text;
    mobileNumber = "+91$mobileNumber";

    try {
      Get.find<LoginController>().isLoading = true;
      final Map<String, dynamic> requestBody = {
        'phoneNumber': mobileNumber,
        'otp': smsCode,
      };

      String uri = "${AppEnvironment.apiEnv}${APIStore.verifyuser}";

      var header = {
        "Content-Type": "application/json",
      };
      var response = await http.post(
        Uri.parse(uri),
        headers: header,
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body)['data'];
        Get.find<LoginController>().existingUser = data['existingUser'];
        final customToken = data['token'];
        await signInWithCustomToken(customToken, data['existingUser']);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      CustomSnackBar().errorSnackBar("Error", "Enter Valid OTP");
      print('Failed to sign in: $e');
    } finally {
      Get.find<LoginController>().isLoading = false;
    }
  }

  Future<void> _resendVerificationCode() async {
    sendOtpPhoneNumber();
  }

  Future getRefreshToken() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var requestBody = {
        "refreshToken": prefs.getString(APIResponseKeys.refreshToken),
      };

      // Send the token to the server
      var response = await http.post(
        Uri.parse("${AppEnvironment.apiEnv}${APIStore.refreshToken}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        var jsonObj = jsonDecode(response.body);

        return jsonObj;
      } else if (response.statusCode == 403) {
        loginController.otpPin = TextEditingController();
      }
    } catch (e) {
      CustomSnackBar().errorSnackBar("Error", "Enter Valid OTP");
      print('Failed to sign in: $e');
    }
  }

  Future<void> signInWithCustomToken(
      String customToken, bool? existingUser) async {
    // print("custom token is $customToken");

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCustomToken(customToken);
      User? user = userCredential.user;
      // print(user!.uid);
      verifyToken(customToken, user?.uid, existingUser);
    } catch (e) {
      print("Error signing in with custom token: $e");
    }
  }

  Future<void> verifyToken(String? tokenID, uid, bool? existingUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //if token then user exist in firebase
    final Map<String, dynamic> requestBody = {
      "token": tokenID,
      "phoneNumber": Get.find<LoginController>().mobileNumber.text,
      "uid": uid
    };

    // Send the token to the server
    var response = await http.post(
      Uri.parse("${AppEnvironment.apiEnv}${APIStore.verifyToken}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );
    try {
      if (response.statusCode == 201) {
        var jsonObj = jsonDecode(response.body);
        //save uid, accessToke, refreshToken, expiryTimes in controller and then navigate to onboarding page
        loginController.updateAccessToken =
            jsonObj[APIResponseKeys.accessToken];
        loginController.updateRefreshToken =
            jsonObj[APIResponseKeys.refreshToken];
        loginController.updateAccessTokenExpiry =
            jsonObj[APIResponseKeys.accessTokenExpiry];
        loginController.updateRefreshTokenExpiry =
            jsonObj[APIResponseKeys.refreshTokenExpiry];

        prefs.setString(SharedPrefKeys.uidID, uid);
     

        // print("chat id is ${jsonObj[ APIResponseKeys.chatID]}");

        prefs.setString(
            SharedPrefKeys.accessToken, jsonObj[APIResponseKeys.accessToken]);
        prefs.setString(
            SharedPrefKeys.refreshToken, jsonObj[APIResponseKeys.refreshToken]);
        prefs.setString(SharedPrefKeys.accessTokenExpiry,
            jsonObj[APIResponseKeys.accessTokenExpiry]);
        prefs.setString(SharedPrefKeys.refreshTokenExpiry,
            jsonObj[APIResponseKeys.refreshTokenExpiry]);
        prefs.setBool(SharedPrefKeys.isLoggedIn, true);
        CustomSnackBar().successSnackBar("Success", "Successfully logged in");
        (prefs.getBool(SharedPrefKeys.isFirstTimeLoggedIn) ?? true)
            ? Get.offNamed(RouteManagement.profileInfo)
            : Get.offNamed(RouteManagement.home);
        prefs.setBool(SharedPrefKeys.isFirstTimeLoggedIn, false);
        // Get.offNamed(RouteManagement.profileInfo);
      } else if (response.statusCode == 403) {
        loginController.otpPin.clear();
        CustomSnackBar().errorSnackBar("Error", "User authentication failed");
        print(response.statusCode);
      }
    } catch (error) {
      print("error is $error");
    }
  }

  void pickPhotoFromGallery() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      String fileName = image.name;

      try {
        // Get.find<ListingController>().isLoading = true;
        String fileName =
            'uploads/images/${DateTime.now().millisecondsSinceEpoch}_${image.name}';
        Reference ref = FirebaseStorage.instance.ref().child(fileName);
        await ref.putFile(file);
        String downloadURL = await ref.getDownloadURL();
        Get.find<LoginController>().userImage = downloadURL;
      } catch (error) {
        print("error while fetching image");
      }
    }
  }

  Future<void> createuserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(SharedPrefKeys.uidID);
    String? accessToken = prefs.getString(SharedPrefKeys.accessToken);
    // Get.find<ListingController>().isLoading = true;
    String? imageURL = Get.find<LoginController>().userImage;
    prefs.setString(
        SharedPrefKeys.userName, Get.find<LoginController>().userName.text);
    prefs.setString(
        SharedPrefKeys.userImage, Get.find<LoginController>().userImage);
    print(accessToken);
    if (imageURL.isNotEmpty) {
      try {
        Get.find<LoginController>().isLoading = true;
        final Map<String, dynamic> requestBody = {
          'userImage': imageURL,
          'userName': Get.find<LoginController>().userName.text,
          'uid': uid,
        };
        var header = {
          "Content-Type": "application/json",
          'authorization': 'Bearer ${accessToken}'
        };

        String uri = "${AppEnvironment.apiEnv}${APIStore.createProfile}";

        var response = await http.post(Uri.parse(uri),
            body: jsonEncode(requestBody), headers: header);
        if (response.statusCode == 201) {
          var jsonObj = jsonDecode(response.body);

          // print(jsonObj['chatID']);
          //no snackbar just add without any change in user
          // CustomSnackBar().successSnackBar("Success", "Successfully logged in");
          // Get.toNamed(RouteManagement.onboarding);

          // prefs.setString(SharedPrefKeys.chatID, jsonObj[APIResponseKeys.chatID]);
          // print("chat id is ${}");
         

          prefs.setString(SharedPrefKeys.senderChatId,jsonObj['chatID']);
          Get.toNamed(RouteManagement.onboarding);
        } else if (response.statusCode == 403) {
          // CustomSnackBar().successSnackBar("Success", "Successfully logged in");
        }
      } catch (e) {
        CustomSnackBar().errorSnackBar("Error", "Enter Valid OTP");
        print('Failed to sign in: $e');
      } finally {
        Get.find<LoginController>().isLoading = false;
      }
    } else {
      print("no image selected");
    }
  }

  Future<String> getSenderChatID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(SharedPrefKeys.uidID);
    String? accessToken = prefs.getString(SharedPrefKeys.accessToken);
    String? result = '';

    try {
      var header = {
        "Content-Type": "application/json",
        'authorization': 'Bearer ${accessToken}'
      };

      String uri = "${AppEnvironment.apiEnv}${APIStore.getChatId}${uid}";

      var response = await http.get(Uri.parse(uri), headers: header);
      if (response.statusCode == 201) {
        var jsonObj = jsonDecode(response.body);
        result = jsonObj['chatId'];

        Get.toNamed(RouteManagement.onboarding);
      } else if (response.statusCode == 403) {
        // CustomSnackBar().successSnackBar("Success", "Successfully logged in");
      }
    } catch (e) {
      CustomSnackBar().errorSnackBar("Error", "Enter Valid OTP");
      print('Failed to sign in: $e');
    } finally {
      Get.find<LoginController>().isLoading = false;
    }
    return result ?? "";
  }

}
