import 'package:get/get.dart';

class PaymentController extends GetxController {
  // Navigation
  var selectedProfileTab = 0.obs; // 0 for Settings, 1 for History
  var paymentHistoryTab = 0.obs; // 0 for History, 1 for Summary

  // Profile Data
  var casesTaken = "৩২০".obs;
  var casesWon = "৩২০".obs;
  var educationList = <Map<String, String>>[
    {'degree': 'LLB', 'uni': 'চট্টগ্রাম বিশ্ববিদ্যালয়', 'year': '২০১৮-২০২৩'}
  ].obs;

  void addEducation() {
    educationList.add({'degree': '', 'uni': '', 'year': ''});
  }
}