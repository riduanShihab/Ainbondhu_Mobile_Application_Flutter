import 'package:ain_bondhu_app/controllers/lawyer_appointment_controller.dart';
import 'package:ain_bondhu_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/lawyer_side_model.dart';

class LawyerAppointmentScreen extends StatelessWidget {
  const LawyerAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(LawyerAppointmentController());

    return SingleChildScrollView(
      padding: EdgeInsets.all(Get.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Toggle Tabs
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.green),
            ),
            child: Obx(
                  () => Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changeTab(0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.015,
                        ),
                        decoration: BoxDecoration(
                          color: controller.selectedTab.value == 0
                              ? AppColors.green
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'অ্যাপয়েন্টমেন্টের আবেদন', // Appointment Application
                          style: TextStyle(
                            color: controller.selectedTab.value == 0
                                ? Colors.white
                                : AppColors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.035,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changeTab(1),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.015,
                        ),
                        decoration: BoxDecoration(
                          color: controller.selectedTab.value == 1
                              ? AppColors.green
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'আমার অ্যাপয়েন্টমেন্ট', // My Appointments
                          style: TextStyle(
                            color: controller.selectedTab.value == 1
                                ? Colors.white
                                : AppColors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.035,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.02),

          // Content
          Obx(
                () => controller.selectedTab.value == 0
                ? _buildRequestsTab(controller)
                : _buildMyAppointmentsTab(controller),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsTab(LawyerAppointmentController controller) {
    if (controller.appointmentRequests.isEmpty) {
      return const Center(child: Text("কোনো আবেদন নেই"));
    }
    return Column(
      children: controller.appointmentRequests
          .map((request) => _buildRequestCard(Get.context!, request))
          .toList(),
    );
  }

  Widget _buildMyAppointmentsTab(LawyerAppointmentController controller) {
    if (controller.myAppointments.isEmpty) {
      return const Center(child: Text("কোনো অ্যাপয়েন্টমেন্ট নেই"));
    }
    return Column(
      children: controller.myAppointments
          .map((apt) => _buildConfirmedCard(apt))
          .toList(),
    );
  }

  Widget _buildRequestCard(BuildContext context, AppointmentModel request) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.02),
      padding: EdgeInsets.all(Get.width * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9), // Light bg
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(request.image),
                radius: Get.width * 0.05,
              ),
              SizedBox(width: Get.width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * 0.04,
                    ),
                  ),
                  Text(
                    '${request.date} - ${request.time}',
                    style: TextStyle(
                      fontSize: Get.width * 0.03,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Get.height * 0.015),
          _buildInfoRow('ইমেইল', request.email ?? ''),
          _buildInfoRow('ফোন নম্বর', request.phone ?? ''),
          _buildInfoRow('বিষয়', request.subject ?? ''),
          _buildInfoRow('সমস্যা', request.summary ?? ''),
          SizedBox(height: Get.height * 0.02),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showScheduleBottomSheet(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
              ),
              child: Text(
                'অ্যাপয়েন্টমেন্ট নির্ধারণ করুন',
                style: TextStyle(
                  fontSize: Get.width * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmedCard(AppointmentModel apt) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.02),
      padding: EdgeInsets.all(Get.width * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.green,
                    radius: Get.width * 0.05,
                    child: Text(
                      apt.name[0].toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.width * 0.04 > 16 ? 16 : Get.width * 0.04,
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        apt.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width * 0.035,
                        ),
                      ),
                      Text(
                        apt.type,
                        style: TextStyle(
                          fontSize: Get.width * 0.025,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (apt.duration != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.02,
                    vertical: Get.height * 0.004,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    apt.duration!,
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: Get.width * 0.03 > 12 ? 12 : Get.width * 0.03,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: Get.height * 0.015),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: Get.width * 0.035 > 14 ? 14 : Get.width * 0.035,
                      color: Colors.grey,
                    ),
                    SizedBox(width: Get.width * 0.01),
                    Text(
                      apt.date,
                      style: TextStyle(
                        fontSize: Get.width * 0.03 > 12 ? 12 : Get.width * 0.03,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: Get.width * 0.035,
                      color: Colors.grey,
                    ),
                    SizedBox(width: Get.width * 0.01),
                    Text(
                      apt.time,
                      style: TextStyle(
                        fontSize: Get.width * 0.03 > 12 ? 12 : Get.width * 0.03,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.015),
          if (apt.meetLink != null)
            _buildInfoRowWithIcon(Icons.location_on_outlined, apt.meetLink!),
          if (apt.email != null)
            _buildInfoRowWithIcon(Icons.email_outlined, apt.email!),
          if (apt.phone != null)
            _buildInfoRowWithIcon(Icons.phone_outlined, apt.phone!),

          const SizedBox(height: 8),
          const Text(
            'বিষয়',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Text(apt.subject ?? '', style: const TextStyle(fontSize: 12)),
          SizedBox(height: Get.height * 0.01),
          const Text(
            'সমস্যা',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Text(
            apt.summary ?? '',
            style: TextStyle(
              fontSize: Get.width * 0.03 > 12 ? 12 : Get.width * 0.03,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.012),
                  ),
                  child: Text(
                    'আপডেট করুন',
                    style: TextStyle(fontSize: Get.width * 0.03),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.chat_bubble_outline, size: Get.width * 0.04),
                  label: Text(
                    'চ্যাট করুন',
                    style: TextStyle(fontSize: Get.width * 0.03),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.012),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
            decoration: BoxDecoration(
              color: AppColors.buttonGreen, // Dark Green
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'চলমান',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.width * 0.035,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: Get.width * 0.045,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: Get.width * 0.03,
            color: AppColors.textBlack,
          ),
          children: [
            TextSpan(
              text: '$label\n',
              style: TextStyle(
                color: AppColors.textGrey,
                fontSize: Get.width * 0.025,
              ),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRowWithIcon(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(icon, size: Get.width * 0.035, color: AppColors.textGrey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: Get.width * 0.03,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showScheduleBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const SingleChildScrollView(child: ScheduleForm()),
      ),
    );
  }
}

class ScheduleForm extends StatelessWidget {
  const ScheduleForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Get.width * 0.04),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'অ্যাপয়েন্টমেন্ট নির্ধারণ করুন',
                style: TextStyle(
                  fontSize: Get.width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, size: Get.width * 0.05),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildLabel('অ্যাপয়েন্টমেন্ট কোথায় করবেন*'),
          DropdownButtonFormField<String>(
            decoration: _inputDecoration(),
            items: const [
              DropdownMenuItem(
                value: 'Online',
                child: Text('IT Business Incubator, CUET'),
              ),
            ],
            onChanged: (v) {},
            hint: const Text('স্থান নির্বাচন করুন'),
          ),
          const SizedBox(height: 12),
          _buildLabel('অ্যাপয়েন্টমেন্টের ধরণ*'),
          TextFormField(
            initialValue: 'প্রাথমিক পরামর্শ',
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 12),
          _buildLabel('তারিখ*'),
          TextFormField(
            initialValue: '১১/১২/২০২৩',
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 12),
          _buildLabel('সময় *'),
          TextFormField(
            initialValue: '১২:০১ PM',
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 12),
          _buildLabel('মন্তব্য (ঐচ্ছিক)'),
          TextFormField(
            maxLines: 3,
            decoration: _inputDecoration(
              hint: 'দয়া করে সমস্ত প্রাসঙ্গিক নথি সঙ্গে আনুন।',
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.015,
                    horizontal: 20,
                  ),
                ),
                child: Text(
                  'বাতিল',
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: Get.width * 0.035,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
                  ),
                  child: Text(
                    'অ্যাপয়েন্টমেন্ট আপডেট করুন',
                    style: TextStyle(fontSize: Get.width * 0.035),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.green),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.03,
        vertical: Get.height * 0.015,
      ),
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: Get.width * 0.03,
        color: AppColors.textGrey,
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Get.width * 0.035,
        ),
      ),
    );
  }
}