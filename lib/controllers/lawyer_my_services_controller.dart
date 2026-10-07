import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LawyerMyServicesController extends GetxController {
  var services = <Map<String, dynamic>>[
    {
      'title': 'ব্যবসায়িক চুক্তি',
      'category': 'ব্যবসায়িক চুক্তি',
      'description': 'বিবাহ বিচ্ছেদ সংক্রান্ত সকল আইনি পরামর্শ ও সহায়তা',
      'priceRange': '৳৫০০০ - ৳২০০০০',
      'isActive': true,
      'image': 'assets/images/contract_icon.png',
    },
    {
      'title': 'জমি রেজিস্ট্রেশন',
      'category': 'সম্পত্তি আইন',
      'description': 'জমি ক্রয়-বিক্রয় দলিল প্রস্তুতি এবং রেজিস্ট্রেশন',
      'priceRange': '৳৪০০০ - ৳২৫০০০',
      'isActive': true,
      'image': 'assets/images/land_icon.png',
    },
    {
      'title': 'ফৌজদারি মামলা',
      'category': 'ফৌজদারি আইন',
      'description': 'ফৌজদারি মামলার সম্পূর্ণ পরিচালনা',
      'priceRange': '৳৩০০০০ - ৳১০০০০০',
      'isActive': true,
      'image': 'assets/images/criminal_case.png',
    },
  ].obs;

  void viewDetails(int index) {
    debugPrint("View details for ${services[index]['title']}");
  }
}
