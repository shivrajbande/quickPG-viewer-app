import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/controllers/bottom_nav_controller.dart';
import 'package:rento/helpers/routes.dart';
import 'package:rento/widgets/custom_button.dart';
import 'package:rento/widgets/custom_image.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: ColorCodes.white),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            navBarItem(context, 0, Get.find<BottomNavController>().activeIndex,
                "assets/images/home/home.svg",RouteManagement.home),
            navBarItem(
              context,
              1,
              Get.find<BottomNavController>().activeIndex,
              "assets/images/home/search.svg",RouteManagement.search
            ),
            // navBarItem(context, 2, Get.find<BottomNavController>().activeIndex, "assets/images/home/favourite.svg",),
            navBarItem(
              context,
              3,
              Get.find<BottomNavController>().activeIndex,
              "assets/images/home/chat.svg",RouteManagement.chatList
            ),
            // navBarItem(context, 4, Get.find<BottomNavController>().activeIndex, "assets/images/home/profile.svg",),
            CustomButton2(
              onTap: () {},
              text: "Listing",
              iconSuffix: Icons.arrow_upward,
              icon: Icons.arrow_upward,
              bgColor: ColorCodes.yellowColor2,
              width: 120,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              margin: EdgeInsets.zero,
              textColor: ColorCodes.black,
            )
          ],
        ),
      ),
    );
  }

  Widget navBarItem(context, index, activeIndex, image,route) {
    return InkWell(
      onTap: () {
        Get.find<BottomNavController>().activeIndex = index;
        Get.toNamed(route);
      },
      child: index != activeIndex
          ? Container(
              decoration: BoxDecoration(
                  color: ColorCodes.white,
                  borderRadius: BorderRadius.circular(100)),
              padding: const EdgeInsets.all(10),
              child: CustomImageView(
                imgUrl: image,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  color: ColorCodes.iconHighlightBgColor,
                  borderRadius: BorderRadius.circular(100)),
              padding: const EdgeInsets.all(10),
              child: CustomImageView(
                imgUrl: image,
                svgColor: ColorCodes.iconHighlightColor,
              ),
            ),
    );
  }
}
