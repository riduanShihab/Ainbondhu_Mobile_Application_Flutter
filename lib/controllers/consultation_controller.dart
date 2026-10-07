import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nav_controller.dart';
import '../utils/routes.dart';

class ConsultationController extends GetxController {
  final NavController navController = Get.find<NavController>();

  // Form fields
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var selectedLawyer = RxnString();
  var subject = ''.obs;
  var problemDescription = ''.obs;

  final List<String> lawyers = ['রবার্ট লি', 'আব্দুর রহমান', 'জেরিন তাসনিম'];

  @override
  void onInit() {
    super.onInit();

    // FIX 1: Wrap the index update in a PostFrameCallback or Future.delayed
    // This waits until the build is finished before updating the UI.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navController.selectedIndex.value = 1;
    });
  }

  void submitForm() {
    Get.toNamed(AppRoutes.requestedAppointments);

    Get.snackbar(
      "সফল",
      "আপনার অনুরোধটি তালিকাভুক্ত করা হয়েছে",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1B5E20),
      colorText: Colors.white,
    );
  }
}