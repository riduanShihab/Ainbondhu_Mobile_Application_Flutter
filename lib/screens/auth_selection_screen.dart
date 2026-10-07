import 'package:ain_bondhu_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/routes.dart';

class AuthSelectionScreen extends StatelessWidget {
  const AuthSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final double w = Get.width;
    final double h = Get.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const Spacer(flex: 2),

          // Logo and Motto Section
          Center(
            child: Column(
              children: [
                Text(
                  'আইনবন্ধু',
                  style: GoogleFonts.anekBangla(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.09,
                  ),
                ),
                SizedBox(height: h * 0.01),
                Text(
                  '"আইনকে জানুন আরও দক্ষভাবে ও আরও সহজে"',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.anekBangla(
                    color: AppColors.textGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(flex: 3),

          // Bottom Action Container
          Container(
            width: w,
            padding: EdgeInsets.symmetric(
                horizontal: w * 0.08,
                vertical: h * 0.06
            ),
            decoration: const BoxDecoration(
              color: AppColors.buttonGreen,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(AppRoutes.login),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.textBlack,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'লগইন করুন',
                      style: GoogleFonts.anekBangla(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: h * 0.025),

                // Signup Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () => Get.toNamed(AppRoutes.signup),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.golden,
                      side: const BorderSide(color: AppColors.white, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'সাইন আপ',
                      style: GoogleFonts.anekBangla(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}