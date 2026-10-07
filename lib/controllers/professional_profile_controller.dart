import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfessionProfileController extends GetxController {
  // License Fields
  final licenseNoController = TextEditingController(text: "৩১৩");
  final registrationNoController = TextEditingController(text: "৩১৩");

  // Practice Areas (Reactive List)
  var selectedAreas = <String>["ফৌজদারি আইন", "কর্পোরেট আইন", "পারিবারিক আইন"].obs;

  // About Me Field
  final aboutController = TextEditingController(
    text: "আমি রবার্ট সি, একজন পেশাদার আইনজীবী, ফৌজদারি প্রতিরক্ষা, কর্পোরেট মামলা এবং পারিবারিক আইনে ১৩ বছরের বেশি অভিজ্ঞতার সাথে কাজ করছি...",
  );

  // Dynamic Lists for Qualifications (Simplified for now)
  var qualifications = <Map<String, String>>[
    {
      "degree": "LLB",
      "institute": "চট্টগ্রাম বিশ্ববিদ্যালয়",
      "session": "২০১৬ - ২০২১"
    }
  ].obs;

  void addQualification() {
    // Logic to open a dialog or add a blank entry
    qualifications.add({
      "degree": "নতুন ডিগ্রি",
      "institute": "শিক্ষা প্রতিষ্ঠান",
      "session": "বছর"
    });
  }

  void updateProfile() {
    // Logic to call API or save locally
    Get.snackbar(
      "সফল",
      "আপনার প্রোফাইল আপডেট করা হয়েছে",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    licenseNoController.dispose();
    registrationNoController.dispose();
    aboutController.dispose();
    super.onClose();
  }
}