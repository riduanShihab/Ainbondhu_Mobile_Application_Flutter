import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/requested_appointments_controller.dart';
import '../controllers/nav_controller.dart';
import '../widgets/custom_nav_bar.dart';
import '../utils/app_colors.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  AppointmentDetailsScreen({super.key});

  final RequestedAppointmentsController controller = Get.find<RequestedAppointmentsController>();
  final NavController navController = Get.find<NavController>();

  @override
  Widget build(BuildContext context) {

    final double w = Get.width;
    final double h = Get.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('অ্যাপয়েন্টমেন্ট বিস্তারিত',
                style: GoogleFonts.anekBangla(
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.05
                )),
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.textBlack),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lawyer Header Section
            _buildSection(
              w,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: w * 0.09,
                    backgroundColor: AppColors.inputBackground,
                    child: Icon(Icons.person, size: w * 0.1, color: AppColors.textGrey),
                  ),
                  SizedBox(width: w * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('অ্যাডভোকেট মাহমুদ হাসান',
                          style: GoogleFonts.anekBangla(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textBlack)),
                      Text('ফৌজদারি আইন',
                          style: GoogleFonts.anekBangla(color: AppColors.textGrey)),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.025),
            Text('বিষয়', style: GoogleFonts.anekBangla(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
            _buildSection(
              w,
              child: Text('পারিবারিক আইন পরামর্শ',
                  style: GoogleFonts.anekBangla(fontSize: 16, color: AppColors.textBlack)),
            ),

            SizedBox(height: h * 0.025),
            Text('যোগাযোগ', style: GoogleFonts.anekBangla(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
            _buildSection(
              w,
              child: Column(
                children: [
                  _buildIconRow(Icons.phone_outlined, '+৮৮০১৭১১১১১১১১'),
                  const Divider(color: AppColors.borderGrey),
                  _buildIconRow(Icons.email_outlined, 'mahmud@legalease.com'),
                ],
              ),
            ),

            SizedBox(height: h * 0.025),
            Text('বার্তা', style: GoogleFonts.anekBangla(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
            Container(
              width: w,
              padding: EdgeInsets.all(w * 0.04),
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'আমার পরিবারের সম্পত্তি বিষয়ক একটি বিরোধ নিয়ে পরামর্শ প্রয়োজন। এটি একটি জরুরি বিষয় এবং আমি যত দ্রুত সম্ভব একটি অ্যাপয়েন্টমেন্ট পেতে চাই।',
                style: GoogleFonts.anekBangla(fontSize: 15, color: AppColors.textGrey),
              ),
            ),

            SizedBox(height: h * 0.05),

            // Responsive Buttons
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.inputBackground,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text('বাতিল করুন',
                          style: GoogleFonts.anekBangla(color: AppColors.textBlack, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(width: w * 0.04),
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () => controller.showCancelDialog(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.textRed,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text('অনুরোধ বাতিল করুন',
                          style: GoogleFonts.anekBangla(color: AppColors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => CustomNavBar(
        selectedIndex: navController.selectedIndex.value,
        onItemTapped: (index) {
          navController.changeIndex(index);
          if (index == 0) Get.offAllNamed('/home');
        },
      )),
    );
  }

  // Helper with responsive width parameter
  Widget _buildSection(double w, {required Widget child}) {
    return Container(
      width: w,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey.withValues(alpha: 0.5)),
      ),
      child: child,
    );
  }

  Widget _buildIconRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textGrey, size: 22),
          const SizedBox(width: 15),
          Text(text, style: GoogleFonts.anekBangla(fontSize: 16, color: AppColors.textBlack)),
        ],
      ),
    );
  }
}