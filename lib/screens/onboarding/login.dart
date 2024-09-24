import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:rento/constants/app_constants.dart';
import 'package:rento/constants/app_localization_util.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/constants/font_manager.dart';
import 'package:rento/controllers/login_controller.dart';
import 'package:rento/helpers/routes.dart';
import 'package:rento/services/login_service.dart';
import 'package:rento/widgets/custom_button.dart';
import 'package:rento/widgets/custom_image.dart';
import 'package:rento/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  LoginServices loginServices = LoginServices();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorCodes.white,
          resizeToAvoidBottomInset: true,
          body: PopScope(
            canPop: controller.canPop,
            onPopInvoked: (didPop) {
              controller.isOtpSent = false;
              controller.canPop = true;
            },
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                  child: Obx(() =>
                  controller.isOtpSent ? phase2(context) : phase1(context))),
            ),
          ),
        );
      },
    );
  }

  Widget phase1(context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const Center(
                    child: CustomImageView(
                        imgUrl: 'assets/images/onboarding/login.svg')),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  AppLocalizationUtil.getTranslatedString("login"),
                  textAlign: TextAlign.center,
                  style: FontManager().getTextStyle(context,
                      fontSize: 24, lWeight: FontWeight.w600, lineHeight: 1.2),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizationUtil.getTranslatedString(
                      "enterMobileNumberToLogin"),
                  textAlign: TextAlign.center,
                  style: FontManager().getTextStyle(context,
                      color: ColorCodes.black,
                      fontSize: 16,
                      lWeight: FontWeight.w400,
                      lineHeight: 1.2),
                ),
                TextFormField(
                  controller: Get
                      .find<LoginController>()
                      .mobileNumber,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      label: Text(
                        AppLocalizationUtil.getTranslatedString(
                            "digitMobileNumber"),
                        style: FontManager().getTextStyle(context),
                      ),
                      prefixText: "+91 ",
                      prefixStyle: FontManager().getTextStyle(context,
                          color: ColorCodes.black, fontSize: 16),
                      hintText: "9876543211",
                      hintStyle: FontManager().getTextStyle(context,
                          color: ColorCodes.greyColor, fontSize: 16)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Get
                    .find<LoginController>()
                    .isLoading
                    ? CustomButton(
                  onTap: null,
                  text: "Continue",
                  widget: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          color: ColorCodes.white,
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.zero,
                  borderRadius: 5,
                  // bgColor: Colors.black,
                )
                    :
                CustomButton(
                  onTap: () async {
                    // print(Get.find<LoginController>().mobileNumber.text.length);
                    if (Get
                        .find<LoginController>()
                        .mobileNumber
                        .text
                        .length ==
                        10) {
                      //send otp to the phone number and open phase-2
                      // Get.find<LoginController>().isOtpSent = true;
                      loginServices.sendOtpPhoneNumber();
                    } else {
                      CustomSnackBar()
                          .errorSnackBar("Error", "Enter Valid number");
                    }
                  },
                  text: "Continue",
                  margin: EdgeInsets.zero,
                  borderRadius: 5,
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text:
                        AppLocalizationUtil.getTranslatedString("byClicking"),
                        style: FontManager().getTextStyle(context,
                            color: ColorCodes.greyColor,
                            fontSize: 11,
                            lWeight: FontWeight.w600,
                            lineHeight: 1.2),
                      ),
                      TextSpan(
                        text: AppLocalizationUtil.getTranslatedString(
                            "termsConditions"),
                        style: FontManager().getTextStyle(context,
                            color: ColorCodes.black,
                            fontSize: 11,
                            lWeight: FontWeight.w600,
                            lineHeight: 1.2),
                      ),
                      TextSpan(
                        text: AppLocalizationUtil.getTranslatedString("and"),
                        style: FontManager().getTextStyle(context,
                            color: ColorCodes.greyColor,
                            fontSize: 11,
                            lWeight: FontWeight.w700,
                            lineHeight: 1.2),
                      ),
                      TextSpan(
                        text: AppLocalizationUtil.getTranslatedString(
                            "privacyPolicy"),
                        style: FontManager().getTextStyle(context,
                            color: ColorCodes.black,
                            fontSize: 11,
                            lWeight: FontWeight.w600,
                            lineHeight: 1.2),
                      ),
                    ])),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget phase2(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            IconButton(
                onPressed: () =>
                Get
                    .find<LoginController>()
                    .isOtpSent = false,
                icon: const Icon(Icons.arrow_back)),
            const SizedBox(
              width: 10,
            ),
            Text(
              AppLocalizationUtil.getTranslatedString("enterVerificationCode"),
              style: FontManager().getTextStyle(context,
                  fontSize: 16, lWeight: FontWeight.w600, lineHeight: 1.2),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                AppLocalizationUtil.getTranslatedString("weHaveSent"),
                textAlign: TextAlign.center,
                style: FontManager().getTextStyle(context,
                    fontSize: 22, lWeight: FontWeight.w400, lineHeight: 1.2),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "+91- ${Get
                    .find<LoginController>()
                    .mobileNumber
                    .text}",
                style: FontManager().getTextStyle(context,
                    fontSize: 22, lWeight: FontWeight.w400, lineHeight: 1.2),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 100.0,
                child: GestureDetector(
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content:
                            Text("Paste clipboard stuff into the pinbox?"),
                            actions: <Widget>[
                              // FlatButton(
                              //     onPressed: () async {
                              //       var copiedText =
                              //       await Clipboard.getData("text/plain");
                              //       if (copiedText!.text!.isNotEmpty) {
                              //         controller.text = copiedText.text;
                              //       }
                              //       Navigator.of(context).pop();
                              //     },
                              //     child: Text("YES")),
                              // FlatButton(
                              //     onPressed: () {
                              //       Navigator.of(context).pop();
                              //     },
                              //     child: Text("No"))
                            ],
                          );
                        });
                  },
                  child: PinCodeTextField(
                    autofocus: true,
                    controller: Get
                        .find<LoginController>()
                        .otpPin,
                    // hideCharacter: true,
                    highlight: true,
                    highlightColor: ColorCodes.blueColor,
                    defaultBorderColor: ColorCodes.greyBr,
                    // hasTextBorderColor: Colors.green,
                    // highlightPinBoxColor: Colors.orange,
                    maxLength: 6,
                    hasError: false,
                    // maskCharacter: "😎",
                    onTextChanged: (text) {},
                    onDone: (text) {
                      print("DONE $text");
                      print(
                          "DONE CONTROLLER ${Get
                              .find<LoginController>()
                              .otpPin
                              .text}");
                    },
                    pinBoxWidth: 45,
                    pinBoxHeight: 45,
                    // hasUnderline: true,
                    wrapAlignment: WrapAlignment.spaceAround,
                    pinBoxDecoration:
                    ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                    pinTextStyle: const TextStyle(fontSize: 22.0),
                    pinTextAnimatedSwitcherTransition:
                    ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                    pinTextAnimatedSwitcherDuration:
                    const Duration(milliseconds: 300),
//                    highlightAnimation: true,
                    highlightAnimationBeginColor: Colors.black,
                    highlightAnimationEndColor: Colors.white12,
                    keyboardType: TextInputType.number,
                    pinBoxRadius: 8,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Get
                  .find<LoginController>()
                  .isLoading
                  ? CustomButton(
                onTap: null,
                text: "Continue",
                widget: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        color: ColorCodes.white,
                      ),
                    ),
                  ],
                ),
                margin: EdgeInsets.zero,
                borderRadius: 5,
                // bgColor: Colors.black,
              ):
              CustomButton(
                onTap: () {
                  //validate phonenumber with otp sent
                  loginServices.validateOtpSent();
                },
                text: "login",
                margin: EdgeInsets.zero,
                borderRadius: 5,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizationUtil.getTranslatedString(
                                "didntOTP?"),
                            style: FontManager().getTextStyle(context,
                                color: ColorCodes.black,
                                fontSize: 11,
                                lWeight: FontWeight.w600,
                                lineHeight: 1.2),
                          ),
                          TextSpan(
                            text: AppLocalizationUtil.getTranslatedString(
                                "resendSMS"),
                            style: FontManager().getTextStyle(context,
                                color: ColorCodes.blueColor,
                                fontSize: 11,
                                lWeight: FontWeight.w600,
                                lineHeight: 1.2),
                            // recognizer: Get.find<LoginController>().resendTapRecognizer,
                          ),
                        ])),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )
      ],
    );
  }
}
