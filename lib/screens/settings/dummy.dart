import 'package:flutter/material.dart';
import 'package:rento/constants/app_localization_util.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/constants/font_manager.dart';
import 'package:rento/widgets/custom_bottom_navbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

            ],),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomBottomNavbar(),
            ],
          )
        ],
      ),
    );
  }
}
