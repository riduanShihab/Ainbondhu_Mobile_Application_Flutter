import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/auth_request_models.dart';
import '../utils/app_colors.dart';
import '../utils/routes.dart';

class LoginController extends GetxController {
  // Observables for UI reactivity
  var isObscured = true.obs;
  var isLoading = false.obs;

  // Controllers for the TextFields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Helper to toggle password visibility
  void toggleVisibility() => isObscured.value = !isObscured.value;

  Future<void> login() async {
    //  Get and Trim data
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    //  Client-side empty check
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "ভুল",
        "ইমেইল এবং পাসওয়ার্ড দিন",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      //  Start Loading State
      isLoading.value = true;

      // Simulating network delay (important for testing loading spinners)
      await Future.delayed(const Duration(seconds: 1));

      //  Load Mock Data from Assets
      final String response = await rootBundle.loadString('assets/data/user_mock.json');
      final Map<String, dynamic> mockData = json.decode(response);

      // Comparison Logic
      if (email == mockData['email'] && password == mockData['password']) {
        // Success Case
        UserModel user = UserModel.fromJson(mockData);
        isLoading.value = false;

        Get.snackbar(
          "সাফল্য",
          "স্বাগতম, ${user.name}!",
          backgroundColor: AppColors.green,
          colorText: AppColors.white,
          icon: const Icon(Icons.check_circle, color: AppColors.white),
        );
        Get.offAllNamed(AppRoutes.home);

      } else {
        isLoading.value = false;
        Get.snackbar(
          "লগইন ব্যর্থ",
          "ইমেইল অথবা পাসওয়ার্ড সঠিক নয়",
          backgroundColor: AppColors.textRed,
          colorText: AppColors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Error Case: JSON missing or Asset path wrong
      isLoading.value = false;
      debugPrint("Login Error: $e");
      Get.snackbar(
        "Error",
        "সিস্টেমে সমস্যা হয়েছে। ডাটাবেস খুঁজে পাওয়া যায়নি।",
        backgroundColor: AppColors.textBlack,
        colorText: AppColors.white,
      );
    }
  }

  @override
  void onClose() {
    // Prevent memory leaks by disposing controllers
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}