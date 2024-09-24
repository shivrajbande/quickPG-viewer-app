import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rento/models/icon_model.dart';

class HomeController extends GetxController implements GetxService {
  final RxInt _bottomNavIndex = 0.obs;
  TextEditingController searchController =
      TextEditingController(text: "Search");
  final RxBool _favourite = false.obs;
  List _carouselIndex = [];
  // final RxInt _carouselIndex = 0.obs;
  List<IconModel> iconList = [
    // IconModel(Icons.bed, "3 Beds"),
    // IconModel(Icons.restaurant_menu, "Food"),
    // IconModel(Icons.wash, "Washing Machine"),
    IconModel(Icons.chat, "Chat")
  ];

  int get bottomNavIndex => _bottomNavIndex.value;
  bool get favourite => _favourite.value;
  List get carouselIndex => _carouselIndex;

  set bottomNavIndex(value) => _bottomNavIndex.value = value;
  set favourite(value) => _favourite.value = value;
  set carouselIndex(value) => _carouselIndex = value;
}
