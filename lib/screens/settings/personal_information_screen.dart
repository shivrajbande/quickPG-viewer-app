import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rento/constants/app_localization_util.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/constants/font_manager.dart';
import 'package:rento/controllers/settings_controller.dart';
import 'package:rento/widgets/custom_bottom_navbar.dart';
import 'package:rento/widgets/custom_button.dart';
import 'package:rento/widgets/custom_textfield.dart';

class PersonalInformationScreen extends StatelessWidget {
  PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCodes.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      CustomIconButton(
                        onTap: () {
                          Get.back();
                        },
                        icon: Icons.arrow_back_ios_new,
                        bgColor: ColorCodes.iconBgColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        iconSize: 15,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        AppLocalizationUtil.getTranslatedString(
                            "personalInformation"),
                        style: FontManager().getTextStyle(context,
                            fontSize: 18,
                            color: ColorCodes.black,
                            lWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Obx(
                    () => piItem(context, "legalName", "Mike", "enterFullName",
                        () {
                      Get.find<SettingsController>().activeIndex = 0;
                    }, () {
                      Get.find<SettingsController>().activeIndex = -1;
                    },
                        0,
                        Get.find<SettingsController>().activeIndex,
                        Get.find<SettingsController>().fullNameController,
                        true),
                  ),
                  Obx(
                    () => piItem(
                        context, "phoneNumber", "987654321", "enterPhoneNumber",
                        () {
                      Get.find<SettingsController>().activeIndex = 1;
                    }, () {
                      Get.find<SettingsController>().activeIndex = -1;
                    },
                        1,
                        Get.find<SettingsController>().activeIndex,
                        Get.find<SettingsController>().phoneNumberController,
                        true),
                  ),
                  Obx(
                    () => piItem(
                        context, "email", "random@gmail.com", "enterEmail", () {
                      Get.find<SettingsController>().activeIndex = 2;
                    }, () {
                      Get.find<SettingsController>().activeIndex = -1;
                    },
                        2,
                        Get.find<SettingsController>().activeIndex,
                        Get.find<SettingsController>().emailController,
                        true),
                  ),
                  Obx(
                    () => piItem(
                        context, "address", "notProvided", "enterFullAddress",
                        () {
                      Get.find<SettingsController>().activeIndex = 3;
                    }, () {
                      Get.find<SettingsController>().activeIndex = -1;
                    },
                        3,
                        Get.find<SettingsController>().activeIndex,
                        Get.find<SettingsController>().addressController,
                        false),
                  ),
                  Obx(
                    () => piItem(context, "idProof", "notProvided", "idProof",
                        () {
                      Get.find<SettingsController>().activeIndex = 4;
                    }, () {
                      Get.find<SettingsController>().activeIndex = -1;
                    },
                        4,
                        Get.find<SettingsController>().activeIndex,
                        Get.find<SettingsController>().idProofController,
                        false),
                  ),
                  CustomBottomNavbar(),
                ],
              ),
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

  Widget piItem(context, text, value, value2, editTap, cancelTap, index,
      activeIndex, controller, isEdit) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: ColorCodes.white,
          border: Border.all(color: ColorCodes.greyBr),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 4,
                color: ColorCodes.black.withOpacity(0.15))
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              index != activeIndex
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizationUtil.getTranslatedString(text),
                          style: FontManager().getTextStyle(context,
                              fontSize: 22,
                              color: ColorCodes.black,
                              lWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          value,
                          style: FontManager().getTextStyle(context,
                              fontSize: 20,
                              color: ColorCodes.black,
                              lWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizationUtil.getTranslatedString(text),
                          style: FontManager().getTextStyle(context,
                              fontSize: 22,
                              color: ColorCodes.black,
                              lWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppLocalizationUtil.getTranslatedString(value2),
                          style: FontManager().getTextStyle(context,
                              fontSize: 20,
                              color: ColorCodes.black,
                              lWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
              index != activeIndex
                  ? CustomButton(
                      width: 100,
                      margin: EdgeInsets.zero,
                      onTap: editTap,
                      text: isEdit ? "edit" : "add",
                      bgColor: ColorCodes.white,
                      textColor: ColorCodes.black,
                      fontWeight: FontWeight.w600,
                      borderRadius: 50,
                      border: Border.all(color: ColorCodes.greyBr, width: 2),
                    )
                  : CustomButton(
                      width: 100,
                      margin: EdgeInsets.zero,
                      onTap: cancelTap,
                      text: "cancel",
                      bgColor: ColorCodes.white,
                      textColor: ColorCodes.black,
                      fontWeight: FontWeight.w600,
                      borderRadius: 50,
                      border: Border.all(color: ColorCodes.greyBr, width: 2),
                    ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (index == activeIndex)
            CustomTextField(
              controller: controller,
              enabled: true,
              focusColor: ColorCodes.black,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: ColorCodes.black, width: 2)),
              focusBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: ColorCodes.black, width: 2)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: ColorCodes.black, width: 2)),
            )
        ],
      ),
    );
  }
}
