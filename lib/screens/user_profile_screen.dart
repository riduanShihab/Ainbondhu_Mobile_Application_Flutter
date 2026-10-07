import 'package:ain_bondhu_app/screens/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/user_profile_controller.dart';
import '../utils/app_colors.dart';
import '../utils/routes.dart';


class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  // We use Get.find because MainWrapper already put the controller in memory
  final UserProfileController controller = Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    final double h = Get.height;
    final double w = Get.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderStack(h, w),
            SizedBox(height: h * 0.16),
            _buildUserMenuList(w),
            SizedBox(height: h * 0.02),
            _buildLogoutButton(w),
            SizedBox(height: h * 0.01),
            const Text("Version 1.0.0",
                style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
            SizedBox(height: h * 0.02),
            _buildRegisterButton(w, h),
            SizedBox(height: h * 0.05),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderStack(double h, double w) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: h * 0.38,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: h * 0.02),
              Obx(() => Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: h * 0.065,
                    backgroundColor: AppColors.white.withOpacity(0.2),
                    child: CircleAvatar(
                      radius: h * 0.06,
                      // Accessing via .value.image (Model approach)
                      backgroundImage: NetworkImage(controller.userProfile.value.image),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => const EditProfileScreen()),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.white,
                      child: Icon(Icons.edit_outlined, size: 18, color: AppColors.green),
                    ),
                  )
                ],
              )),
              SizedBox(height: h * 0.01),
              Obx(() => Text(
                  controller.userProfile.value.name, // Model property
                  style: GoogleFonts.anekBangla(
                      color: AppColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)
              )),
              Obx(() => Text(
                  controller.userProfile.value.email, // Model property
                  style: const TextStyle(color: Colors.white70, fontSize: 14)
              )),
              SizedBox(height: h * 0.04),
            ],
          ),
        ),

        Positioned(
            top: h * 0.34,
            left: w * 0.04,
            right: w * 0.04,
            child: _buildToggleCard(w)
        ),

        Positioned(
            top: h * 0.42,
            left: w * 0.04,
            right: w * 0.04,
            child: _buildStatsCard()
        ),
      ],
    );
  }

  Widget _buildToggleCard(double w) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: 2),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4)
          )]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("আইনজীবী মোড", // Clearer label for what the switch does
              style: GoogleFonts.anekBangla(
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)
          ),
          Obx(() => Switch(
            value: controller.isLawyerMode.value,
            onChanged: (v) => controller.toggleMode(v),
            activeColor: AppColors.green,
          )),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5)
          )]
      ),
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statCol(controller.userProfile.value.totalInterviews.toString(), "মোট সাক্ষাৎ"),
          _vDivider(),
          _statCol(controller.userProfile.value.services.toString(), "সেবা"),
          _vDivider(),
          _statCol(controller.userProfile.value.completed.toString(), "সম্পন্ন"),
        ],
      )),
    );
  }

  Widget _vDivider() => Container(height: 30, width: 1, color: AppColors.borderGrey.withOpacity(0.5));

  Widget _statCol(String v, String l) => Column(
      children: [
        Text(v, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.green)),
        Text(l, style: const TextStyle(color: AppColors.textGrey, fontSize: 12))
      ]
  );

  Widget _buildUserMenuList(double w) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.04),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.inputBackground)),
      child: Column(
        children: [
          _tile(Icons.person_outline, "প্রোফাইল", "আপনার প্রোফাইল পরিবর্তন করুন",
              onTap: () => Get.toNamed(AppRoutes.editProfile)),

          _tile(Icons.add_circle_outline, "নতুন অ্যাপয়েন্টমেন্ট", "নতুন অ্যাপয়েন্টমেন্ট নিন",
              onTap: () => Get.toNamed(AppRoutes.lawyer_search)),

          _tile(Icons.history, "অনুরোধকৃত অ্যাপয়েন্টমেন্ট", "৩টি অনুরোধ",
              onTap: () => Get.toNamed(AppRoutes.requestedAppointments)),

          _tile(Icons.work_outline, "সেবা দেখুন", "আপনার সেবাগুলো দেখুন",
            onTap: () => Get.toNamed(AppRoutes.requestedDetails),),

          _tile(Icons.notifications_none, "বিজ্ঞপ্তি সেটিংস", "আপনার পছন্দ নিশ্চিত করুন",
              onTap: () => Get.toNamed(AppRoutes.notificationSettings)),

          _tile(Icons.lock_outline, "গোপনীয়তা ও সুরক্ষা", "পাসওয়ার্ড ও ডাটা",
              onTap: () => Get.toNamed(AppRoutes.privacySettings)),

          _tile(Icons.settings_outlined, "সেটিংস", "অ্যাপের পছন্দসমূহ",
              onTap: () => Get.toNamed(AppRoutes.settings)),

          _tile(Icons.help_outline, "Help & Support", "FAQs & contact",
              isLast: true,
              onTap: () {

              }),
        ],
      ),
    );
  }

  Widget _tile(IconData i, String t, String s, {bool isLast = false, VoidCallback? onTap}) => Column(
    children: [
      ListTile(
          onTap: onTap,
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.inputBackground, borderRadius: BorderRadius.circular(10)),
            child: Icon(i, color: AppColors.green, size: 22),
          ),
          title: Text(t, style: GoogleFonts.anekBangla(fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.textBlack)),
          subtitle: Text(s, style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textGrey)
      ),
      if (!isLast) Divider(height: 1, indent: 70, color: AppColors.inputBackground),
    ],
  );

  Widget _buildRegisterButton(double w, double h) => Padding(
    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
    child: OutlinedButton(
      onPressed: () {
      },
      style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.green, width: 1.5),
          minimumSize: Size(double.infinity, h * 0.065),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
      ),
      child: Text("আইনজীবী রেজিস্টার", style: GoogleFonts.anekBangla(color: AppColors.green, fontWeight: FontWeight.bold, fontSize: 18)),
    ),
  );

  Widget _buildLogoutButton(double w) => Padding(
    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
    child: Container(
      decoration: BoxDecoration(color: AppColors.textRed.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () => controller.logout(),
        leading: const Icon(Icons.logout, color: AppColors.textRed),
        title: Text("লগ আউট", style: GoogleFonts.anekBangla(color: AppColors.textRed, fontWeight: FontWeight.bold)),
      ),
    ),
  );
}