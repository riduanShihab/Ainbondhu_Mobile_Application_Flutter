import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../models/lawyer_side_model.dart';

class LawyerHomeController extends GetxController {
  var selectedIndex = 0.obs;
  var stats = <DashboardStatModel>[].obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
    loadStats();
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void loadStats() {
    // Simulate API call
    stats.value = [
      DashboardStatModel(title: 'মোট পরামর্শ', value: '২৩'),
      DashboardStatModel(title: 'স্ট্যাটাস', value: 'সক্রিয়', isStatus: true),
      DashboardStatModel(title: 'চলমান সেবা', value: '৫'),
      DashboardStatModel(title: 'মোট আয়', value: '১২৯৮৭'),
    ];
  }
}