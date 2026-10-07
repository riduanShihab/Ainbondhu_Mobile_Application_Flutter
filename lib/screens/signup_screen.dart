import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/signup_controller.dart';
import '../utils/app_colors.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define responsive variables
    final double h = Get.height;
    final double w = Get.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textBlack, size: w * 0.06),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.06), // 6% of screen width
        child: Column(
          children: [
            // Logo
            Image.asset('assets/images/logo.png', height: h * 0.09),

            Text(
                'আইনবন্ধু',
                style: GoogleFonts.anekBangla(
                    color: AppColors.buttonGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.065
                )
            ),
            SizedBox(height: h * 0.01),

            Text(
                'সাইন আপ',
                style: GoogleFonts.anekBangla(
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack
                )
            ),
            SizedBox(height: h * 0.03),

            // Input Fields
            _buildField(
              hint: 'নাম লিখুন',
              controller: controller.nameController,
              icon: Icons.person_outline,
              width: w,
            ),
            SizedBox(height: h * 0.015),

            _buildField(
              hint: 'ইমেইল অথবা ফোন নম্বর',
              controller: controller.emailPhoneController,
              icon: Icons.email_outlined,
              width: w,
            ),
            SizedBox(height: h * 0.015),

            // Password Field
            Obx(() => _buildField(
              hint: 'পাসওয়ার্ড দিন',
              controller: controller.passwordController,
              isPassword: true,
              obscureText: controller.isPasswordObscured.value,
              width: w,
              suffixIcon: IconButton(
                icon: Icon(
                  controller.isPasswordObscured.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: w * 0.05,
                ),
                onPressed: controller.togglePassword,
              ),
            )),
            SizedBox(height: h * 0.015),

            // Confirm Password Field
            Obx(() => _buildField(
              hint: 'পাসওয়ার্ড নিশ্চিত করুন',
              controller: controller.confirmPasswordController,
              isPassword: true,
              obscureText: controller.isConfirmPasswordObscured.value,
              width: w,
              suffixIcon: IconButton(
                icon: Icon(
                  controller.isConfirmPasswordObscured.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: w * 0.05,
                ),
                onPressed: controller.toggleConfirmPassword,
              ),
            )),

            SizedBox(height: h * 0.04),

            // SignUp Button
            Obx(() => SizedBox(
              width: double.infinity,
              height: h * 0.065, // Dynamic button height
              child: ElevatedButton(
                onPressed: controller.isLoading.value ? null : () => controller.signUp(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(w * 0.03)
                  ),
                  elevation: 0,
                ),
                child: controller.isLoading.value
                    ? SizedBox(
                  height: h * 0.03,
                  width: h * 0.03,
                  child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
                    : Text(
                    'সাইন আপ',
                    style: GoogleFonts.anekBangla(
                        color: Colors.white,
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
            )),

            SizedBox(height: h * 0.03),

            // Login Redirect
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(fontSize: w * 0.035, color: AppColors.textGrey),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.buttonGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.035,
                      )
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.02),
          ],
        ),
      ),
    );
  }

  // Refined Helper Method
  Widget _buildField({
    required String hint,
    required TextEditingController controller,
    required double width,
    IconData? icon,
    bool isPassword = false,
    bool obscureText = false,
    Widget? suffixIcon
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(fontSize: width * 0.04),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: width * 0.038, color: Colors.grey),
        prefixIcon: Icon(
          icon ?? (isPassword ? Icons.lock_outline : Icons.info_outline),
          size: width * 0.055,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: EdgeInsets.symmetric(
            vertical: Get.height * 0.018,
            horizontal: width * 0.04
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.03),
            borderSide: const BorderSide(color: AppColors.borderGrey)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.03),
            borderSide: const BorderSide(color: AppColors.borderGrey)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.03),
            borderSide: const BorderSide(color: AppColors.buttonGreen, width: 1.5)
        ),
      ),
    );
  }
}