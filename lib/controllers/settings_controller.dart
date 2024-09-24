import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController implements GetxService{
  final RxInt _activeIndex = (-1).obs;
  TextEditingController fullNameController=TextEditingController();
  TextEditingController phoneNumberController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController idProofController=TextEditingController();

  int get activeIndex => _activeIndex.value;

  set activeIndex(value) => _activeIndex.value=value;
}
