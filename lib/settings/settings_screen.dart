import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import '../../utils/routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: AppColors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "সেটিংস",
          style: GoogleFonts.anekBangla(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Get.width * 0.04),
        child: Column(
          children: [
            _buildSettingItem(
              title: "প্রোফাইল",
              subtitle: "আপনার প্রোফাইল পরিচালনা করুন",
              onTap: () => Get.toNamed(AppRoutes.editProfile),
            ),
            _buildSettingItem(
              title: "নোটিফিকেশন",
              subtitle: "পুশ নোটিফিকেশন সেটিংস",
              onTap: () => Get.toNamed(AppRoutes.notificationSettings),
            ),
            _buildSettingItem(
              title: "গোপনীয়তা",
              subtitle: "ডেটা ও গোপনীয়তা সেটিংস",
              onTap: () => Get.toNamed(AppRoutes.privacySettings),
            ),
            _buildSettingItem(
              title: "সাহায্য ও সহায়তা",
              subtitle: "FAQ এবং যোগাযোগ",
              onTap: () {
                // TODO: Implement Help
              },
            ),
            _buildSettingItem(
              title: "সম্পর্কে",
              subtitle: "Version 1.0.0",
              onTap: () {},
            ),
            SizedBox(height: Get.height * 0.03),
            _buildDangerZone(),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
          vertical: Get.height * 0.01,
        ),
        title: Text(
          title,
          style: GoogleFonts.anekBangla(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.anekBangla(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  Widget _buildDangerZone() {
    return Container(
      padding: EdgeInsets.all(Get.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "বিপদ অঞ্চল",
            style: GoogleFonts.anekBangla(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: Get.height * 0.01),
          Text(
            "একবার আপনি আপনার অ্যাকাউন্ট মুছে ফেললে, ফিরে যাওয়ার উপায় নেই। দয়া করে নিশ্চিত হন।",
            style: GoogleFonts.anekBangla(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          SizedBox(
            width: double.infinity, // Full width button
            child: ElevatedButton(
              onPressed: () {
                // Confirm delete
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
              ),
              child: Text(
                "অ্যাকাউন্ট মুছে ফেলুন",
                style: GoogleFonts.anekBangla(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}