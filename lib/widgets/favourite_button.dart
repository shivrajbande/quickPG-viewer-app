import 'package:flutter/material.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/widgets/custom_image.dart';

class FavouriteButton extends StatelessWidget {
  bool favourite;
  Function() favouriteOnTap;

  FavouriteButton({super.key, required this.favourite,
    required this.favouriteOnTap,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: favouriteOnTap,
      child: Container(
        margin:
        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
            color: ColorCodes.white,
            borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.all(8.0),
        child: CustomImageView(
          imgUrl: 'assets/images/home/favourite_filled.svg',
          svgColor: favourite == true ? ColorCodes.red : null,
        ),
      ),
    );
  }
}
