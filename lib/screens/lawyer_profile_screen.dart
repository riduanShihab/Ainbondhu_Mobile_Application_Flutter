import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lawyer_profile_controller.dart';
import '../utils/routes.dart';
import '../widgets/custom_nav_bar.dart';
import '../utils/app_colors.dart';

class LawyerProfileScreen extends StatefulWidget {
  const LawyerProfileScreen({super.key});

  @override
  State<LawyerProfileScreen> createState() => _LawyerProfileScreenState();
}

class _LawyerProfileScreenState extends State<LawyerProfileScreen> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<LawyerProfileController>()
        ? Get.find<LawyerProfileController>()
        : Get.put(LawyerProfileController());

    final double h = Get.height;
    final double w = Get.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.green,
        elevation: 0,
        title: Text("আইনজীবী প্রোফাইল",
            style: TextStyle(color: AppColors.white, fontSize: w * 0.045)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: h * 0.12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(controller, w, h),
                _buildStatsRow(controller, w, h),
                _sectionTitle("পরিচিতি", w),
                _bodyText(controller.lawyer.bio, w),
                _sectionTitle("কাজের ক্ষেত্র", w),
                _buildPracticeAreas(controller, w),
                _sectionTitle("শিক্ষাগত যোগ্যতা", w),
                _buildEducationItem("২০০৮ - ২০১০", "এলএলএম, প্রাইভেট", "সিটি আইন কলেজ, আমেরিকান ইউনিভার্সিটি ওয়াশিংটন", w),
                _buildEducationItem("২০০২ - ২০০৭", "এলএলবি, ব্যবসায়িক আইন", "ঢাকা বিশ্ববিদ্যালয়", w),
                _sectionTitle("ভাষা", w),
                _buildLanguageSkill("বাংলা", "প্রাথমিক ভাষা", 1.0, w),
                _buildLanguageSkill("ইংরেজি", "দক্ষ", 0.6, w),
                _sectionTitle("পুরস্কার ও স্বীকৃতি", w),
                _buildAwardItem("২০২৩", "সেরা আইন উপদেষ্টা পুরস্কার", "ন্যাশনাল বার অ্যাসোসিয়েশন", w),
                _buildAwardItem("২০ ২০২১", "ফৌজদারি প্রতিরক্ষা শ্রেষ্ঠত্ব", "স্টেট ল বোর্ড", w),
                _sectionTitle("অভিজ্ঞতা", w),
                _buildExperienceItem("২০১৭ - বর্তমান", "সিনিয়র পার্টনার", "লি অ্যান্ড অ্যাসোসিয়েটস লিগ্যাল ফার্ম", w, isCurrent: true),
                _buildExperienceItem("২০১০ - ২০১৭", "সহযোগী আইনজীবী", "মেট্রোপলিটান আইন বিভাগ", w),
                _buildExperienceItem("২০০৮ - ২০১০", "জুনিয়র আইনজীবী", "সিটি লিগ্যাল সার্ভিসেস", w),
                _buildReviewSectionHeader(w),
                _buildReviewCard("মুহাম্মাদ খলিল", "১ দিন আগে", "৪.৫", "খুবই সহায়ক এবং পেশাদার। আমার সম্পত্তির মামলা দ্রুত সমাধান করতে সাহায্য করেছেন। অত্যন্ত সুপারিষ করছি।", w),
                _buildReviewCard("জুবায়ের বিন", "৫ দিন আগে", "৪.০", "উনি খুবই ভালো কাজ করেন। অনেক ধন্যবাদ...", w),
              ],
            ),
          ),
          _buildStickyButton(w, h, controller),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }

  Widget _buildStickyButton(double w, double h, LawyerProfileController controller) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: AppColors.borderGrey.withValues(alpha: 0.5))),
        ),
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(AppRoutes.serviceList, arguments: controller.lawyer);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonGreen,
            minimumSize: Size(double.infinity, h * 0.065),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text("সকল সেবা দেখুন",
              style: TextStyle(color: AppColors.white, fontSize: w * 0.04, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildHeader(LawyerProfileController controller, double w, double h) {
    return Container(
      width: double.infinity,
      color: AppColors.green,
      padding: EdgeInsets.only(bottom: h * 0.03),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(18)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(controller.lawyer.imagePath, width: w * 0.28, height: w * 0.28, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: h * 0.012),
          Text(controller.lawyer.name,
              style: TextStyle(color: AppColors.white, fontSize: w * 0.055, fontWeight: FontWeight.bold)),
          Text(controller.lawyer.role,
              style: TextStyle(color: AppColors.golden, fontSize: w * 0.035)),
          SizedBox(height: h * 0.012),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(20)),
            child: Text("⭐ ${controller.lawyer.rating}   ${controller.lawyer.status}",
                style: TextStyle(color: AppColors.white, fontSize: w * 0.03)),
          ),
          SizedBox(height: h * 0.025),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _headerBtn("পরামর্শ নিন", AppColors.white, AppColors.green, w, h,
                    () => Get.toNamed(AppRoutes.consultation),),
              SizedBox(width: w * 0.03),
              _headerBtn("সেবা নিন", AppColors.golden, AppColors.white, w, h,
                  ()=>Get.toNamed(AppRoutes.serviceList),),
            ],
          )
        ],
      ),
    );
  }

  Widget _headerBtn(String t, Color bg, Color tx, double w, double h, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: w * 0.42,
          padding: EdgeInsets.symmetric(vertical: h * 0.015),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: Text(t, style: TextStyle(color: tx, fontWeight: FontWeight.bold, fontSize: w * 0.038)),
        ),
      );

  Widget _buildStatsRow(LawyerProfileController controller, double w, double h) => Padding(
    padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.02),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statItem(Icons.card_travel, controller.lawyer.cases, "সফল লেনদেন", w, h),
        _statItem(Icons.gavel, controller.lawyer.experience, "অভিজ্ঞতা", w, h),
        _statItem(Icons.payments_outlined, controller.lawyer.rate, "প্রতি ঘণ্টা", w, h),
      ],
    ),
  );

  Widget _statItem(IconData i, String v, String l, double w, double h) => Container(
    width: w * 0.28,
    padding: EdgeInsets.symmetric(vertical: h * 0.018),
    decoration: BoxDecoration(color: AppColors.inputBackground, borderRadius: BorderRadius.circular(10)),
    child: Column(children: [
      Icon(i, color: AppColors.green, size: w * 0.055),
      Text(v, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textBlack, fontSize: w * 0.035)),
      Text(l, style: TextStyle(color: AppColors.textGrey, fontSize: w * 0.028))
    ]),
  );

  Widget _sectionTitle(String t, double w) => Padding(
      padding: EdgeInsets.fromLTRB(w * 0.04, 25, w * 0.04, 10),
      child: Text(t, style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.bold, color: AppColors.textBlack)));

  Widget _bodyText(String t, double w) => Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
      child: Text(t, style: TextStyle(color: AppColors.textGrey, fontSize: w * 0.032, height: 1.5)));

  Widget _buildPracticeAreas(LawyerProfileController c, double w) => Padding(
    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
    child: Wrap(spacing: 8, children: c.lawyer.practiceAreas.map((e) => Chip(
        label: Text(e, style: TextStyle(color: AppColors.green, fontSize: w * 0.03)),
        backgroundColor: AppColors.inputBackground,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))).toList()),
  );

  Widget _buildEducationItem(String y, String t, String s, double w) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: w * 0.04),
      leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.inputBackground, borderRadius: BorderRadius.circular(8)), child: Icon(Icons.workspace_premium_outlined, color: AppColors.green, size: w * 0.06)),
      title: Text(y, style: TextStyle(fontSize: w * 0.03, color: AppColors.textGrey)),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textBlack, fontSize: w * 0.038)),
        Text(s, style: TextStyle(fontSize: w * 0.03, color: AppColors.textGrey))
      ]));

  Widget _buildLanguageSkill(String l, String lv, double p, double w) => Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 8),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(l, style: TextStyle(color: AppColors.textBlack, fontSize: w * 0.035)),
          Text(lv, style: TextStyle(fontSize: w * 0.03, color: AppColors.textGrey))]),
        const SizedBox(height: 5),
        LinearProgressIndicator(value: p, backgroundColor: AppColors.borderGrey, color: AppColors.green, minHeight: 6, borderRadius: BorderRadius.circular(5))]));

  Widget _buildAwardItem(String y, String t, String o, double w) => Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.inputBackground.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(5)), child: Text(y, style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: w * 0.03))),
        SizedBox(width: w * 0.04),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textBlack, fontSize: w * 0.035)),
          Text(o, style: TextStyle(fontSize: w * 0.03, color: AppColors.textGrey))]))]));

  Widget _buildExperienceItem(String year, String title, String company, double w, {bool isCurrent = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(width: 12, height: 12, decoration: BoxDecoration(color: isCurrent ? AppColors.green : AppColors.borderGrey, shape: BoxShape.circle, border: Border.all(color: AppColors.white, width: 2))),
              Container(width: 2, height: 50, color: AppColors.borderGrey),
            ],
          ),
          SizedBox(width: w * 0.04),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(year, style: TextStyle(color: AppColors.green, fontWeight: FontWeight.bold, fontSize: w * 0.032)),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.038, color: AppColors.textBlack)),
              Text(company, style: TextStyle(color: AppColors.textGrey, fontSize: w * 0.03)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSectionHeader(double w) => Padding(
      padding: EdgeInsets.fromLTRB(w * 0.04, 25, w * 0.04, 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("ক্লায়েন্টদের মতামত (১২)", style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
        Text("সব দেখুন", style: TextStyle(color: AppColors.green, fontSize: w * 0.032, fontWeight: FontWeight.bold))]));

  Widget _buildReviewCard(String n, String t, String r, String c, double w) => Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: AppColors.inputBackground, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(radius: w * 0.05, backgroundColor: AppColors.borderGrey, child: const Icon(Icons.person, color: AppColors.white)),
          SizedBox(width: w * 0.03),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(n, style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.038, color: AppColors.textBlack)),
            Text(t, style: TextStyle(color: AppColors.textGrey, fontSize: w * 0.028))])),
          Row(children: [const Icon(Icons.star, color: AppColors.golden, size: 16), Text(" $r", style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.035, color: AppColors.textBlack))])]),
        const SizedBox(height: 10),
        Text(c, style: TextStyle(color: AppColors.textGrey, fontSize: w * 0.03, height: 1.4))]));
}