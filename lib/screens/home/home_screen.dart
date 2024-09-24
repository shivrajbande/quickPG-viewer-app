import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rento/constants/app_localization_util.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/constants/font_manager.dart';
import 'package:rento/constants/space_constants.dart';
import 'package:rento/controllers/home_controller.dart';
import 'package:rento/helpers/routes.dart';
import 'package:rento/models/property_model.dart';
import 'package:rento/screens/chats/chat.dart';
import 'package:rento/services/properties.dart';
import 'package:rento/widgets/custom_bottom_navbar.dart';
import 'package:rento/widgets/custom_button.dart';
import 'package:rento/widgets/custom_image.dart';
import 'package:rento/widgets/custom_textfield.dart';
import 'package:rento/widgets/favourite_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      // CustomImageView(imgUrl: 'assets/images/home/city_bg.svg'),
                      Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          notificationBar(context),
                          const SizedBox(
                            height: 20,
                          ),
                          searchBar(context),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Column(
                  //   children: [
                  //     hostelCard(context),
                  //     hostelCard(context),
                  //     hostelCard(context),
                  //   ],
                  // ),
                  FutureBuilder(
                    future: Properties().fetchPropeties(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          print("error when displaying image lists");
                          const Text("got error while retreving hostels");
                        } else {
                          return Column(
                              children: snapshot.data!.map((property) {
                            int index = snapshot.data!.indexOf(property);
                            return hostelCard(property, index, context);
                          }).toList()
                              // [
                              //   ...propertyListUI(snapshot.data, context),
                              // ],
                              );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),

                  const Visibility(
                      maintainSize: true,
                      maintainState: true,
                      visible: false,
                      maintainAnimation: true,
                      child: CustomBottomNavbar()),
                  // bestForYou(context),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // mainCards(context),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: CustomIconButton2(
                    onTap: () {},
                    icon: Icons.map,
                    text: "Map",
                    bgColor: ColorCodes.black,
                    textColor: ColorCodes.white,
                    fontSize: 20,
                    iconSize: 20,
                    iconColor: ColorCodes.white,
                    width: 105,
                    border: Border.all(color: ColorCodes.black, width: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                  ),
                ),
              ),
              CustomBottomNavbar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget notificationBar(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CustomImageView(imgUrl: "assets/images/rento_icon.svg"),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizationUtil.getTranslatedString("location"),
              style: FontManager().getTextStyle(context,
                  color: ColorCodes.black.withOpacity(0.43),
                  fontSize: 18,
                  lWeight: FontWeight.w400),
            ),
            Row(
              children: [
                Text(
                  "Hyderabad",
                  style: FontManager().getTextStyle(context,
                      color: ColorCodes.black,
                      fontSize: 22,
                      lWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(Icons.keyboard_arrow_down_outlined)
              ],
            )
          ],
        ),
        const Spacer(),
        CustomIconButton(
          onTap: () {},
          icon: Icons.notifications_none,
        ),
        const SizedBox(
          width: 10,
        ),
        CustomIconButton(
            onTap: () {
              Get.toNamed(RouteManagement.settings);
            },
            icon: Icons.person_pin_outlined,
            image: "assets/images/home/profile.svg"),
      ],
    );
  }

  Widget locationBar(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
            child: Stack(
          children: [
            CustomButton2(
              onTap: () {},
              text: "postProperty",
              icon: Icons.add,
              margin: const EdgeInsets.only(left: 40, top: 15),
              gradient: const LinearGradient(
                  colors: [ColorCodes.blueGradient1, ColorCodes.blueGradient2]),
              textColor: ColorCodes.white,
              iconColor: ColorCodes.white,
              borderRadius: 10,
            ),
            Align(
              alignment: Alignment.topRight,
              child: CustomButton(
                onTap: null,
                text: "free",
                textColor: ColorCodes.white,
                bgColor: ColorCodes.red,
                width: 60,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                borderRadius: 5,
                margin: EdgeInsets.zero,
              ),
            ),
          ],
        ))
      ],
    );
  }

  Widget searchBar(context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed(RouteManagement.search),
            child: CustomTextField(
              controller: Get.find<HomeController>().searchController,
              textStyle: FontManager()
                  .getTextStyle(context, color: ColorCodes.black, fontSize: 16),
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
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                      const BorderSide(color: ColorCodes.greyBr, width: 2)),
              enabled: false,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        CustomIconButton(
          onTap: () {},
          icon: Icons.tune,
        )
      ],
    );
  }

  Widget hostelCard(Property property, int index, BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(color: ColorCodes.greyBr),
          // color: ColorCodes.blueColor,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CarouselSlider(
                  // items: [
                  //   ,
                  //   CustomImageView(
                  //       imgUrl: property.propertyInfo.propertyImagesList[1]),
                  //   CustomImageView(
                  //       imgUrl: property.propertyInfo.propertyImagesList[0]),
                  //   CustomImageView(
                  //       imgUrl: property.propertyInfo.propertyImagesList[1]),
                  //   CustomImageView(
                  //       imgUrl: property.propertyInfo.propertyImagesList[0]),
                  // ],
                  items:
                      property.propertyInfo.propertyImagesList.map((imageURL) {
                    return Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusLarge)),
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusLarge),
                          child: CustomImageView(
                            imgUrl: imageURL,
                            imgFit: BoxFit.cover,
                          ),
                        ));
                  }).toList(),
                  options: CarouselOptions(
                      onPageChanged: (i, reason) {
                        Get.find<HomeController>().carouselIndex[index].value =
                            i;
                      },
                      autoPlay: false,
                      enlargeCenterPage: false,
                      padEnds: false,
                      reverse: false,
                      enableInfiniteScroll: true,
                      viewportFraction: 1.0,
                      aspectRatio: 1.675)),
              Positioned(
                left: -20,
                top: -1,
                child: CustomButton(
                    onTap: null,
                    text: property
                        .propertyInfo.additionalDetails.preferredTenant[0],
                    //either boy, girl or couple
                    bgColor: ColorCodes.yellowColor2,
                    textColor: ColorCodes.black,
                    width: (property.propertyInfo.additionalDetails
                                .preferredTenant[0].length *
                            15)
                        .toDouble(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    borderRadius2:
                        const BorderRadius.only(topLeft: Radius.circular(10))),
              ),
              Obx(
                () => Positioned(
                  bottom: 30,
                  left: MediaQuery.of(context).size.width / 3,
                  child: CarouselIndicator(
                    height: 5,
                    width: 30,
                    count: property.propertyInfo.propertyImagesList.length,
                    index:
                        Get.find<HomeController>().carouselIndex[index].value,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      property.propertyInfo.basicDetails.propertyName,
                      style: FontManager().getTextStyle(context,
                          color: ColorCodes.black,
                          fontSize: 18,
                          lWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    CustomButton(
                      margin: EdgeInsets.zero,
                      borderRadius: 50,
                      onTap: null,
                      text: "10% off",
                      bgColor: ColorCodes.orangeBgColor,
                      textColor: ColorCodes.orangeColor,
                      width: 80,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    CustomButton(
                      margin: EdgeInsets.zero,
                      borderRadius: 50,
                      onTap: null,
                      text: "4 sharing",
                      //needs ui correction as sharing should be displayed on clikcking on property only
                      bgColor: ColorCodes.blueBgColor,
                      textColor: ColorCodes.blueColor,
                      width: 90,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: ColorCodes.starColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "4.8 Rating", //ratings have been not discussed
                              style: FontManager().getTextStyle(context,
                                  color: ColorCodes.greyTextColor,
                                  fontSize: 16,
                                  lWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_pin,
                              color: ColorCodes.blueColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Jakarta, Indonesia",
                              //location can used, but skipping in web
                              style: FontManager().getTextStyle(context,
                                  color: ColorCodes.greyTextColor,
                                  fontSize: 16,
                                  lWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Text(
                    //   '₹ ${property.propertyInfo.additionalDetails.expectedRent}/m',
                    //   style: FontManager().getTextStyle(context,
                    //       color: ColorCodes.black,
                    //       fontSize: 26,
                    //       lWeight: FontWeight.w600),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: Get.find<HomeController>()
                          .iconList
                          .map((e) => CustomIconButton2(
                                onTap: e.text == "Chat"
                                    ? () {
                                        var data = {
                                          "ownerName": property.ownerInfo?.name??"",
                                          "ownerId" :property.ownerInfo?.ownerId??"",
                                          "phoneNumber" :property.ownerInfo?.phoneNumber??"",
                                          "photo":property.ownerInfo?.profilePhoto??"",
                                          "chatId":property.ownerInfo?.ownerChatId??"",
                                        };
                                        Get.toNamed(RouteManagement.chat,
                                            parameters: data);
                                      }
                                    : null,
                                text: e.text,
                                icon: e.icon,
                              ))
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget bestForYou(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizationUtil.getTranslatedString("bestForYou"),
              style: FontManager().getTextStyle(context,
                  color: ColorCodes.black,
                  fontSize: 22,
                  lWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: () {},
              child: Text(
                AppLocalizationUtil.getTranslatedString("viewAll"),
                style: FontManager().getTextStyle(context,
                    color: ColorCodes.indigoColor2,
                    fontSize: 22,
                    lWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        CarouselSlider(
            items: [
              Obx(
                () => bestForYouCard(
                    context,
                    'assets/images/home/dummy_asset.png',
                    "Infinite Charm",
                    "Maldives",
                    "5.0",
                    Get.find<HomeController>().favourite, () {
                  Get.find<HomeController>().favourite =
                      !Get.find<HomeController>().favourite;
                }),
              ),
              bestForYouCard(context, 'assets/images/home/dummy_asset.png',
                  "Infinite Charm", "Maldives", "5.0", false, () {}),
            ],
            options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: false,
                padEnds: false,
                reverse: false,
                enableInfiniteScroll: false,
                viewportFraction: 0.8))
      ],
    );
  }

  Widget bestForYouCard(
    context,
    image,
    name,
    location,
    rating,
    favourite,
    favouriteOnTap,
  ) {
    return Stack(
      children: [
        CustomImageView(
          imgUrl: image,
          imgFit: BoxFit.cover,
        ),
        FavouriteButton(favourite: favourite, favouriteOnTap: favouriteOnTap),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 80.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: FontManager().getTextStyle(context,
                              color: ColorCodes.white,
                              fontSize: 16,
                              lWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          location,
                          style: FontManager().getTextStyle(context,
                              color: ColorCodes.white,
                              fontSize: 16,
                              lWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: ColorCodes.starColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          rating,
                          style: FontManager().getTextStyle(context,
                              color: ColorCodes.white,
                              fontSize: 16,
                              lWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget mainCards(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            mainCard(context, "homes", 'assets/images/home/homes.svg', () {}),
            const SizedBox(
              width: 15,
            ),
            mainCard(
                context, "hostels", 'assets/images/home/hostels.svg', () {}),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            mainCard(context, "plots", 'assets/images/home/plots.svg', () {}),
            const SizedBox(
              width: 15,
            ),
            mainCard(context, "commercials",
                'assets/images/home/commercials.svg', () {}),
          ],
        ),
      ],
    );
  }

  Widget mainCard(context, text, image, onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 180,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              color: ColorCodes.white,
              border: Border.all(color: ColorCodes.greyBr, width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizationUtil.getTranslatedString(text),
                      style: FontManager().getTextStyle(context,
                          fontSize: 18,
                          color: ColorCodes.black,
                          lWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      AppLocalizationUtil.getTranslatedString("nearby"),
                      style: FontManager().getTextStyle(context,
                          fontSize: 18,
                          color: ColorCodes.black.withOpacity(0.43),
                          lWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: CustomImageView(imgUrl: image),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> propertyListUI(List<Property>? properties, context) {
    List<Widget> temp = [];

    properties?.forEach((property) {
      temp.add(hostelCard(property, 0, context));
    });
    return temp;
  }
}
