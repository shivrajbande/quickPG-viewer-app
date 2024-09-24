import 'package:flutter/material.dart';
import 'package:rento/constants/app_localization_util.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/constants/font_manager.dart';
import 'package:rento/widgets/custom_image.dart';

class CustomButton extends StatelessWidget {
  var onTap;
  String text;
  Color? bgColor;
  Color? textColor;
  EdgeInsetsGeometry? margin;
  double? borderRadius;
  double? width;
  EdgeInsetsGeometry? padding;
  BorderRadiusGeometry? borderRadius2;
  double? fontSize;
  FontWeight? fontWeight;
  Border? border;
  Widget? widget;

  CustomButton(
      {this.margin,
      required this.onTap,
      required this.text,
      this.borderRadius,
      this.bgColor,
      this.textColor,
      this.width,
      this.padding,
      this.borderRadius2,
      this.fontSize,
      this.fontWeight,
      this.border,
      this.widget,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin ?? EdgeInsets.symmetric(horizontal: 20),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            color: bgColor ?? ColorCodes.blueColor,
            border: border,
            borderRadius:
                borderRadius2 ?? BorderRadius.circular(borderRadius ?? 10)),
        child: widget ?? Text(
          AppLocalizationUtil.getTranslatedString(text),
          textAlign: TextAlign.center,
          style: FontManager().getTextStyle(context,
              color: textColor ?? ColorCodes.white,
              fontSize: fontSize ?? 16,
              lWeight: fontWeight ?? FontWeight.w500,
              lineHeight: 1.2),
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  var onTap;
  String text;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  IconData icon;
  Gradient? gradient;
  Color? iconColor;
  Color? textColor;
  double? borderRadius;
  Color? bgColor;
  IconData? iconSuffix;
  Color? iconSuffixColor;
  double? width;
  FontWeight? fontWeight;

  CustomButton2(
      {this.margin,
      required this.onTap,
      required this.text,
      required this.icon,
      this.gradient,
      this.textColor,
      this.iconColor,
      this.borderRadius,
      this.bgColor,
      this.iconSuffix,
      this.iconSuffixColor,
      this.padding,
      this.width,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin ?? EdgeInsets.symmetric(horizontal: 20),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            color: bgColor ?? ColorCodes.greyBg,
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius ?? 5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconSuffix == null)
              Icon(
                icon,
                color: iconColor,
              ),
            const SizedBox(
              width: 10,
            ),
            Text(
              AppLocalizationUtil.getTranslatedString(text),
              textAlign: TextAlign.center,
              style: FontManager().getTextStyle(context,
                  color: textColor ?? ColorCodes.indigoColor,
                  fontSize: 16,
                  lWeight: fontWeight ?? FontWeight.w500,
                  lineHeight: 1.2),
            ),
            if (iconSuffix != null)
              Row(
                children: [
                  if (iconSuffix == null)
                    const SizedBox(
                      width: 10,
                    ),
                  Icon(
                    iconSuffix,
                    color: iconSuffixColor,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    super.key,
    this.onTap,
    this.icon,
    this.image,
    this.bgColor,
    this.iconSize,
    this.padding,
    this.iconColor,
  });

  Function()? onTap;
  IconData? icon;
  String? image;
  Color? bgColor;
  double? iconSize;
  EdgeInsetsGeometry? padding;
  Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
              color: bgColor ?? ColorCodes.white,
              border: Border.all(color: ColorCodes.greyBr, width: 2),
              borderRadius: BorderRadius.circular(100)),
          child: image == null
              ? Icon(
                  icon ?? Icons.notifications_none,
                  size: iconSize ?? 30,
                  color: iconColor,
                )
              : CustomImageView(imgUrl: image!,imgHeight: 30,)),
    );
  }
}

class CustomIconButton2 extends StatelessWidget {
  CustomIconButton2(
      {super.key,
      this.onTap,
      this.icon,
      this.text,
      this.bgColor,
      this.textColor,
      this.fontSize,
      this.iconSize,
      this.iconColor,
      this.width,
      this.padding,
      this.border});

  Function()? onTap;
  IconData? icon;
  String? text;
  Color? bgColor;
  Color? textColor;
  double? fontSize;
  double? iconSize;
  Color? iconColor;
  double? width;
  EdgeInsetsGeometry? padding;
  BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
          width: width,
          margin: const EdgeInsets.only(right: 8),
          padding:
              padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
              color: bgColor ?? ColorCodes.white,
              border: border ?? Border.all(color: ColorCodes.greyBr, width: 2),
              borderRadius: BorderRadius.circular(100)),
          child: Row(
            children: [
              Icon(
                icon ?? Icons.notifications_none,
                size: iconSize ?? 15,
                color: iconColor,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                text ?? '',
                style: FontManager().getTextStyle(context,
                    color: textColor ?? ColorCodes.black,
                    fontSize: fontSize ?? 12,
                    lWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}
