import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rento/constants/app_localization_util.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/constants/font_manager.dart';
import 'package:rento/controllers/login_controller.dart';
import 'package:rento/helpers/routes.dart';
import 'package:rento/widgets/custom_button.dart';
import 'package:rento/widgets/custom_image.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCodes.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(
            () => Get.find<LoginController>().onboardingValue == 0
                ? onboardingPage(
                    context,
                    "findBestPlace",
                    "goodPrice",
                    "loremIpsum",
                    "assets/images/onboarding/onboarding1.png", () {
                    Get.find<LoginController>().onboardingValue = 1;
                  })
                : onboardingPage(
                    context,
                    "findBestHostels",
                    "oneClick",
                    "loremIpsum",
                    "assets/images/onboarding/onboarding2.png",
                    () => Get.toNamed(RouteManagement.home)),
          )),
    );
  }

  Widget onboardingPage(context, title1, title2, subtitle, image, onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () => Get.toNamed(RouteManagement.home),
              child:
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                decoration: BoxDecoration(
                    color: ColorCodes.white,
                    border: Border.all(color: ColorCodes.greyBr,width: 2),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  AppLocalizationUtil.getTranslatedString("skip"),
                  style: FontManager().getTextStyle(context,
                      color: ColorCodes.black,
                      fontSize: 18,
                      lWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: AppLocalizationUtil.getTranslatedString(title1),
              style: FontManager().getTextStyle(context,
                  color: ColorCodes.indigoColor,
                  fontSize: 24,
                  lWeight: FontWeight.w500,
                  lineHeight: 1.2)),
          TextSpan(
              text: AppLocalizationUtil.getTranslatedString(title2),
              style: FontManager().getTextStyle(context,
                  color: ColorCodes.blueColor,
                  fontSize: 24,
                  lWeight: FontWeight.w600,
                  lineHeight: 1.2))
        ])),
        const SizedBox(
          height: 20,
        ),
        Text(AppLocalizationUtil.getTranslatedString(subtitle),
            style: FontManager().getTextStyle(context,
                color: ColorCodes.greyColor,
                fontSize: 16,
                lWeight: FontWeight.w400,
                lineHeight: 1.2)),
        const Spacer(),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomImageView(imgUrl: image),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Get.find<LoginController>().onboardingValue == 0
                  ? CustomButton(
                      onTap: onTap,
                      text: "next",
                      bgColor: ColorCodes.yellowColor,
                      textColor: ColorCodes.black,
                    )
                  : Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => Get.find<LoginController>()
                                    .onboardingValue =
                                Get.find<LoginController>().onboardingValue - 1,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                  color: ColorCodes.white,
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Icon(Icons.arrow_back),
                            ),
                          ),
                          Expanded(
                            child: CustomButton(
                              onTap: onTap,
                              text: "next",
                              bgColor: ColorCodes.yellowColor,
                              textColor: ColorCodes.black,
                            ),
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      ],
    );
  }
}
