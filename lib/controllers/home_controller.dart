import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentSliderIndex = 0.obs;

  void updateSliderIndex(int index) {
    currentSliderIndex.value = index;
  }
}