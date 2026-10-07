import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/requested_appointments_controller.dart';
import '../controllers/nav_controller.dart';
import '../widgets/custom_nav_bar.dart';
import '../utils/routes.dart';
import '../utils/app_colors.dart';

class RequestedAppointmentsScreen extends StatelessWidget {
  RequestedAppointmentsScreen({super.key});

  final RequestedAppointmentsController controller = Get.put(RequestedAppointmentsController());
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: w,
            padding: EdgeInsets.symmetric(vertical: h * 0.03, horizontal: w * 0.04),
            color: AppColors.green,
            child: Column(
              children: [
                Text(
                  'অনুরোধকৃত অ্যাপয়েন্টমেন্ট',
                  style: GoogleFonts.anekBangla(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'আপনার মুলতুবি অ্যাপয়েন্টমেন্ট অনুরোধ',
                  style: GoogleFonts.anekBangla(
                    color: AppColors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          ///  SUMMARY COUNTER
          Padding(
            padding: EdgeInsets.all(w * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'মোট অনুরোধ:',
                  style: GoogleFonts.anekBangla(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack,
                  ),
                ),
                Obx(() => Text(
                  '${controller.appointments.length}',
                  style: GoogleFonts.anekBangla(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey,
                  ),
                )),
              ],
            ),
          ),

          const Divider(thickness: 1, height: 1, color: AppColors.borderGrey),

          ///  APPOINTMENTS LIST
          Expanded(
            child: Obx(() => ListView.separated(
              itemCount: controller.appointments.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.borderGrey),
              itemBuilder: (context, index) {
                final item = controller.appointments[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Lawyer Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['lawyerName'] ?? '',
                              style: GoogleFonts.anekBangla(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlack,
                              ),
                            ),
                            Text(
                              item['category'] ?? '',
                              style: GoogleFonts.anekBangla(
                                fontSize: 14,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),


                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.appointmentDetails);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
                          elevation: 0,
                        ),
                        child: Text(
                          'বিস্তারিত দেখুন',
                          style: GoogleFonts.anekBangla(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
          ),
        ],
      ),

      ///  BOTTOM NAVIGATION
      bottomNavigationBar: Obx(() => CustomNavBar(
        selectedIndex: navController.selectedIndex.value,
        onItemTapped: (index) {
          navController.changeIndex(index);
          if (index == 0) Get.offAllNamed(AppRoutes.home);
        },
      )),
    );
  }
}