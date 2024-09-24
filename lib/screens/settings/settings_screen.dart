import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rento/constants/app_constants.dart';
import 'package:rento/constants/app_localization_util.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/constants/font_manager.dart';
import 'package:rento/constants/space_constants.dart';
import 'package:rento/controllers/language_controller.dart';
import 'package:rento/controllers/login_controller.dart';
import 'package:rento/helpers/routes.dart';
import 'package:rento/widgets/custom_bottom_navbar.dart';
import 'package:rento/widgets/custom_button.dart';
import 'package:rento/widgets/custom_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: ColorCodes.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  AppLocalizationUtil.getTranslatedString("profile"),
                  style: FontManager().getTextStyle(context,
                      fontSize: 32,
                      color: ColorCodes.darkGreyTextColor,
                      lWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 40,
                ),
                FutureBuilder(
                  future: profileRow(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data ?? Container();
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                  color: ColorCodes.black.withOpacity(0.1),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizationUtil.getTranslatedString("settings"),
                  style: FontManager().getTextStyle(context,
                      fontSize: 32,
                      color: ColorCodes.darkGreyTextColor,
                      lWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                settingsRow(
                    context,
                    Icons.abc,
                    AppLocalizationUtil.getTranslatedString(
                        "personalInformation"), () {
                  Get.toNamed(RouteManagement.personalInformation);
                }, image: 'assets/images/home/profile.svg'),
                settingsRow(
                    context,
                    Icons.abc,
                    AppLocalizationUtil.getTranslatedString("favourites"),
                    () {},
                    image: 'assets/images/home/favourite.svg'),
                settingsRow(
                  context,
                  Icons.notifications_none_outlined,
                  AppLocalizationUtil.getTranslatedString("notifications"),
                  () {},
                  // image: 'assets/images/home/profile.svg'
                ),
                settingsRow(
                  context,
                  Icons.verified_outlined,
                  AppLocalizationUtil.getTranslatedString("verification"),
                  () {},
                  // image: 'assets/images/home/profile.svg'
                ),
                settingsRow(
                  context,
                  Icons.help_outline,
                  AppLocalizationUtil.getTranslatedString("helpCenter"),
                  () {},
                  // image: 'assets/images/home/profile.svg'
                ),
                settingsRow(
                  context,
                  Icons.language,
                  AppLocalizationUtil.getTranslatedString("language"),
                  () {
                    language(context);
                  },
                ),
                const Spacer(),
                CustomButton(
                  onTap: () {},
                  text: AppLocalizationUtil.getTranslatedString("logout"),
                  margin: EdgeInsets.zero,
                  bgColor: ColorCodes.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomBottomNavbar(),
              ],
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomBottomNavbar(),
            ],
          )
        ],
      ),
    );
  }

  Future<Widget> profileRow(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userImage = prefs.getString(SharedPrefKeys.userImage);
    String? userName = prefs.getString(SharedPrefKeys.userName);
    return Row(
      children: [
        CircleAvatar(
          radius: 35,
          child: Container(
            width: 150.0,
            height: 150.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CustomImageView(
                  imgHeight: 150,
                  imgFit: BoxFit.cover,
                  imgUrl: Get.find<LoginController>().userImage.isEmpty
                      ? userImage ??
                          'assets/images/onboarding/profile_photo_placeholder.svg'
                      : Get.find<LoginController>().userImage),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Get.find<LoginController>().userName.text.isNotEmpty
                  ? Get.find<LoginController>().userName.text
                  : userName ?? "Milano",
              style: FontManager().getTextStyle(context,
                  fontSize: 16,
                  color: ColorCodes.darkGreyTextColor,
                  lWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizationUtil.getTranslatedString("showProfile"),
              style: FontManager().getTextStyle(context,
                  fontSize: 14,
                  color: ColorCodes.greyTextColor,
                  lWeight: FontWeight.w400),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios_outlined,
                size: 15, color: ColorCodes.black))
      ],
    );
  }

  Widget settingsRow(
    context,
    icon,
    text,
    onTap, {
    String? image,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              image == null
                  ? Icon(
                      icon,
                    )
                  : CustomImageView(imgUrl: image),
              const SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: FontManager().getTextStyle(context,
                    fontSize: 16,
                    color: ColorCodes.darkGreyTextColor,
                    lWeight: FontWeight.w500),
              ),
              const Spacer(),
              const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                    color: ColorCodes.black,
                  ))
            ],
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          Divider(
            indent: 0,
            endIndent: 20,
            color: ColorCodes.black.withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  language(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: ColorCodes.white,
              child: StatefulBuilder(builder: (context, setState) {
                return Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  padding: const EdgeInsets.all(Dimensions.paddingDefault),
                  decoration: BoxDecoration(
                      color: ColorCodes.white,
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusLarge)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                              maintainSize: true,
                              maintainState: true,
                              maintainAnimation: true,
                              visible: false,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.close))),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Language",
                                style: FontManager().getTextStyle(context,
                                    color: ColorCodes.black,
                                    lWeight: FontWeight.w600,
                                    fontSize: 24),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.sizedLarge,
                      ),
                      Row(
                        children: [
                          Text(
                            "Current Language",
                            style: FontManager().getTextStyle(context,
                                color: ColorCodes.black,
                                lWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            width: Dimensions.sizedSmall,
                          ),
                          Text(
                            AppConstants
                                .languages[Get.find<LocalizationController>()
                                    .selectedIndex]
                                .languageName,
                            style: FontManager().getTextStyle(context,
                                color: ColorCodes.black,
                                lWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.sizedLarge,
                      ),
                      Column(
                        children: AppConstants.languages.map(
                          (language) {
                            int index =
                                AppConstants.languages.indexOf(language);
                            return GestureDetector(
                              onTap: () {
                                setState(() {});
                                Get.find<LocalizationController>()
                                    .selectedIndex = index;
                                Get.find<LocalizationController>().setLanguage(
                                    Locale(
                                        AppConstants
                                            .languages[index].languageCode,
                                        AppConstants
                                            .languages[index].countryCode));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: Dimensions.paddingDefault),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   language.languageCode,
                                    //   style: FontManager().getTextStyle(
                                    //       context,
                                    //       color: ColorCodes.black,
                                    //       lWeight: FontWeight.w400,
                                    //       fontSize: 20),
                                    // ),
                                    // const SizedBox(
                                    //   width: Dimensions.sizedSmall,
                                    // ),
                                    // Text(
                                    //   language.countryCode,
                                    //   style: FontManager().getTextStyle(
                                    //       context,
                                    //       color: ColorCodes.black,
                                    //       lWeight: FontWeight.w400,
                                    //       fontSize: 20),
                                    // ),
                                    // const SizedBox(
                                    //   width: Dimensions.sizedSmall,
                                    // ),
                                    Text(
                                      language.languageName,
                                      style: FontManager().getTextStyle(context,
                                          color: ColorCodes.black,
                                          lWeight: FontWeight.w400,
                                          fontSize: 20),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 15,
                                      color: ColorCodes.black,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                );
              }));
        });
  }

}
