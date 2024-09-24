import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rento/constants/app_localization_util.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/constants/font_manager.dart';
import 'package:rento/constants/space_constants.dart';
import 'package:rento/controllers/login_controller.dart';
import 'package:rento/helpers/routes.dart';
import 'package:rento/services/login_service.dart';
import 'package:rento/widgets/custom_button.dart';
import 'package:rento/widgets/custom_image.dart';
import 'package:rento/widgets/custom_textfield.dart';
import 'package:rento/widgets/snackbar.dart';

class ProfileInfo extends StatelessWidget {
  ProfileInfo({super.key});

  final LoginServices profileService = LoginServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCodes.white,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Dimensions.sidePadding),
          child: Column(
            children: [
              const SizedBox(
                height: Dimensions.initialHeight,
              ),
              Text(
                AppLocalizationUtil.getTranslatedString("profileInfo"),
                style: FontManager().getTextStyle(context,
                    fontSize: 24,
                    color: ColorCodes.black,
                    lWeight: FontWeight.w600,
                    lineHeight: 1.2),
              ),
              const SizedBox(
                height: Dimensions.sizedLarge,
              ),
              Row(
                children: [
                  Obx(() => Get.find<LoginController>().userImage.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              title: "Replace photo",
                              content: Text("Do you want to replace photo?"),
                              confirm: MaterialButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Get.close(1);
                                  profileService.pickPhotoFromGallery();
                                },
                              ),
                              cancel: MaterialButton(
                                child: Text("Cancel"),
                                onPressed: Get.back,
                              ),
                            );
                          },
                          child: CustomImageView(
                              imgHeight: 104,
                              imgUrl: Get.find<LoginController>().userImage),
                        )
                      : GestureDetector(
                          onTap: () {
                            profileService.pickPhotoFromGallery();
                          },
                          child: CircleAvatar(
                            radius: 35,
                            child: Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const CustomImageView(
                                    imgUrl:
                                        'assets/images/onboarding/profile_photo_placeholder.svg'),
                              ),
                            ),
                          ),
                        )),
                  const SizedBox(
                    width: Dimensions.sizedDefault,
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizationUtil.getTranslatedString(
                          "pleaseProvideYourImage"),
                      style: FontManager().getTextStyle(context,
                          fontSize: 16,
                          color: ColorCodes.black,
                          lWeight: FontWeight.w400,
                          lineHeight: 1.2),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimensions.sizedExtraLarge,
              ),
              CustomTextField(
                controller: Get.find<LoginController>().userName,
                textStyle: FontManager().getTextStyle(context,
                    color: ColorCodes.black, fontSize: 16),
                hintText: "Enter Name",
                keyboardType: TextInputType.text,
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(10),
                //     borderSide:
                //         const BorderSide(color: ColorCodes.greyBr, width: 2)),
                // enabledBorder: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(10),
                //     borderSide:
                //         const BorderSide(color: ColorCodes.greyBr, width: 2)),
                enabled: true,
                // focusBorder: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(10),
                //     borderSide:
                //         const BorderSide(color: ColorCodes.greyBr, width: 2)),
                fillColor: ColorCodes.white,
                focusColor: ColorCodes.white,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Get.find<LoginController>().isLoading
                        ? CustomButton(
                            onTap: null,
                            text:
                                AppLocalizationUtil.getTranslatedString("next"),
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
                        : CustomButton(
                            onTap: () {
                              if (Get.find<LoginController>()
                                  .userName
                                  .text
                                  .isNotEmpty) {
                                profileService.createuserProfile();
                              } else {
                                CustomSnackBar().errorSnackBar(
                                    "Error", "Please enter Name");
                              }
                            },
                            text:
                                AppLocalizationUtil.getTranslatedString("next"),
                            textColor: ColorCodes.white,
                            // bgColor: ColorCodes.black,
                            // width: 120,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            borderRadius: 10,
                            margin: EdgeInsets.zero,
                            border:
                                Border.all(color: ColorCodes.greyBr, width: 2),
                            fontWeight: FontWeight.w500,
                          ),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimensions.sizedExtraLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
