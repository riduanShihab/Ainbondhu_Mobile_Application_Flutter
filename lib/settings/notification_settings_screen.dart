import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/settings_controller.dart';
import '../../utils/app_colors.dart';

class NotificationSettingsScreen extends StatelessWidget {
  NotificationSettingsScreen({super.key});

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
          "বিজ্ঞপ্তি সেটিংস",
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
        child: Container(
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
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.notifications_active,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "বিজ্ঞপ্তি সেটিংস",
                        style: GoogleFonts.anekBangla(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "আপনার বিজ্ঞপ্তি পছন্দ পরিচালনা করুন",
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
                title: "ইমেইল বিজ্ঞপ্তি",
                subtitle: "ইমেইলের মাধ্যমে আপডেট পান",
                value: controller.emailUpdates,
                onChanged: controller.toggleEmailUpdates,
              ),
              _buildSwitchItem(
                title: "SMS বিজ্ঞপ্তি",
                subtitle: "SMS এর মাধ্যমে আপডেট পান",
                value: controller.smsUpdates,
                onChanged: controller.toggleSmsUpdates,
              ),
              _buildSwitchItem(
                title: "পুশ বিজ্ঞপ্তি",
                subtitle: "ব্রাউজার বিজ্ঞপ্তি পান",
                value: controller.pushNotifications,
                onChanged: controller.togglePushNotifications,
              ),
              _buildSwitchItem(
                title: "অ্যাপয়েন্টমেন্ট রিমাইন্ডার",
                subtitle: "আসন্ন অ্যাপয়েন্টমেন্টের জন্য মনে করিয়ে দিন",
                value: controller.appointmentReminders,
                onChanged: controller.toggleAppointmentReminders,
              ),
            ],
          ),
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
}