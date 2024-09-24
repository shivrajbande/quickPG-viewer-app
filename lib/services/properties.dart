import 'dart:convert';

import 'package:get/get.dart';
import 'package:rento/controllers/home_controller.dart';
import 'package:rento/models/property_model.dart';

import '../constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Properties {
  Future<List<Property>> fetchPropeties() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(SharedPrefKeys.uidID);
    String? accessToken = prefs.getString(SharedPrefKeys.accessToken);
    var header = {
      "Content-Type": "application/json",
      "authorization": 'Bearer ${accessToken}'
    };
    String uri = "${AppEnvironment.apiEnv}${APIStore.getProperties}";
    var response = await http.get(Uri.parse(uri), headers: header);
    if (response.statusCode == 201) {
      //  List<Property> properties = (jsonDecode(response.body) as List)
      //         .map((propertyJson) => Property.fromJson(propertyJson))
      //         .toList();
      try {
        Get.find<HomeController>().carouselIndex = [];
        List<Property> properties = [];
        var propertyBody = jsonDecode(response.body);
        // print(propertyBody.length);
        for (int i = 0; i < propertyBody.length; i++) {
          Property tempProperty = Property.fromJson(propertyBody[i]);
          Get.find<HomeController>().carouselIndex.add(0.obs);
          properties.add(tempProperty);
        }
        return properties;
      } catch (error) {
        print(error);
      }
    } else if (response.statusCode == 403) {
    } else {}
    return [];
  }
}
