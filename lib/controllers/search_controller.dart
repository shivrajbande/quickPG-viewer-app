import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchGetController extends GetxController implements GetxService {
  TextEditingController searchController =
      TextEditingController(text: "Search House, Apartment, etc");
}
