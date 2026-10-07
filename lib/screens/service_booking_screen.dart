import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/service_booking_controller.dart';
import '../controllers/nav_controller.dart';
import '../widgets/custom_nav_bar.dart';
import '../utils/app_colors.dart';
import '../utils/routes.dart';

class ServiceBookingScreen extends StatelessWidget {
  ServiceBookingScreen({super.key});

  final ServiceBookingController controller = Get.put(ServiceBookingController());
  final NavController navController = Get.find<NavController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navController.selectedIndex.value = 3;
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            if (controller.currentStep.value == 2) {
              controller.goBackToForm();
            } else if (controller.currentStep.value == 3) {
              Get.back();
            } else {
              Get.back();
            }
          },
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text('সেবা', style: GoogleFonts.anekBangla(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            Text('চুক্তিপত্র তৈরি - ব্যবসায়িক চুক্তি',
                style: GoogleFonts.anekBangla(color: AppColors.white.withValues(alpha: 0.7), fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepper(controller.currentStep.value),
            const SizedBox(height: 24),
            if (controller.currentStep.value == 1)
              _buildStep1Form()
            else if (controller.currentStep.value == 2)
              _buildStep2Review()
            else if (controller.currentStep.value == 3)
                _buildStep3Success(),
          ],
        )),
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

  Widget _buildStep1Form() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('আপনার বিবরণ প্রদান করুন', style: GoogleFonts.anekBangla(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
        const SizedBox(height: 12),
        _buildGreenSummaryCard(),
        const SizedBox(height: 20),
        _buildLabel('পূর্ণ নাম *'),
        _buildTextField(controller.nameController, 'আপনার নাম'),
        _buildLabel('ইমেইল ঠিকানা *'),
        _buildTextField(controller.emailController, 'আপনার ইমেইল'),
        _buildLabel('ফোন নম্বর *'),
        _buildTextField(controller.phoneController, '+8801XXXXXXXXX', isNumber: true),
        _buildLabel('বিবরণ *'),
        _buildTextField(controller.descController, 'বিস্তারিত বর্ণনা করুন', maxLines: 4),
        const SizedBox(height: 20),
        Text('ডকুমেন্ট আপলোড করুন', style: GoogleFonts.anekBangla(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textBlack)),
        const SizedBox(height: 8),
        _buildUploadBox(),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: controller.goToReviewStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('পরবর্তী', style: GoogleFonts.anekBangla(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.borderGrey,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: Text('বাতিল', style: GoogleFonts.anekBangla(color: AppColors.textBlack, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep2Review() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('আপনার অনুরোধ পর্যালোচনা করুন', style: GoogleFonts.anekBangla(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
        const SizedBox(height: 16),
        _buildGreenSummaryCard(),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.green, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('আপনার তথ্য', style: GoogleFonts.anekBangla(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
              const SizedBox(height: 12),
              _buildReviewField("নাম", controller.nameController.text),
              _buildReviewField("ইমেইল", controller.emailController.text),
              _buildReviewField("ফোন", controller.phoneController.text),
              _buildReviewField("বিবরণ", controller.descController.text),
              const SizedBox(height: 10),
              Text('ডকুমেন্ট', style: GoogleFonts.anekBangla(fontSize: 12, color: AppColors.textGrey)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.green),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.upload_file, size: 20, color: AppColors.textGrey),
                    const SizedBox(width: 8),
                    Expanded(child: Text(
                        controller.selectedFileName.value.isEmpty ? "কোনো ফাইল নেই" : controller.selectedFileName.value,
                        style: GoogleFonts.anekBangla(fontWeight: FontWeight.bold, color: AppColors.textBlack)
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.golden.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'অনুগ্রহ করে নিশ্চিত করুন: আপনার তথ্য সঠিক এবং সম্পূর্ণ। একবার নিশ্চিত করার পরে, আপনার অনুরোধ আইনজীবীর কাছে পাঠানো হবে।',
            style: GoogleFonts.anekBangla(color: AppColors.golden, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: controller.confirmRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('অনুরোধ নিশ্চিত করুন', style: GoogleFonts.anekBangla(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: controller.goBackToForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.borderGrey,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: Text('ফিরে যান', style: GoogleFonts.anekBangla(color: AppColors.textBlack, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep3Success() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text('আপনার অনুরোধ পর্যালোচনা করুন', style: GoogleFonts.anekBangla(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.green, width: 1),
            ),
            child: const Icon(Icons.check, color: AppColors.green, size: 40),
          ),
          const SizedBox(height: 24),
          Text('অনুরোধ সফলভাবে পাঠানো হয়েছে!', style: GoogleFonts.anekBangla(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  'আপনার অনুরোধ আইনজীবীর কাছে পাঠানো হয়েছে। তিনি শীঘ্রই আপনার সাথে যোগাযোগ করবেন।',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.anekBangla(color: AppColors.primaryBlue, fontSize: 14),
                ),
                const SizedBox(height: 10),
                Text(
                  'আমরা আপনাকে ইমেইল এবং এসএমএসের মাধ্যমে আপডেট পাঠাব।',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.anekBangla(color: AppColors.primaryBlue, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonGreen,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('চ্যাট করুন', style: GoogleFonts.anekBangla(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.borderGrey,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: Text('আরও সেবা দেখুন', style: GoogleFonts.anekBangla(color: AppColors.textBlack, fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGreenSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text('সেবার বিবরণ', style: GoogleFonts.anekBangla(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('আইনজীবী', style: GoogleFonts.anekBangla(fontSize: 10, color: AppColors.textGrey)),
                  Text('আব্দুল্লাহ হোসেন', style: GoogleFonts.anekBangla(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
                  const SizedBox(height: 8),
                  Text('মূল্য', style: GoogleFonts.anekBangla(fontSize: 10, color: AppColors.textGrey)),
                  Obx(() => Text(controller.price.value, style: GoogleFonts.anekBangla(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.green))),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('প্যাকেজ', style: GoogleFonts.anekBangla(fontSize: 10, color: AppColors.textGrey)),
                  Obx(() => Text(controller.packageName.value, style: GoogleFonts.anekBangla(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textBlack))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.anekBangla(fontSize: 12, color: AppColors.textGrey)),
          Text(value, style: GoogleFonts.anekBangla(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
        ],
      ),
    );
  }

  Widget _buildStepper(int step) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStepCircle('১', 'বিস্তারিত তথ্য', state: step >= 1 ? (step > 1 ? 2 : 1) : 0),
        _buildStepLine(isActive: step > 1),
        _buildStepCircle('২', 'পর্যালোচনা', state: step >= 2 ? (step > 2 ? 2 : 1) : 0),
        _buildStepLine(isActive: step > 2),
        _buildStepCircle('৩', 'নিশ্চিতকরণ', state: step == 3 ? 1 : 0),
      ],
    );
  }

  Widget _buildStepCircle(String number, String label, {required int state}) {
    Color circleColor = state == 0 ? AppColors.borderGrey : AppColors.green;
    bool isCompleted = state == 2;

    return Column(
      children: [
        Container(
          width: 40, height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isCompleted ? circleColor : (state == 1 ? circleColor : AppColors.inputBackground),
            shape: BoxShape.circle,
          ),
          child: isCompleted
              ? const Icon(Icons.check, color: AppColors.white)
              : Text(number, style: GoogleFonts.anekBangla(
              color: state >= 1 ? AppColors.white : AppColors.textBlack,
              fontWeight: FontWeight.bold, fontSize: 16)
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.anekBangla(fontSize: 10, color: AppColors.textBlack)),
      ],
    );
  }

  Widget _buildStepLine({required bool isActive}) {
    return Expanded(
      child: Container(
        height: 3,
        color: isActive ? AppColors.green : AppColors.borderGrey,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String hint, {int maxLines = 1, bool isNumber = false}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.anekBangla(color: AppColors.textGrey),
        fillColor: AppColors.inputBackground,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 12),
      child: Text(text, style: GoogleFonts.anekBangla(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textBlack)),
    );
  }

  Widget _buildUploadBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        children: [
          const Icon(Icons.file_upload_outlined, size: 30, color: AppColors.textGrey),
          const SizedBox(height: 8),
          Obx(() => Text(
              controller.selectedFileName.value.isEmpty
                  ? 'ডকুমেন্ট আপলোড করতে ক্লিক করুন'
                  : 'নির্বাচিত ফাইল: ${controller.selectedFileName.value}',
              style: GoogleFonts.anekBangla(color: AppColors.textGrey, fontSize: 12)
          )),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: controller.pickFile,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonGreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: Text('ফাইল নির্বাচন করুন', style: GoogleFonts.anekBangla(color: AppColors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}