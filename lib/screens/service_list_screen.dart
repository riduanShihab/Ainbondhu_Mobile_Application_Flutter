import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/service_list_controller.dart';
import '../models/lawyer_service_model.dart';
import '../widgets/custom_nav_bar.dart';
import '../utils/routes.dart';
import '../utils/app_colors.dart';

class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceListController());
    final double h = Get.height;
    final double w = Get.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        title: Text("আইনজীবী প্রোফাইল",
            style: TextStyle(color: AppColors.white, fontSize: w * 0.04)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLawyerProfileHeader(controller, w, h),
            _buildServiceTabs(w, h),
            _buildLawyerStatsRow(controller, w, h),
            Padding(
              padding: EdgeInsets.fromLTRB(w * 0.04, h * 0.015, w * 0.04, h * 0.005),
              child: Text("প্রদত্ত সেবাসমূহ",
                  style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Text(
                  "এই আইনজীবীর হাতে প্রায় বিভিন্ন আইনি সেবা নিতে পারবেন।",
                  style: TextStyle(color: AppColors.textGrey, fontSize: w * 0.032)
              ),
            ),
            SizedBox(height: h * 0.01),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(w * 0.04),
              itemCount: controller.services.length,
              itemBuilder: (context, index) => _buildServiceCard(controller.services[index], w, h),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(selectedIndex: 3, onItemTapped: (i) {}),
    );
  }

  Widget _buildLawyerProfileHeader(ServiceListController controller, double w, double h) {
    return Container(
      width: double.infinity,
      color: AppColors.green,
      padding: EdgeInsets.only(bottom: h * 0.025, top: h * 0.01),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(controller.lawyer.imagePath, width: w * 0.2, height: w * 0.2, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: h * 0.01),
          Text(controller.lawyer.name,
              style: TextStyle(color: AppColors.white, fontSize: w * 0.05, fontWeight: FontWeight.bold)),
          Text(controller.lawyer.role,
              style: TextStyle(color: AppColors.golden, fontSize: w * 0.032)),
          SizedBox(height: h * 0.01),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(20)),
            child: Text("⭐ ${controller.lawyer.rating}  ${controller.lawyer.experience} অভিজ্ঞতা",
                style: TextStyle(color: AppColors.white, fontSize: w * 0.028)),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceTabs(double w, double h) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.04),
      color: AppColors.green,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: h * 0.012),
                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Text("সাধারণ লিষ্ট",
                    style: TextStyle(color: AppColors.textBlack, fontWeight: FontWeight.w500, fontSize: w * 0.035)),
              ),
            ),
          ),
          SizedBox(width: w * 0.04),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: h * 0.012),
              decoration: BoxDecoration(color: AppColors.golden, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Text("সেবা লিষ্ট",
                  style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w500, fontSize: w * 0.035)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLawyerStatsRow(ServiceListController controller, double w, double h) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statCard(Icons.work_outline, controller.lawyer.cases, "মামলা লড়েছেন", w, h),
          _statCard(Icons.balance, controller.lawyer.experience, "অভিজ্ঞতা", w, h),
          _statCard(Icons.payments_outlined, controller.lawyer.rate, "প্রতি ঘণ্টা", w, h),
        ],
      ),
    );
  }

  Widget _statCard(IconData icon, String value, String label, double w, double h) {
    return Container(
      width: w * 0.28,
      padding: EdgeInsets.symmetric(vertical: h * 0.018),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.green, size: w * 0.055),
          SizedBox(height: h * 0.005),
          Text(value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.035, color: AppColors.textBlack)),
          Text(label,
              style: TextStyle(color: AppColors.textGrey, fontSize: w * 0.025)),
        ],
      ),
    );
  }

  Widget _buildServiceCard(LawyerService service, double w, double h) {
    return Container(
      margin: EdgeInsets.only(bottom: h * 0.03),
      padding: EdgeInsets.all(w * 0.045),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(4)),
            child: Text(service.category,
                style: TextStyle(color: AppColors.white, fontSize: w * 0.028)),
          ),
          SizedBox(height: h * 0.015),
          Text(service.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.048, color: AppColors.textBlack)),
          Text(service.subTitle,
              style: TextStyle(color: AppColors.textGrey, fontSize: w * 0.035)),
          SizedBox(height: h * 0.01),
          Text(service.description,
              style: TextStyle(color: AppColors.textBlack, fontSize: w * 0.032, height: 1.4)),
          SizedBox(height: h * 0.02),
          ...service.packages.map((pkg) => _buildPackageItem(pkg, w, h)),
          SizedBox(height: h * 0.015),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.serviceDetails, arguments: service);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonGreen,
              minimumSize: Size(double.infinity, h * 0.06),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("প্যাকেজ দেখুন",
                style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: w * 0.038)),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageItem(ServicePackage pkg, double w, double h) {
    return Container(
      margin: EdgeInsets.only(bottom: h * 0.01),
      padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.015),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF9F0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.green.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pkg.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.038, color: AppColors.textBlack)),
              Text(pkg.time,
                  style: TextStyle(color: AppColors.textGrey, fontSize: w * 0.03)),
            ],
          ),
          Text(pkg.price,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.04, color: AppColors.textBlack)),
        ],
      ),
    );
  }
}