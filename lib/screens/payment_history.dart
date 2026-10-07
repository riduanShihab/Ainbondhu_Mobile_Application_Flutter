import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/payment_controller.dart';
import '../utils/app_colors.dart';

class PaymentHistoryScreen extends StatelessWidget {
  final PaymentController controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text(
          "পেমেন্ট ইতিহাস",
          style: GoogleFonts.anekBangla(color: AppColors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => controller.selectedProfileTab.value = 0,
        ),
      ),
      body: Column(
        children: [
          _buildSegmentedTab(),
          Expanded(
            child: Obx(
                  () => controller.paymentHistoryTab.value == 0
                  ? _buildTransactionList()
                  : _buildSummaryView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.inputBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            _tabItem("লেনদেনের ইতিহাস", 0),
            _tabItem("লেনদেনের সারসংক্ষেপ", 1),
          ],
        ),
      ),
    );
  }

  Widget _tabItem(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.paymentHistoryTab.value = index,
        child: Obx(
              () => Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: controller.paymentHistoryTab.value == index
                  ? AppColors.green
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.anekBangla(
                  color: controller.paymentHistoryTab.value == index
                      ? AppColors.white
                      : AppColors.textBlack,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => ListTile(
        leading: const CircleAvatar(
          backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
        ),
        title: Text(
          "মাহমুদ হাসান",
          style: GoogleFonts.anekBangla(color: AppColors.textBlack),
        ),
        subtitle: Text(
          "অ্যাপয়েন্টমেন্ট\nTrxID: 0KSAFASF1",
          style: GoogleFonts.anekBangla(color: AppColors.textGrey),
        ),
        trailing: Text(
          "+১৬০০",
          style: GoogleFonts.anekBangla(
            color: AppColors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryView() {
    return Column(
      children: [
        ListTile(
          title: Text(
            "নভেম্বর ২০২৩ সারসংক্ষেপ",
            style: GoogleFonts.anekBangla(color: AppColors.textBlack),
          ),
          trailing: const Icon(Icons.chevron_right, color: AppColors.textGrey),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "অ্যাপয়েন্টমেন্ট (৪ বার)",
                style: GoogleFonts.anekBangla(color: AppColors.textBlack),
              ),
              Text(
                "-৩০০০",
                style: GoogleFonts.anekBangla(
                  color: AppColors.textRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
