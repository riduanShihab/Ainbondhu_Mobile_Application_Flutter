import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/consultation_controller.dart';
import '../controllers/nav_controller.dart';
import '../utils/routes.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_nav_bar.dart';

class ConsultationScreen extends StatelessWidget {
  ConsultationScreen({super.key});

  final ConsultationController controller = Get.put(ConsultationController());
  final NavController navController = Get.find<NavController>();

  @override
  Widget build(BuildContext context) {

    final double w = Get.width;
    final double h = Get.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textBlack, size: w * 0.06),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'পরামর্শ নিন',
          style: GoogleFonts.anekBangla(
            color: AppColors.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: w * 0.05, // Responsive title
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: w,
              padding: EdgeInsets.symmetric(vertical: h * 0.035),
              color: AppColors.green,
              child: Center(
                child: Text(
                  'পরামর্শের সময় ঠিক করুন',
                  style: GoogleFonts.anekBangla(
                    color: AppColors.white,
                    fontSize: w * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(w * 0.04),
              child: Column(
                children: [
                  ///  PERSONAL INFO
                  _buildSectionCard(w, h, 'ব্যক্তিগত তথ্য', [
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(w, h, 'নাম (প্রথম অংশ)', 'রবার্ট',
                                  (val) => controller.firstName.value = val),
                        ),
                        SizedBox(width: w * 0.03),
                        Expanded(
                          child: _buildTextField(w, h, 'নাম (শেষ অংশ)', 'লি',
                                  (val) => controller.lastName.value = val),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.02),
                    _buildTextField(w, h, 'ইমেইল', 'jhon.doe@gmail.com',
                            (val) => controller.email.value = val),
                    SizedBox(height: h * 0.02),
                    _buildTextField(w, h, 'ফোন নম্বর', '+880100000000',
                            (val) => controller.phone.value = val),
                  ]),

                  SizedBox(height: h * 0.02),

                  ///  LAWYER SELECTION
                  _buildSectionCard(w, h, 'আইনজীবী নির্বাচন করুন', [
                    Obx(() => DropdownButtonFormField<String>(
                      decoration: _inputDecoration(w, ''),
                      icon: Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey, size: w * 0.06),
                      hint: Text('আইনজীবী নির্বাচন করুন',
                          style: GoogleFonts.anekBangla(color: AppColors.textGrey, fontSize: w * 0.035)),
                      initialValue: controller.selectedLawyer.value,
                      items: controller.lawyers.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: GoogleFonts.anekBangla(color: AppColors.textBlack, fontSize: w * 0.04)),
                        );
                      }).toList(),
                      onChanged: (val) => controller.selectedLawyer.value = val,
                    )),
                  ]),

                  SizedBox(height: h * 0.02),


                  _buildSectionCard(w, h, 'পরামর্শের বিবরণ', [
                    _buildTextField(w, h, 'বিষয়', 'আপনাকে আমরা কীভাবে সহায়তা করতে পারি?',
                            (val) => controller.subject.value = val),
                    SizedBox(height: h * 0.02),
                    _buildTextField(
                      w, h,
                      'আপনার সমস্যা এখানে লিখুন...',
                      'আপনার আইনগত প্রয়োজনগুলো আমাদের জানান...',
                          (val) => controller.problemDescription.value = val,
                      maxLines: 5,
                    ),
                  ]),

                  SizedBox(height: h * 0.04),

                  /// SUBMIT BUTTON
                  SizedBox(
                    width: w,
                    height: h * 0.065,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(w * 0.03)),
                        elevation: 0,
                      ),
                      onPressed: () => controller.submitForm(),
                      child: Text(
                        'পরামর্শ নিন',
                        style: GoogleFonts.anekBangla(
                            fontSize: w * 0.045,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Obx(() => CustomNavBar(
        selectedIndex: navController.selectedIndex.value,
        onItemTapped: (index) {
          navController.changeIndex(index);
          if (index == 0) Get.offAllNamed(AppRoutes.home);
        },
      )),
    );
  }

  /// HELPER: SECTION CARD
  Widget _buildSectionCard(double w, double h, String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(w * 0.04),
        border: Border.all(color: AppColors.borderGrey.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.anekBangla(
                  fontSize: w * 0.045, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
          SizedBox(height: h * 0.015),
          ...children,
        ],
      ),
    );
  }

  /// HELPER: TEXT FIELD
  Widget _buildTextField(double w, double h, String label, String hint, Function(String) onChanged,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.anekBangla(
                fontWeight: FontWeight.w500,
                color: AppColors.textBlack,
                fontSize: w * 0.038)),
        SizedBox(height: h * 0.008),
        TextField(
          onChanged: onChanged,
          maxLines: maxLines,
          style: GoogleFonts.anekBangla(color: AppColors.textBlack, fontSize: w * 0.04),
          decoration: _inputDecoration(w, hint),
        ),
      ],
    );
  }

  /// HELPER: INPUT DECORATION
  InputDecoration _inputDecoration(double w, String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.anekBangla(
          color: AppColors.textGrey.withValues(alpha: 0.7), fontSize: w * 0.035),
      filled: true,
      fillColor: AppColors.inputBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(w * 0.03),
        borderSide: const BorderSide(color: AppColors.borderGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(w * 0.03),
        borderSide: const BorderSide(color: AppColors.borderGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(w * 0.03),
        borderSide: const BorderSide(color: AppColors.green, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: Get.height * 0.015),
    );
  }
}