import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';
import '../utils/app_colors.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double h = Get.height;
    final double w = Get.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(w * 0.02),
          child: CircleAvatar(
            backgroundColor: AppColors.buttonGreen,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.white, size: w * 0.05),
              onPressed: () => Get.back(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.06), // 6% of screen width
        child: Column(
          children: [
            // Logo
            Image.asset('assets/images/logo.png', height: h * 0.1), // 10% of screen height
            SizedBox(height: h * 0.01),

            Text(
              'আইনবন্ধু',
              style: GoogleFonts.anekBangla(
                color: AppColors.buttonGreen,
                fontWeight: FontWeight.bold,
                fontSize: w * 0.07, // Scaling font
              ),
            ),
            SizedBox(height: h * 0.04),

            Text(
              'লগইন করুন',
              style: GoogleFonts.anekBangla(
                fontSize: w * 0.06,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
            SizedBox(height: h * 0.04),

            // Email Field
            _buildTextField(
              hint: 'Email',
              icon: Icons.email_outlined,
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              width: w,
            ),
            SizedBox(height: h * 0.02),

            // Password Field
            Obx(() => _buildTextField(
              hint: 'Password',
              icon: Icons.lock_outline,
              isPassword: true,
              obscureText: controller.isObscured.value,
              controller: controller.passwordController,
              width: w,
              suffixIcon: IconButton(
                icon: Icon(
                  controller.isObscured.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: w * 0.05,
                ),
                onPressed: controller.toggleVisibility,
              ),
            )),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'পাসওয়ার্ড ভুলে গেছেন?',
                  style: GoogleFonts.anekBangla(
                    color: AppColors.textRed,
                    fontSize: w * 0.035,
                  ),
                ),
              ),
            ),
            SizedBox(height: h * 0.02),

            // Login Button
            Obx(() => SizedBox(
              width: double.infinity,
              height: h * 0.065,
              child: ElevatedButton(
                onPressed: controller.isLoading.value ? null : () => controller.login(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(w * 0.03)),
                  elevation: 0,
                ),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                  'লগইন করুন',
                  style: GoogleFonts.anekBangla(
                    color: AppColors.white,
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
            SizedBox(height: h * 0.03),

            // Divider
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                  child: Text(
                    'Or continue with',
                    style: TextStyle(color: AppColors.textGrey, fontSize: w * 0.03),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: h * 0.03),

            // Social Button
            _buildSocialButton(
              label: 'Continue with Google',
              imagePath: 'assets/images/google_logo.png',
              height: h * 0.065,
              width: w,
            ),
            SizedBox(height: h * 0.04),

            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(color: AppColors.textGrey, fontSize: w * 0.035),
                ),
                TextButton(
                  onPressed: () => Get.toNamed('/signup'),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: AppColors.buttonGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: w * 0.035,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper Methods with Dynamic Sizing
  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required double width,
    bool isPassword = false,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: width * 0.04),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.textGrey, size: width * 0.055),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.018, horizontal: width * 0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(width * 0.03),
          borderSide: const BorderSide(color: AppColors.borderGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(width * 0.03),
          borderSide: const BorderSide(color: AppColors.borderGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(width * 0.03),
          borderSide: const BorderSide(color: AppColors.buttonGreen, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildSocialButton({required String label, required String imagePath, required double height, required double width}) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.borderGrey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.03)),
          backgroundColor: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: height * 0.4),
            SizedBox(width: width * 0.03),
            Text(
              label,
              style: GoogleFonts.anekBangla(
                color: AppColors.textBlack,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}