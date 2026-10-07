import 'package:ain_bondhu_app/controllers/lawyer_home_controller.dart';
import 'package:ain_bondhu_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'lawyer_appointment_screen.dart';

class LawyerHomeScreen extends StatelessWidget {
  const LawyerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Put controller
    final controller = Get.put(LawyerHomeController());

    return Scaffold(
      key: controller.scaffoldKey,
      drawer: _buildDrawer(context),
      backgroundColor: const Color(0xFFF5F5F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: Get.width * 0.04,
        title: Row(
          children: [
            CircleAvatar(
              radius: Get.width * 0.05,
              backgroundImage: const NetworkImage(
                'https://i.pravatar.cc/150?img=3',
              ),
            ),
            SizedBox(width: Get.width * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'খালেদ আক্তার',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: Get.width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Environmental Law',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Get.width * 0.03,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.blueGrey,
                  size: 28,
                ),
                onPressed: () {},
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black, size: Get.width * 0.08),
            onPressed: () {
              controller.openDrawer();
            },
          ),
          SizedBox(width: Get.width * 0.02),
        ],
      ),
      body: Obx(() {
        if (controller.selectedIndex.value == 0) {
          return _buildHomeBody(controller);
        } else if (controller.selectedIndex.value == 1) {
          return const LawyerAppointmentScreen();
        }
        return Center(
          child: Text('Coming Soon: Index ${controller.selectedIndex.value}'),
        );
      }),

    );
  }

  Widget _buildHomeBody(LawyerHomeController controller) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(Get.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: Get.height * 0.25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('january 2024'),
                      Icon(Icons.more_horiz),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBar(height: Get.height * 0.06),
                        _buildBar(height: Get.height * 0.05),
                        _buildBar(height: Get.height * 0.08),
                        _buildBar(height: Get.height * 0.12, isActive: true),
                        _buildBar(height: Get.height * 0.09),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Date Selector
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.chevron_left),
                  Text(
                    'জানুয়ারি ২০২৪',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.02),

            // Stats Grid
            Obx(
                  () => GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: Get.width * 0.03,
                mainAxisSpacing: Get.height * 0.015,
                childAspectRatio: 2.2,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  if (controller.stats.isNotEmpty) ...[
                    _buildStatCard(
                      controller.stats[0].title,
                      controller.stats[0].value,
                      Icons.calendar_today_outlined,
                    ),
                    _buildStatCard(
                      controller.stats[1].title,
                      controller.stats[1].value,
                      Icons.check_circle_outline,
                      isStatus: controller.stats[1].isStatus,
                    ),
                    _buildStatCard(
                      controller.stats[2].title,
                      controller.stats[2].value,
                      Icons.folder_open_outlined,
                    ),
                    _buildStatCard(
                      controller.stats[3].title,
                      controller.stats[3].value,
                      Icons.attach_money,
                    ),
                  ] else
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.025),

            // Appointments Section
            Text(
              'অ্যাপয়েন্টমেন্টের বিবরণ', // Appointment Details
              style: TextStyle(
                fontSize: Get.width * 0.045 > 18 ? 18 : Get.width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.015),
            _buildAppointmentPreviewCard(
              name: 'সাবরিনা জাহান',
              time: 'সকাল ১০:০০',
              type: 'অডিও কল',
              image: 'https://i.pravatar.cc/150?img=5',
            ),
            SizedBox(height: Get.height * 0.012),
            _buildAppointmentPreviewCard(
              name: 'সাবরিনা জাহান',
              time: 'দুপুর ১:০০',
              type: 'ভিডিও কল',
              image: 'https://i.pravatar.cc/150?img=5',
            ),
            SizedBox(height: Get.height * 0.015),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "View Calendar",
                  style: GoogleFonts.anekBangla(
                    color: AppColors.green,
                    fontSize: Get.width * 0.035,
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            // Fast Access
            Text(
              'দ্রুত অ্যাক্সেস', // Fast Access
              style: TextStyle(
                fontSize: Get.width * 0.045 > 18 ? 18 : Get.width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickAccessBtn(Icons.add, "নতুন"), // New
                _buildQuickAccessBtn(
                  Icons.calendar_month,
                  "ক্যালেন্ডার",
                ), // Calendar
                _buildQuickAccessBtn(Icons.note_alt_outlined, "নোট"), // Note
              ],
            ),
            SizedBox(height: Get.height * 0.025),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'অ্যাপয়েন্টমেন্টের আবেদন',
                  style: TextStyle(
                    fontSize: Get.width * 0.045 > 18 ? 18 : Get.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.changeTabIndex(1);
                  },
                  child: Text(
                    'সব দেখুন >',
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: Get.width * 0.035,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.015),

            _buildRequestPreview(
              name: 'সারা উইলিয়ামস',
              time: '10:00 AM',
              type: 'প্রাথমিক পরামর্শ',
              color: Colors.green,
            ),
            _buildRequestPreview(
              name: 'এমিলি জোনস',
              time: '11:00 AM',
              type: 'আইনি পরামর্শ',
              color: Colors.blue,
            ),
            SizedBox(height: Get.height * 0.025),
            // Recent Reviews
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'অ্যাটেন্ডেন্টের রিভিউ',
                  style: TextStyle(
                    fontSize: Get.width * 0.045 > 18 ? 18 : Get.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'সব দেখুন >',
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: Get.width * 0.035,
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.015),
            _buildReviewCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      LawyerHomeController controller,
      int index,
      IconData outlineIcon,
      IconData filledIcon,
      String label,
      ) {
    bool isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeTabIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? filledIcon : outlineIcon,
            color: isSelected ? AppColors.green : Colors.black87,
            size: Get.width * 0.065 > 28 ? 28 : Get.width * 0.065,
          ),
          SizedBox(height: Get.height * 0.005),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.03,
              vertical: Get.height * 0.005,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.green : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: Get.width * 0.03 > 12 ? 12 : Get.width * 0.03,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar({required double height, bool isActive = false}) {
    return Container(
      width: Get.width * 0.08,
      height: height,
      decoration: BoxDecoration(
        color: isActive ? AppColors.green : Colors.green.shade200,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
      ),
    );
  }

  Widget _buildStatCard(
      String title,
      String value,
      IconData icon, {
        bool isStatus = false,
      }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.green, size: Get.width * 0.05),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Get.width * 0.028,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                isStatus
                    ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : Text(
                  value,
                  style: TextStyle(
                    fontSize: Get.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentPreviewCard({
    required String name,
    required String time,
    required String type,
    required String image,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: AppColors.green, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(image),
            radius: Get.width * 0.05,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.035,
                  ),
                ),
                Text(
                  'আইনগত পরামর্শ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: Get.width * 0.03,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: Get.width * 0.03,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '১২ অক্টোবর ২০২৪',
                      style: TextStyle(
                        fontSize: Get.width * 0.025,
                        color: Colors.grey,
                      ),
                    ), // Date placeholder
                    const SizedBox(width: 10),
                    Icon(
                      Icons.access_time,
                      size: Get.width * 0.03,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: Get.width * 0.025,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              type,
              style: TextStyle(color: Colors.blue, fontSize: Get.width * 0.03),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestPreview({
    required String name,
    required String time,
    required String type,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            radius: Get.width * 0.05,
            child: Icon(
              Icons.person,
              color: Colors.blue,
              size: Get.width * 0.04,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.035,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: Get.width * 0.03,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: Get.width * 0.025,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: Get.width * 0.025,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey, size: Get.width * 0.05),
        ],
      ),
    );
  }

  Widget _buildQuickAccessBtn(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.blue, size: Get.width * 0.06),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: Get.width * 0.03)),
      ],
    );
  }

  Widget _buildReviewCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.purple,
                radius: Get.width * 0.05,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: Get.width * 0.04,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "রুনা লায়লা",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Get.width * 0.035,
                ),
              ), // Runa Laila
              const Spacer(),
              Icon(Icons.star, color: Colors.amber, size: Get.width * 0.04),
              Icon(Icons.star, color: Colors.amber, size: Get.width * 0.04),
              Icon(Icons.star, color: Colors.amber, size: Get.width * 0.04),
              Icon(Icons.star, color: Colors.amber, size: Get.width * 0.04),
              Icon(Icons.star, color: Colors.amber, size: Get.width * 0.04),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "আপনার সেবায় খুব খুশি...",
            style: TextStyle(color: Colors.grey, fontSize: Get.width * 0.03),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: const [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 16),
                    Text(
                      'লগআউট',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(color: Colors.black87)),
      onTap: () {},
    );
  }
}