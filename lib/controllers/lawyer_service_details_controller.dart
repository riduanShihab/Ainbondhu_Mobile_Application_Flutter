import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LawyerServiceDetailsController extends GetxController {
  var isEditing = false.obs;

  var serviceType = 'মামলা পরিচালনা'.obs;
  var category = 'ব্যবসায়িক চুক্তি'.obs;
  var title = 'ফৌজদারি মামলা'.obs;
  var description = 'ফৌজদারি মামলার সম্পূর্ণ পরিচালনা'.obs;

  var standard = {
    'price': '30000'.obs,
    'desc': 'নিম্ন আদালতে মামলা পরিচালনা'.obs,
    'delivery': '10'.obs,
    'features': ['কোর্ট হাজিরা', 'ডকুমেন্ট ফাইলিং'].obs,
  };

  var advanced = {
    'price': '50000'.obs,
    'desc': 'উচ্চ আদালতে মামলা পরিচালনা'.obs,
    'delivery': '7'.obs,
    'features': ['কোর্ট হাজিরা', 'ডকুমেন্ট ফাইলিং', 'জামিন আবেদন'].obs,
  };

  var premium = {
    'price': '100000'.obs,
    'desc': 'সর্বোচ্চ আদালত পর্যন্ত মামলা পরিচালনা'.obs,
    'delivery': '5'.obs,
    'features': [
      'কোর্ট হাজিরা',
      'ডকুমেন্ট ফাইলিং',
      'জামিন আবেদন',
      'সিনিয়র উকিল সহায়তা',
    ].obs,
  };

  final serviceTypes = ['মামলা পরিচালনা', 'চুক্তিপত্র তৈরি', 'পরামর্শ'];
  final categories = [
    'ব্যবসায়িক চুক্তি',
    'সম্পত্তি আইন',
    'পারিবারিক আইন',
    'ফৌজদারি আইন',
  ];

  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }

  void saveChanges() {
    isEditing.value = false;
    Get.snackbar(
      'সফল',
      'পরিবর্তনগুলো সংরক্ষিত হয়েছে',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
