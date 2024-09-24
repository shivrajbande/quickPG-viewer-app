import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/widgets/custom_image.dart';

class CustomSnackBar {
  void errorSnackBar(title, text) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: const TextStyle(
            color: ColorCodes.black, fontWeight: FontWeight.w600),
      ),
      messageText: Text(
        text,
        style: const TextStyle(color: ColorCodes.black),
      ),
      animationDuration: const Duration(milliseconds: 500),
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorCodes.lightRed,
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.up,
      icon: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: CustomImageView(imgUrl: 'assets/images/error.svg',imgHeight: 45,),
      ),
      snackStyle: SnackStyle.FLOATING,
      padding: EdgeInsets.all(15),
      leftBarIndicatorColor: ColorCodes.red,

    );

    // Get.showSnackbar(GetSnackBar(
    //   titleText: Text(
    //     title,
    //     style: const TextStyle(
    //         color: ColorCodes.black, fontWeight: FontWeight.w600),
    //   ),
    //   messageText: Text(
    //     text,
    //     style: const TextStyle(color: ColorCodes.black),
    //   ),
    //   animationDuration: const Duration(milliseconds: 500),
    //   snackPosition: SnackPosition.TOP,
    //   backgroundColor: ColorCodes.lightRed,
    //   duration: const Duration(seconds: 2),
    //   dismissDirection: DismissDirection.up,
    //   icon: const Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 5.0),
    //     child: CustomImageView(imgUrl: 'assets/images/error.svg'),
    //   ),
    //   snackStyle: SnackStyle.FLOATING,
    //   // borderColor: ColorCodes.red,
    //   // borderWidth: 4,
    //   padding: EdgeInsets.zero,
    //   leftBarIndicatorColor: ColorCodes.red,
    // ));
  }

  void successSnackBar(title, text) {
    Get.showSnackbar(GetSnackBar(
      titleText: Text(
        title,
        style: const TextStyle(
            color: ColorCodes.black, fontWeight: FontWeight.w600),
      ),
      messageText: Text(
        text,
        style: const TextStyle(color: ColorCodes.black),
      ),
      animationDuration: const Duration(milliseconds: 500),
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorCodes.lightGreen,
      duration: const Duration(seconds: 1),
      dismissDirection: DismissDirection.up,
      icon: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: CustomImageView(imgUrl: 'assets/images/success.svg',imgHeight: 45,),
      ),
      snackStyle: SnackStyle.FLOATING,
      padding: EdgeInsets.all(15),
      leftBarIndicatorColor: ColorCodes.green,
    ));
  }
}
