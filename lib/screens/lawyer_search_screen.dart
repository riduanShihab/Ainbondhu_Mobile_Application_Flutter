import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/lawyer_search_controller.dart';
import '../controllers/nav_controller.dart';
import '../models/lawyer_model.dart';
import '../utils/app_colors.dart';
import '../utils/routes.dart';

class LawyerSearchScreen extends StatelessWidget {
  LawyerSearchScreen({super.key});

  // Inject the search logic
  final LawyerSearchController controller = Get.put(LawyerSearchController());

  // Find the NavController to switch tabs
  final NavController navController = Get.find<NavController>();

  @override
  Widget build(BuildContext context) {
    final double h = Get.height;
    final double w = Get.width;

    return PopScope(
      canPop: false, // Prevent app from closing
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // Switches to Home Tab (Index 0) on system back press
        navController.changeIndex(0);
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textBlack, size: 20),
            onPressed: () {
              // Switches to Home Tab (Index 0)
              navController.changeIndex(0);
            },
          ),
          title: Text(
            'আইনজীবী খুঁজুন',
            style: GoogleFonts.anekBangla(
                color: AppColors.green,
                fontWeight: FontWeight.bold,
                fontSize: w * 0.05),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: AppColors.textBlack),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(w * 0.04),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(w),
              SizedBox(height: h * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.tune, color: AppColors.green, size: w * 0.05),
                      SizedBox(width: w * 0.02),
                      Text('ফিল্টার',
                          style: GoogleFonts.anekBangla(
                              color: AppColors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: w * 0.04)),
                    ],
                  ),
                  GestureDetector(
                    onTap: controller.clearFilters,
                    child: Text('মুছে ফেলুন',
                        style: GoogleFonts.anekBangla(
                            color: AppColors.textGrey, fontSize: w * 0.03)),
                  ),
                ],
              ),
              SizedBox(height: h * 0.012),
              Obx(() => _buildDropdown(
                hint: "দক্ষতা বা ক্যাটাগরি বাছাই করুন",
                value: controller.selectedCategory.value,
                items: controller.categories,
                onChanged: controller.onCategoryChanged,
                w: w,
              )),
              SizedBox(height: h * 0.012),
              Obx(() => _buildDropdown(
                hint: "নির্দিষ্ট সেবা বা অভিজ্ঞতা বাছাই করুন",
                value: controller.selectedSubService.value,
                items: controller.subServices,
                onChanged: controller.onSubServiceChanged,
                isDisabled: controller.selectedCategory.value == null,
                w: w,
              )),
              SizedBox(height: h * 0.012),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ন্যূনতম রেটিং',
                          style: GoogleFonts.anekBangla(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack,
                              fontSize: w * 0.035)),
                      Text(
                          '${controller.minRating.value.toStringAsFixed(1)} / 5.0',
                          style: GoogleFonts.anekBangla(
                              fontWeight: FontWeight.bold,
                              color: AppColors.green,
                              fontSize: w * 0.035)),
                    ],
                  ),
                  Slider(
                    value: controller.minRating.value,
                    min: 0.0,
                    max: 5.0,
                    divisions: 50,
                    activeColor: AppColors.green,
                    inactiveColor: AppColors.borderGrey,
                    onChanged: (val) => controller.updateRating(val),
                  ),
                ],
              )),
              Divider(height: h * 0.04),
              Obx(() => Text(
                '${controller.lawyers.length} জন আইনজীবী পাওয়া গেছে',
                style: GoogleFonts.anekBangla(
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack),
              )),
              SizedBox(height: h * 0.02),
              Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.lawyers.length,
                itemBuilder: (context, index) {
                  return _buildLawyerCard(controller.lawyers[index], w, h);
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(double w) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'নাম বা দক্ষতা অনুযায়ী খুঁজুন',
          hintStyle: GoogleFonts.anekBangla(
              color: AppColors.textGrey, fontSize: w * 0.035),
          prefixIcon:
          Icon(Icons.search, color: AppColors.textGrey, size: w * 0.05),
          border: InputBorder.none,
          contentPadding:
          EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required double w,
    bool isDisabled = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint,
              style: GoogleFonts.anekBangla(
                  color: isDisabled ? AppColors.textGrey : AppColors.textBlack,
                  fontSize: w * 0.035)),
          value: value,
          icon: Icon(Icons.arrow_drop_down,
              color: isDisabled ? AppColors.textGrey : AppColors.textBlack),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item,
                  style: GoogleFonts.anekBangla(
                      color: AppColors.textBlack, fontSize: w * 0.035)),
            );
          }).toList(),
          onChanged: isDisabled ? null : onChanged,
        ),
      ),
    );
  }

  Widget _buildLawyerCard(Lawyer lawyer, double w, double h) {
    return Container(
      margin: EdgeInsets.only(bottom: h * 0.02),
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.green.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: w * 0.18,
                    height: w * 0.18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(lawyer.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: _buildStatusIcon(lawyer.status, w),
                  ),
                ],
              ),
              SizedBox(width: w * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(lawyer.name,
                            style: GoogleFonts.anekBangla(
                                fontSize: w * 0.045,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlack)),
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: AppColors.golden, size: w * 0.04),
                            const SizedBox(width: 4),
                            Text(lawyer.rating.toString(),
                                style: GoogleFonts.anekBangla(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textBlack)),
                          ],
                        ),
                      ],
                    ),
                    Text(lawyer.role,
                        style: GoogleFonts.anekBangla(
                            fontSize: w * 0.03,
                            color: AppColors.golden,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text(lawyer.experience,
                        style: GoogleFonts.anekBangla(
                            fontSize: w * 0.03, color: AppColors.textGrey)),
                    Text(lawyer.cases,
                        style: GoogleFonts.anekBangla(
                            fontSize: w * 0.03, color: AppColors.textGrey)),
                    const SizedBox(height: 4),
                    Text(lawyer.rate,
                        style: GoogleFonts.anekBangla(
                            fontSize: w * 0.035,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textBlack)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.02),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.consultation);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: h * 0.015),
                  ),
                  child: Text('পরামর্শ নিন',
                      style: GoogleFonts.anekBangla(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.035)),
                ),
              ),
              SizedBox(width: w * 0.03),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.lawyerProfile,
                      arguments: lawyer,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.borderGrey),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: h * 0.015),
                  ),
                  child: Text('প্রোফাইল দেখুন',
                      style: GoogleFonts.anekBangla(
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.035)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(String status, double w) {
    IconData icon;
    Color color;

    if (status == 'online') {
      icon = Icons.check_circle;
      color = AppColors.green;
    } else if (status == 'busy') {
      icon = Icons.cancel;
      color = AppColors.textRed;
    } else {
      icon = Icons.circle;
      color = AppColors.golden;
    }

    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
      ),
      padding: const EdgeInsets.all(2),
      child: Icon(icon, color: color, size: w * 0.045),
    );
  }
}