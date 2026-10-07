import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/lawyer_my_services_controller.dart';
import '../utils/app_colors.dart';
import '../utils/routes.dart';

class LawyerMyServicesScreen extends StatelessWidget {
  LawyerMyServicesScreen({super.key});

  final LawyerMyServicesController controller = Get.put(
    LawyerMyServicesController(),
  );

  @override
  Widget build(BuildContext context) {
    final double w = Get.width;
    final double h = Get.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F1EB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/lawyer_profile_icon.png',
              ),
              radius: w * 0.05,
            ),
            SizedBox(width: w * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'রাকিব ভুঁইয়া',
                  style: GoogleFonts.anekBangla(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.045,
                  ),
                ),
                Text(
                  'Environmental Law',
                  style: GoogleFonts.inter(
                    color: Colors.grey,
                    fontSize: w * 0.03,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: h * 0.02,
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.lawyerServiceRequests);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(vertical: h * 0.015),
                    ),
                    child: Text(
                      'সেবা অনুরোধ',
                      style: GoogleFonts.anekBangla(
                        color: AppColors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: w * 0.03),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(vertical: h * 0.015),
                    ),
                    child: Text(
                      'আমার সেবা',
                      style: GoogleFonts.anekBangla(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(w * 0.04),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'আমার সেবাসমূহ',
                    style: GoogleFonts.anekBangla(
                      fontSize: w * 0.055,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'আপনার যুক্ত করা সকল সেবা এখানে দেখুন\nএবং পরিচালনা করুন',
                    style: GoogleFonts.anekBangla(
                      fontSize: w * 0.035,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                itemCount: controller.services.length,
                itemBuilder: (context, index) {
                  final service = controller.services[index];
                  return _buildServiceCard(w, h, service);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(double w, double h, Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.only(bottom: h * 0.02),
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              service['title'],
              style: GoogleFonts.anekBangla(color: Colors.white, fontSize: 12),
            ),
          ),
          SizedBox(height: h * 0.01),
          Text(
            service['title'],
            style: GoogleFonts.anekBangla(
              fontSize: w * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            service['category'],
            style: GoogleFonts.anekBangla(
              fontSize: w * 0.035,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: h * 0.01),
          Text(
            service['description'],
            style: GoogleFonts.anekBangla(
              fontSize: w * 0.038,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: h * 0.02),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'মূল্য পরিসীমা',
                style: GoogleFonts.anekBangla(color: Colors.grey),
              ),
              Text(
                service['priceRange'],
                style: GoogleFonts.anekBangla(
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: w * 0.04,
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.02),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.lawyerServiceDetails);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF3F4F6),
                foregroundColor: AppColors.green,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'বিস্তারিত দেখুন',
                style: GoogleFonts.anekBangla(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
