import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rento/constants/app_localization_util.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/constants/font_manager.dart';
import 'package:rento/helpers/routes.dart';
import 'package:rento/widgets/custom_button.dart';
import 'package:rento/widgets/custom_image.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCodes.white,
      body: Column(
        children: [
          const CustomImageView(imgUrl: 'assets/images/onboarding/initial.png'),
          const SizedBox(height: 20,),
          Text(
            AppLocalizationUtil.getTranslatedString(
                "discoverHomeWhereYourStoryBegins"),
            textAlign: TextAlign.center,
            style: FontManager()
                .getTextStyle(context, fontSize: 28, lWeight: FontWeight.w500,lineHeight: 1.2),
          ),
          const SizedBox(height: 20,),
          Text(
            AppLocalizationUtil.getTranslatedString(
                "unlockYourDreamHome"),
            textAlign: TextAlign.center,
            style: FontManager()
                .getTextStyle(context, fontSize: 16, lWeight: FontWeight.w400,lineHeight: 1.2),
          ),
          const SizedBox(height: 40,),
          CustomButton(onTap: (){
            Get.toNamed(RouteManagement.loginHome);
          }, text: "explore")
        ],
      ),
    );
  }
}
