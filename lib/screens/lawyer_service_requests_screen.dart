import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/lawyer_service_requests_controller.dart';
import '../utils/app_colors.dart';
import '../utils/routes.dart';

class LawyerServiceRequestsScreen extends StatelessWidget {
  LawyerServiceRequestsScreen({super.key});

  final LawyerServiceRequestsController controller = Get.put(
    LawyerServiceRequestsController(),
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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/lawyer_profile_icon.png',
            ),
          ),
        ),
        title: Column(
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
              style: GoogleFonts.inter(color: Colors.grey, fontSize: w * 0.03),
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
                      'সেবা অনুরোধ',
                      style: GoogleFonts.anekBangla(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: w * 0.03),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.lawyerMyServices);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(vertical: h * 0.015),
                    ),

                    child: Text(
                      'আমার সেবা',
                      style: GoogleFonts.anekBangla(
                        color: AppColors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(
              vertical: h * 0.015,
              horizontal: w * 0.04,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ফিল্টার: ',
                  style: GoogleFonts.anekBangla(
                    color: Colors.grey[700],
                    fontSize: w * 0.04,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(
                      () => Row(
                        children: controller.filters.map((filter) {
                          bool isSelected =
                              controller.selectedFilter.value == filter;
                          return Container(
                            margin: EdgeInsets.only(left: w * 0.02),
                            child: ChoiceChip(
                              label: Text(
                                filter,
                                style: GoogleFonts.anekBangla(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black54,
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (bool selected) {
                                controller.changeFilter(filter);
                              },
                              selectedColor: AppColors.green,
                              backgroundColor: Colors.grey[200],
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                itemCount: controller.filteredRequests.length,
                itemBuilder: (context, index) {
                  return _buildRequestCard(
                    w,
                    h,
                    controller.filteredRequests[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(double w, double h, Map<String, dynamic> request) {
    String status = request['status'];
    Color statusColor = Colors.orange;
    if (status == 'সম্পূর্ণ') statusColor = Colors.blue;
    if (status == 'গৃহীত') statusColor = AppColors.green;
    if (status == 'প্রত্যাখ্যাত') statusColor = Colors.red;

    return Container(
      margin: EdgeInsets.only(bottom: h * 0.02),
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: status == 'প্রত্যাখ্যাত'
            ? Border.all(color: Colors.red.withValues(alpha: 0.3), width: 1)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'অনুরোধের আইডি',
                    style: GoogleFonts.anekBangla(
                      color: Colors.grey,
                      fontSize: w * 0.03,
                    ),
                  ),
                  Text(
                    request['id'],
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: w * 0.035,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'আবেদনকারীর নাম',
                    style: GoogleFonts.anekBangla(
                      color: Colors.grey,
                      fontSize: w * 0.03,
                    ),
                  ),
                  Text(
                    request['applicantName'],
                    style: GoogleFonts.anekBangla(
                      fontWeight: FontWeight.bold,
                      fontSize: w * 0.035,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: h * 0.015),
          Text(
            'সেবা',
            style: GoogleFonts.anekBangla(
              color: Colors.grey,
              fontSize: w * 0.03,
            ),
          ),
          Text(
            request['serviceTitle'],
            style: GoogleFonts.anekBangla(
              fontWeight: FontWeight.bold,
              fontSize: w * 0.04,
            ),
          ),

          SizedBox(height: h * 0.01),
          Text(
            'শ্রেণীকরণ',
            style: GoogleFonts.anekBangla(
              color: Colors.grey,
              fontSize: w * 0.03,
            ),
          ),
          Text(
            request['classification'],
            style: GoogleFonts.anekBangla(
              fontWeight: FontWeight.bold,
              fontSize: w * 0.04,
            ),
          ),

          SizedBox(height: h * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'পরিমাণ',
                    style: GoogleFonts.anekBangla(
                      color: Colors.grey,
                      fontSize: w * 0.03,
                    ),
                  ),
                  Text(
                    request['price'],
                    style: GoogleFonts.anekBangla(
                      color: AppColors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: w * 0.04,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'তারিখ',
                    style: GoogleFonts.anekBangla(
                      color: Colors.grey,
                      fontSize: w * 0.03,
                    ),
                  ),
                  Text(
                    request['date'],
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: w * 0.035,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: h * 0.02),
          Text(
            'স্ট্যাটাস',
            style: GoogleFonts.anekBangla(
              color: Colors.grey,
              fontSize: w * 0.03,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: statusColor.withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (status == 'সম্পূর্ণ')
                  Icon(
                    Icons.check_circle_outline,
                    size: 14,
                    color: statusColor,
                  ),
                if (status == 'সম্পূর্ণ') SizedBox(width: 4),
                Text(
                  status,
                  style: GoogleFonts.anekBangla(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.03,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),

          if (status == 'অপেক্ষায়')
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.acceptRequest(request['id']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                    ),
                    child: Text(
                      'গ্রহণ করুন',
                      style: GoogleFonts.anekBangla(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: w * 0.03),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.rejectRequest(request['id']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.close, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'প্রত্যাখ্যান করুন',
                          style: GoogleFonts.anekBangla(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          else if (status == 'সম্পূর্ণ')
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                    ),
                    child: Text(
                      'সেবা সম্পন্ন করুন',
                      style: GoogleFonts.anekBangla(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: w * 0.03),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Chat logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2979FF),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'আলোচনা করুন',
                          style: GoogleFonts.anekBangla(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          else if (status == 'প্রত্যাখ্যাত')
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCDD2), // Light red
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    'সেবা অসম্পূর্ণ',
                    style: GoogleFonts.anekBangla(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'ক্লায়েন্ট জানিয়েছেন যে আপনি এই সেবা সম্পূর্ণ করেননি।',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.anekBangla(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Request ID: ${request['id']}',
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2962FF),
                    ),
                    child: Text(
                      'ফিরে যান',
                      style: GoogleFonts.anekBangla(color: Colors.white),
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
