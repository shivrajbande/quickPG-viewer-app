import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rento/constants/app_localization_util.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/constants/font_manager.dart';
import 'package:rento/helpers/routes.dart';
import 'package:rento/widgets/custom_button.dart';
import 'package:rento/widgets/custom_image.dart';

class LoginHome extends StatelessWidget {
  const LoginHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCodes.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
                child: CustomImageView(
                    imgUrl: 'assets/images/onboarding/main.svg')),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text:
                          AppLocalizationUtil.getTranslatedString("findTheBest"),
                      style: FontManager().getTextStyle(context,
                          fontSize: 28,
                          lWeight: FontWeight.w600,
                          lineHeight: 1.2),
                    ),
                    TextSpan(
                      text: AppLocalizationUtil.getTranslatedString(
                          "hostelsAndHouses"),
                      style: FontManager().getTextStyle(context,
                          color: ColorCodes.blueColor,
                          fontSize: 28,
                          lWeight: FontWeight.w600,
                          lineHeight: 1.2),
                    ),
                    TextSpan(
                      text: AppLocalizationUtil.getTranslatedString("nearYou"),
                      style: FontManager().getTextStyle(context,
                          fontSize: 28,
                          lWeight: FontWeight.w700,
                          lineHeight: 1.2),
                    )
                  ])),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              AppLocalizationUtil.getTranslatedString("account"),
              textAlign: TextAlign.center,
              style: FontManager().getTextStyle(context,
                  fontSize: 24, lWeight: FontWeight.w600, lineHeight: 1.2),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizationUtil.getTranslatedString("loginAccount"),
              textAlign: TextAlign.center,
              style: FontManager().getTextStyle(context,
                  color: ColorCodes.greyColor,
                  fontSize: 12,
                  lWeight: FontWeight.w400,
                  lineHeight: 1.2),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              onTap: () {
                Get.toNamed(RouteManagement.login);
              },
              text: "login",
              margin: EdgeInsets.zero,
              borderRadius:5,
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                AppLocalizationUtil.getTranslatedString("orContinueWith"),
                textAlign: TextAlign.center,
                style: FontManager().getTextStyle(context,
                    fontSize: 14, lWeight: FontWeight.w400, lineHeight: 1.2),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton2(
                    onTap: () {},
                    text: "google",
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    icon: Icons.abc,
                  ),
                ),
                Expanded(
                  child: CustomButton2(
                    onTap: () {},
                    text: "facebook",
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    icon: Icons.abc,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Divider(
              color: ColorCodes.greyColor,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                    text: AppLocalizationUtil.getTranslatedString("byClicking"),
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
            )
          ],
        ),
      ),
    );
  }
}
