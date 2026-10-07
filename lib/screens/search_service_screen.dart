import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/service_search_controller.dart';
import '../models/lawyer_model.dart';
import '../utils/app_colors.dart';
import '../utils/routes.dart';

class ServiceSearchScreen extends StatelessWidget {
  ServiceSearchScreen({super.key});

  final ServiceSearchController controller = Get.put(ServiceSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'আইনজীবী খুঁজুন',
          style: GoogleFonts.anekBangla(color: AppColors.green, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              radius: 18,
              child: const Icon(Icons.person, color: Colors.grey),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Search Bar
            _buildSearchBar(),
            const SizedBox(height: 16),

            // 2. Filter Button Header (Clickable)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: controller.toggleFilter,
                  child: Row(
                    children: [
                      const Icon(Icons.tune, color: AppColors.green, size: 20),
                      const SizedBox(width: 8),
                      Text('ফিল্টার', style: GoogleFonts.anekBangla(color: AppColors.green, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: controller.clearFilters,
                  child: Text('মুছে ফেলুন', style: GoogleFonts.anekBangla(color: Colors.grey, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 3. Dropdown Section (Hidden by default, shown on click)
            Obx(() => Visibility(
              visible: controller.isFilterOpen.value,
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Caption 1
                    Text('সেবার ধরন', style: GoogleFonts.anekBangla(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
                    const SizedBox(height: 8),
                    // Dropdown 1
                    _buildDropdown(
                      hint: "সেবার ধরন নির্বাচন করুন",
                      value: controller.selectedServiceType.value,
                      items: controller.serviceTypes,
                      onChanged: controller.onServiceTypeChanged,
                    ),

                    const SizedBox(height: 16),

                    // Caption 2
                    Text('বিভাগ', style: GoogleFonts.anekBangla(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
                    const SizedBox(height: 8),
                    // Dropdown 2
                    _buildDropdown(
                      hint: "বিভাগ নির্বাচন করুন",
                      value: controller.selectedDivision.value,
                      items: controller.divisions,
                      onChanged: controller.onDivisionChanged,
                    ),
                  ],
                ),
              ),
            )),

            const SizedBox(height: 10),

            // 4. Results Header
            Obx(() => Text(
              '২৪৫টি ফলাফলের মধ্যে ১-${controller.serviceLawyers.length}টি দেখানো হচ্ছে',
              style: GoogleFonts.anekBangla(fontSize: 14, color: Colors.black54),
            )),
            const SizedBox(height: 16),

            // 5. Lawyer Cards List
            Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.serviceLawyers.length,
              itemBuilder: (context, index) {
                return _buildServiceLawyerCard(controller.serviceLawyers[index]);
              },
            )),
          ],
        ),
      ),
    );
  }

  // --- Helpers ---

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'নাম বা দক্ষতা অনুযায়ী খুঁজুন',
          hintStyle: GoogleFonts.anekBangla(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Light grey bg for dropdown
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: GoogleFonts.anekBangla(color: Colors.grey)),
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: GoogleFonts.anekBangla()),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildServiceLawyerCard(Lawyer lawyer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.green.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: Offset(0,2))
          ]
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/lawyer_image.jpg', // Static image from model logic
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(lawyer.name, style: GoogleFonts.anekBangla(fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            Text(" ${lawyer.rating}", style: GoogleFonts.anekBangla(fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    Text(lawyer.role, style: GoogleFonts.anekBangla(fontSize: 12, color: Colors.amber[800])),
                    Text(lawyer.cases, style: GoogleFonts.anekBangla(fontSize: 10, color: Colors.black)),
                    Text('এই খানে description এর টেক্সট টা অ্যাড হবে', style: GoogleFonts.anekBangla(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Price and Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lawyer.rate,
                style: GoogleFonts.anekBangla(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.serviceDetails,
                      arguments: {'lawyer_name': lawyer.name, 'role': lawyer.role},
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text(
                    'বিস্তারিত দেখুন',
                    style: GoogleFonts.anekBangla(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}