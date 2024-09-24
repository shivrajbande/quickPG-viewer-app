import 'package:get/get.dart';

class BottomNavController extends GetxController implements GetxService {
  final RxInt _activeIndex = 0.obs;

  int get activeIndex => _activeIndex.value;

  set activeIndex(value) => _activeIndex.value=value;
}
