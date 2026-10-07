import 'package:get/get.dart';
import '../models/lawyer_model.dart';

class LawyerProfileController extends GetxController {
  late Lawyer lawyer;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      lawyer = Get.arguments;
    } else {
      // ডিফল্ট ডেটা (ইমেজ অনুযায়ী)
      lawyer = Lawyer(
        name: "রবার্ট লি",
        role: "ফৌজদারি আইন - কর্পোরেট আইন",
        experience: "১৫ বছর",
        cases: "৩৩০টি",
        rate: "৳২০০০",
        rating: 4.9,
        status: "১৬+ বছরের অভিজ্ঞতা",
        imagePath: 'assets/images/lawyer.png',
        bio: "বারের একজন অত্যন্ত প্রতিষ্ঠিত আইনজীবী, দীর্ঘ অভিজ্ঞতা সম্পন্ন। কর্পোরেট সমস্যা ও মামলার বিচার এবং দ্রুত সমাধানে বিশেষজ্ঞ...",
        practiceAreas: ["ফৌজদারি আইন", "কর্পোরেট আইন", "সম্পত্তি আইন", "বিবাহ আইন", "চুক্তি আইন"],
      );
    }
  }
}