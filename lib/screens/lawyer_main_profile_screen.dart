import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/user_profile_controller.dart';
import '../utils/app_colors.dart';
import '../utils/routes.dart';

class LawyerSideProfileScreen extends StatelessWidget {
  LawyerSideProfileScreen({super.key});

  final UserProfileController userController = Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    final double h = Get.height;
    final double w = Get.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildLawyerHeaderStack(h, w),
            SizedBox(height: h * 0.18),
            _buildGroupedMenu("প্রোফাইল সেটিংস", [
              _simpleTile(
                Icons.person_outline,
                "ব্যক্তিগত তথ্য",
                onTap: () => Get.toNamed(AppRoutes.editProfile),
              ),
              _simpleTile(
                Icons.business_center_outlined,
                "যোগ্যতা ও সার্টিফিকেট",
                onTap: () => Get.toNamed(AppRoutes.professionalProfile),
              ),
              _simpleTile(
                Icons.trending_up,
                "পেমেন্ট তথ্য",
                badge: "নতুন",
                onTap: () => Get.toNamed(AppRoutes.paymentHistory),
              ),
              _simpleTile(
                Icons.notifications_none,
                "নোনিফিকেশন সেটিংস",
                onTap: () => Get.toNamed(AppRoutes.notificationSettings),
              ),
            ], w),
            _buildGroupedMenu("সাধারণ", [
              _simpleTile(
                Icons.security,
                "গোপনীয়তা",
                onTap: () => Get.toNamed(AppRoutes.privacySettings),
              ),
              _simpleTile(Icons.help_outline, "সাহায্য ও সহায়তা"),
              _simpleTile(Icons.info_outline, "অ্যাপ সম্পর্কে", version: "v2.0.0"),
            ], w),
            SizedBox(height: h * 0.03),
            _buildLogoutButton(w),
            SizedBox(height: h * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _buildLawyerHeaderStack(double h, double w) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: h * 0.25,
          width: double.infinity,
          decoration: const BoxDecoration(color: AppColors.green),
          child: Padding(
            padding: EdgeInsets.only(top: h * 0.06, left: w * 0.05),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: h * 0.1,
                  width: h * 0.1,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: NetworkImage('https://i.pravatar.cc/150?img=11'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: w * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.005),
                    Text(
                      "আবদুল আজীম",
                      style: GoogleFonts.anekBangla(
                        color: AppColors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "অভিজ্ঞ আইনজীবী",
                      style: GoogleFonts.anekBangla(
                        color: AppColors.white.withValues(alpha: 0.8),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "বার কাউন্সিল নং: ৭৮৬০৯২",
                      style: GoogleFonts.anekBangla(
                        color: AppColors.white.withValues(alpha: 0.6),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: h * 0.22,
          left: w * 0.04,
          right: w * 0.04,
          child: _buildToggleCard(w),
        ),
        Positioned(
          top: h * 0.30,
          left: w * 0.04,
          right: w * 0.04,
          child: _buildStatsCard(),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "আইনজীবী মোড",
            style: GoogleFonts.anekBangla(
              color: AppColors.green,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Obx(
                () => Switch(
              value: userController.isLawyerMode.value,
              onChanged: (v) => userController.toggleMode(v),
              activeThumbColor: AppColors.green,
            ),
          ),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statCol("৩", "মোট সাক্ষাৎ"),
          _vDivider(),
          _statCol("৪", "মোট সেবা"),
          _vDivider(),
          _statCol("৪.৮", "রেটিং", isRating: true),
        ],
      ),
    );
  }

  Widget _vDivider() => Container(
    height: 30,
    width: 1,
    color: AppColors.borderGrey.withValues(alpha: 0.5),
  );

  Widget _statCol(String v, String l, {bool isRating = false}) => Column(
    children: [
      Row(
        children: [
          if (isRating)
            const Icon(
              Icons.star,
              color: AppColors.green,
              size: 18,
            ),
          Text(
            v,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.green,
            ),
          ),
        ],
      ),
      Text(
        l,
        style: const TextStyle(
          color: AppColors.textGrey,
          fontSize: 12,
        ),
      )
    ],
  );

  Widget _buildGroupedMenu(String header, List<Widget> tiles, double w) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.inputBackground),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              header,
              style: GoogleFonts.anekBangla(
                fontWeight: FontWeight.bold,
                color: AppColors.textGrey,
              ),
            ),
          ),
          const Divider(height: 1),
          ...tiles,
        ],
      ),
    );
  }

  Widget _simpleTile(
      IconData i,
      String t, {
        String? badge,
        String? version,
        VoidCallback? onTap,
      }) =>
      Column(
        children: [
          ListTile(
            onTap: onTap,
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                i,
                color: AppColors.textGrey,
                size: 22,
              ),
            ),
            title: Text(
              t,
              style: GoogleFonts.anekBangla(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.textBlack,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (badge != null)
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.green.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        color: AppColors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (version != null)
                  Text(
                    version,
                    style: const TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 12,
                    ),
                  ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.textGrey,
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            indent: 60,
            color: AppColors.inputBackground,
          ),
        ],
      );

  Widget _buildLogoutButton(double w) => Padding(
    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
    child: TextButton(
      onPressed: () => Get.back(),
      style: TextButton.styleFrom(
        backgroundColor: AppColors.redwhite,
        minimumSize: Size(w, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        "লগ আউট করুন",
        style: GoogleFonts.anekBangla(
          color: AppColors.textRed,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
