import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/auth_request_models.dart';

class SignUpController extends GetxController {
  var isPasswordObscured = true.obs;
  var isConfirmPasswordObscured = true.obs;
  var isLoading = false.obs;

  final nameController = TextEditingController();
  final emailPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void togglePassword() => isPasswordObscured.value = !isPasswordObscured.value;
  void toggleConfirmPassword() => isConfirmPasswordObscured.value = !isConfirmPasswordObscured.value;

  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("ভুল", "পাসওয়ার্ড ম্যাচ করেনি!");
      return;
    }

    try {
      isLoading.value = true;
      SignUpRequest request = SignUpRequest(
        name: nameController.text.trim(),
        emailOrPhone: emailPhoneController.text.trim(),
        password: passwordController.text,
      );

      await Future.delayed(const Duration(seconds: 1)); // Simulate delay

      // Using the same mock for testing
      final String response = await rootBundle.loadString('assets/data/user_mock.json');
      UserModel user = UserModel.fromJson(json.decode(response));

      isLoading.value = false;
      Get.snackbar("সাফল্য", "অ্যাকাউন্ট তৈরি হয়েছে, স্বাগতম ${user.name}");
      Get.offAllNamed('/login');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "কিছু ভুল হয়েছে");
    }
  }
}