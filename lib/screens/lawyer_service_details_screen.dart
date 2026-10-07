import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/lawyer_service_details_controller.dart';
import '../utils/app_colors.dart';
import '../utils/routes.dart';

class LawyerServiceDetailsScreen extends StatelessWidget {
  LawyerServiceDetailsScreen({super.key});

  final LawyerServiceDetailsController controller = Get.put(
    LawyerServiceDetailsController(),
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
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
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.all(w * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: h * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
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
                        ),
                        child: Text(
                          'সেবা অনুরোধ',
                          style: GoogleFonts.anekBangla(color: AppColors.green),
                        ),
                      ),
                    ),
                    SizedBox(width: w * 0.03),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.lawyerMyServices);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          'আমার সেবা',
                          style: GoogleFonts.anekBangla(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              _buildSectionTitle('সেবার ধরন এবং বিভাগ', w),
              Container(
                padding: EdgeInsets.all(w * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdown(
                            'সেবার ধরন',
                            controller.serviceTypes,
                            controller.serviceType,
                            w,
                          ),
                        ),
                        SizedBox(width: w * 0.03),
                        Expanded(
                          child: _buildDropdown(
                            'বিভাগ',
                            controller.categories,
                            controller.category,
                            w,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.02),
              _buildSectionTitle('শিরোনাম', w),
              Container(
                padding: EdgeInsets.all(w * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _buildTextField('', controller.title, w),
              ),

              SizedBox(height: h * 0.02),
              _buildSectionTitle('সেবার সম্পর্কে', w),
              Container(
                padding: EdgeInsets.all(w * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _buildTextField(
                  '',
                  controller.description,
                  w,
                  maxLines: 3,
                ),
              ),

              SizedBox(height: h * 0.02),
              _buildSectionTitle('আপনার সেবার ছবি', w),
              Container(
                padding: EdgeInsets.all(w * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        // Placeholders
                        color: Colors.grey[300],
                        image: index < 5
                            ? DecorationImage(
                                image: AssetImage(
                                  'assets/images/service_image_1.png',
                                ),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      // Show Add icon only if editing and last item (simulated)
                      child: (controller.isEditing.value && index == 5)
                          ? Icon(Icons.add_a_photo, color: Colors.grey[700])
                          : null,
                    );
                  },
                ),
              ),

              SizedBox(height: h * 0.02),
              _buildSectionTitle('মূল্য নির্ধারণ স্তর', w),
              _buildPriceTierCard(w, h, 'স্ট্যান্ডার্ড', controller.standard),
              SizedBox(height: h * 0.015),
              _buildPriceTierCard(w, h, 'উন্নত', controller.advanced),
              SizedBox(height: h * 0.015),
              _buildPriceTierCard(w, h, 'প্রিমিয়াম', controller.premium),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(w * 0.04),
        color: Colors.white,
        child: Obx(
          () => ElevatedButton(
            onPressed: () {
              if (controller.isEditing.value) {
                controller.saveChanges();
              } else {
                controller.toggleEdit();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.symmetric(vertical: h * 0.015),
            ),
            child: Text(
              controller.isEditing.value ? 'সংরক্ষণ করুন' : 'সম্পাদনা করুন',
              style: GoogleFonts.anekBangla(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: w * 0.045,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, double w) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: GoogleFonts.anekBangla(
          fontSize: w * 0.045,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    RxString selectedValue,
    double w,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.anekBangla(
            fontSize: w * 0.035,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: IgnorePointer(
            ignoring: !controller.isEditing.value,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedValue.value,
                icon: controller.isEditing.value
                    ? Icon(Icons.arrow_drop_down)
                    : SizedBox.shrink(),
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.anekBangla(fontSize: w * 0.038),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) selectedValue.value = val;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    RxString controllerText,
    double w, {
    int maxLines = 1,
    bool isNumber = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            style: GoogleFonts.anekBangla(
              fontSize: w * 0.035,
              color: Colors.black87,
            ),
          ),
        if (label.isNotEmpty) SizedBox(height: 4),
        IgnorePointer(
          ignoring: !controller.isEditing.value,
          child: TextFormField(
            initialValue: controllerText.value,
            onChanged: (val) => controllerText.value = val,
            maxLines: maxLines,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
            style: GoogleFonts.anekBangla(fontSize: w * 0.04),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceTierCard(
    double w,
    double h,
    String tierName,
    Map<String, dynamic> data,
  ) {
    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.green, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tierName,
            style: GoogleFonts.anekBangla(
              fontSize: w * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: h * 0.015),
          _buildTextField('মূল্য (টাকা)', data['price'], w, isNumber: true),
          SizedBox(height: h * 0.015),
          _buildTextField('বিবরণ', data['desc'], w, maxLines: 2),
          SizedBox(height: h * 0.015),
          _buildTextField(
            'ডেলিভারির সময় (দিন)',
            data['delivery'],
            w,
            isNumber: true,
          ),
          SizedBox(height: h * 0.015),
          Text(
            'বৈশিষ্ট্য এবং সুবিধা',
            style: GoogleFonts.anekBangla(
              fontSize: w * 0.035,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),

          Column(
            children: (data['features'] as RxList)
                .take(3)
                .map<Widget>(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildTextField('', (feature as String).obs, w),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
