import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/settings_controller.dart';
import '../../utils/app_colors.dart';

class PrivacySettingsScreen extends StatelessWidget {
  PrivacySettingsScreen({super.key});

  final SettingsController controller = Get.find<SettingsController>();

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
          "গোপনীয়তা সেটিংস",
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
            // Privacy Toggles Card
            Container(
              padding: EdgeInsets.all(Get.width * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.security,
                          color: Colors.purple.shade700,
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "গোপনীয়তা সেটিংস",
                            style: GoogleFonts.anekBangla(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "আপনার গোপনীয়তা পছন্দ নিয়ন্ত্রণ করুন",
                            style: GoogleFonts.anekBangla(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(height: 30, color: Colors.grey.shade200),

                  _buildSwitchItem(
                    title: "প্রোফাইল দৃশ্যমান",
                    subtitle: "আইনজীবীদের কাছে আপনার প্রোফাইল দেখান",
                    value: controller.profileVisible,
                    onChanged: controller.toggleProfileVisible,
                  ),
                  _buildSwitchItem(
                    title: "ইমেইল দেখান",
                    subtitle: "প্রোফাইলে আপনার ইমেইল প্রদর্শন করুন",
                    value: controller.showEmail,
                    onChanged: controller.toggleShowEmail,
                  ),
                  _buildSwitchItem(
                    title: "ফোন নম্বর দেখান",
                    subtitle: "প্রোফাইলে আপনার ফোন নম্বর প্রদর্শন করুন",
                    value: controller.showPhoneNumber,
                    onChanged: controller.toggleShowPhoneNumber,
                  ),
                ],
              ),
            ),

            SizedBox(height: Get.height * 0.03),

            // Password Change Section
            Container(
              padding: EdgeInsets.all(Get.width * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "পাসওয়ার্ড পরিবর্তন",
                    style: GoogleFonts.anekBangla(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),

                  _buildLabel("বর্তমান পাসওয়ার্ড"),
                  _buildTextField(),

                  SizedBox(height: Get.height * 0.02),

                  _buildLabel("নতুন পাসওয়ার্ড"),
                  _buildTextField(),

                  SizedBox(height: Get.height * 0.02),

                  _buildLabel("পাসওয়ার্ড নিশ্চিত করুন"),
                  _buildTextField(),

                  SizedBox(height: Get.height * 0.03),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        "পাসওয়ার্ড আপডেট করুন",
                        style: GoogleFonts.anekBangla(
                          color: Colors.white,
                          fontSize: 16,
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
      ),
    );
  }

  Widget _buildSwitchItem({
    required String title,
    required String subtitle,
    required RxBool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.anekBangla(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.anekBangla(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Obx(
                () => Switch(
              value: value.value,
              onChanged: onChanged,
              activeThumbColor: AppColors.green,
              activeTrackColor: AppColors.green.withValues(alpha: 0.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.anekBangla(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}