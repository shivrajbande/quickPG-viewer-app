import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';
import 'package:rento/controllers/login_controller.dart';
import 'package:rento/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalInterceptor{
  static Future interceptorGet({required dynamic url, required Map<String, String> headers}){
    return InterceptedHttp.build(interceptors: [AuthInterceptor(), LoggerInterceptor()], retryPolicy: ExpiredTokenRetryPolicy()).get(url,headers: headers);
  }
  
  static Future interceptorPost(
      {required dynamic url,
      required Map<String, String> headers,
      required dynamic body}) {
    return InterceptedHttp.build(
            interceptors: [AuthInterceptor(), LoggerInterceptor()],
            retryPolicy: ExpiredTokenRetryPolicy())
        .post(url, headers: headers, body: body);
  }

  static Future interceptorPut(
      {required dynamic url,
      required Map<String, String> headers,
      required dynamic body}) {
    return InterceptedHttp.build(
            interceptors: [AuthInterceptor(), LoggerInterceptor()],
            retryPolicy: ExpiredTokenRetryPolicy())
        .put(url, headers: headers, body: body);
  }

  static Future interceptorDelete(
      {required dynamic url,
      required Map<String, String> headers,
      required dynamic body}) {
    return InterceptedHttp.build(
            interceptors: [AuthInterceptor(), LoggerInterceptor()],
            retryPolicy: ExpiredTokenRetryPolicy())
        .delete(url, headers: headers, body: body);
  }

}
class LoggerInterceptor implements InterceptorContract {
  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) {
    if (kDebugMode) {
      print("----- Request -----");
      print(request.toString());
    }
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    if (kDebugMode) {
      print("----- Response -----");
      print(response.reasonPhrase);
    }
    return response;
  }

  @override
  bool shouldInterceptRequest() {
    return true; // Ensure this returns true to actually intercept requests
  }

  @override
  bool shouldInterceptResponse() {
    return true; // Ensure this returns true to actually intercept responses
  }
}

class AuthInterceptor implements InterceptorContract {
  final LoginController loginController = Get.find<LoginController>();

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // Add Authorization header
      request.headers["Authorization"] = 'Bearer ${prefs.getString("accessToken")}';
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    return response;
  }

  @override
  bool shouldInterceptRequest() {
    return true; // Ensure this returns true to actually intercept requests
  }

  @override
  bool shouldInterceptResponse() {
    return true; // Ensure this returns true to actually intercept responses
  }
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  final LoginController loginController = Get.find<LoginController>();

  @override
  int get maxRetryAttempts => 3;

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 401) {
      if (kDebugMode) {
        print("Retrying request...");
      }

      // Refresh the token
      var jsonObj = await LoginServices().getRefreshToken();
      loginController.updateAccessToken = jsonObj["accessToken"];
      loginController.updateRefreshToken = jsonObj["refreshToken"];
      loginController.updateAccessTokenExpiry = jsonObj["accessTokenExpiry"];
      loginController.updateRefreshTokenExpiry = jsonObj["refreshTokenExpiry"];

      prefs.setString("accessToken", jsonObj["accessToken"]);
      prefs.setString("refreshToken", jsonObj["refreshToken"]);
      prefs.setString("accessTokenExpiry", jsonObj["accessTokenExpiry"]);
      prefs.setString("refreshTokenExpiry", jsonObj["refreshTokenExpiry"]);
      prefs.setString("uidID", jsonObj["uidID"]);
      return true;
    }
    return false;
  }

  // @override
  // bool shouldAttemptRetryOnException(Exception reason) {
  //   return false; // Handle retry on exceptions if needed
  // }
}
