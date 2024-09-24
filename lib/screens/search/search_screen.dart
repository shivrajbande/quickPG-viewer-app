import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rento/constants/app_localization_util.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/constants/font_manager.dart';
import 'package:rento/controllers/search_controller.dart';
import 'package:rento/widgets/custom_bottom_navbar.dart';
import 'package:rento/widgets/custom_button.dart';
import 'package:rento/widgets/custom_image.dart';
import 'package:rento/widgets/custom_textfield.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                                "enterYourLocation"),
                            style: FontManager().getTextStyle(context,
                                fontSize: 18,
                                color: ColorCodes.black,
                                lWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          CustomIconButton(
                            onTap: () {},
                            icon: Icons.tune,
                            bgColor: ColorCodes.iconBgColor,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: Get.find<SearchGetController>().searchController,
                        textStyle: FontManager().getTextStyle(context,
                            color: ColorCodes.black, fontSize: 16),
                        prefix: const Padding(
                          padding: EdgeInsets.fromLTRB(
                            10.0,
                            25.0,
                            5.0,
                            25.0,
                          ),
                          child: CustomImageView(
                            imgUrl: 'assets/images/home/search.svg',
                          ),
                        ),
                        suffix: const Padding(
                            padding: EdgeInsets.all(25.0),
                            child: Icon(
                              Icons.mic_none,
                              color: ColorCodes.black,
                            )),
                        focusBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: ColorCodes.greyBr, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: ColorCodes.greyBr, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: ColorCodes.greyBr, width: 2)),
                        enabled: true,
                        fillColor: ColorCodes.iconBgColor,
                        focusColor: ColorCodes.iconBgColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const CustomImageView(
                            imgUrl: 'assets/images/location.svg',
                            imgHeight: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Use my current location",
                            style: FontManager().getTextStyle(context,
                                color: ColorCodes.blueColor,
                                fontSize: 18,
                                lWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: ColorCodes.black.withOpacity(0.1),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "SAVED ADDRESSES",
                        style: FontManager().getTextStyle(context,
                            color: ColorCodes.greyTextColor,
                            fontSize: 20,
                            letterSpacing: 2.0,
                            lWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      savedAddressItem(context, "Sai Venkat",
                          "Petompon, Kec. Gajahmungkur, Kota, Semarang,", () {}),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "View More",
                            style: FontManager().getTextStyle(context,
                                color: ColorCodes.blueColor,
                                fontSize: 18,
                                lWeight: FontWeight.w600),
                          ),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 25,
                            color: ColorCodes.blueColor,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Popular Locations",
                        style: FontManager().getTextStyle(context,
                            color: ColorCodes.greyTextColor,
                            fontSize: 20,
                            letterSpacing: 2.0,
                            lWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      popularLocationItem(
                          context, () {}, "Dilsuknagar", "₹12k/month"),
                      popularLocationItem(
                          context, () {}, "Chaitanyapuri", "₹10k/month"),
                      popularLocationItem(context, () {}, "kondapur", "₹10k/month"),
                      popularLocationItem(context, () {}, "Gachibowli", "₹10k/month"),
                      popularLocationItem(context, () {}, "Madhapur", "₹10k/month"),
                      // Spacer(),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(onTap: () {}, text: "Search"),
                    ],
                  ),
                  // Spacer(),
                  const Visibility(
                      maintainSize: true,
                      maintainState: true,
                      visible: false,
                      maintainAnimation: true,
                      child: CustomBottomNavbar()),
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

  Widget savedAddressItem(context, name, address, shareTap) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CustomImageView(
                    imgUrl: 'assets/images/location.svg',
                    imgHeight: 15,
                    svgColor: ColorCodes.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: FontManager().getTextStyle(context,
                        color: ColorCodes.black,
                        fontSize: 18,
                        lWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                address,
                overflow: TextOverflow.ellipsis,
                style: FontManager().getTextStyle(context,
                    color: ColorCodes.greyTextColor,
                    fontSize: 14,
                    lWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        CustomIconButton(
          onTap: shareTap,
          icon: Icons.share_outlined,
          bgColor: ColorCodes.iconBgColor,
        )
      ],
    );
  }

  Widget popularLocationItem(context, addTap, area, price) {
    return Column(
      children: [
        Row(
          children: [
            CustomIconButton(
              onTap: addTap,
              icon: Icons.add,
              bgColor: ColorCodes.iconBgColor,
              iconColor: ColorCodes.blueColor,
              iconSize: 20,
              padding: const EdgeInsets.all(2),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              area,
              style: FontManager().getTextStyle(context,
                  color: ColorCodes.black,
                  fontSize: 16,
                  lWeight: FontWeight.w500),
            ),
            const Spacer(),
            Text(
              price,
              style: FontManager().getTextStyle(context,
                  color: ColorCodes.greyTextColor,
                  fontSize: 16,
                  lWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Divider(
          color: ColorCodes.black.withOpacity(0.1),
        ),
      ],
    );
  }
}
