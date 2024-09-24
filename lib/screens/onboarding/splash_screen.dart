import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/helpers/routes.dart';
import 'package:rento/widgets/custom_image.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => Get.toNamed(RouteManagement.initial));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorCodes.blueColor,
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                CustomImageView(imgUrl: 'assets/images/rento_icon_1.svg'),
                SizedBox(height: 40,),
                CustomImageView(imgUrl: 'assets/images/rento_icon_2.svg'),
                SizedBox(height: 40,),
                Padding(
                  padding: EdgeInsets.only(right: 50.0),
                  child: CustomImageView(imgUrl: 'assets/images/rento_icon_3.svg'),
                ),
                SizedBox(height: 60,),
                Padding(
                  padding: EdgeInsets.only(right:50.0),
                  child: CustomImageView(imgUrl: 'assets/images/rento_icon_4.svg'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
