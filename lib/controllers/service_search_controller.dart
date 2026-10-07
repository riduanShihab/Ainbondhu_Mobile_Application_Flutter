import 'package:get/get.dart';
import '../models/lawyer_model.dart';

class ServiceSearchController extends GetxController {
  var isFilterOpen = false.obs;

  // ড্রপডাউন সিলেকশন
  var selectedServiceType = Rxn<String>();
  var selectedDivision = Rxn<String>();

  // মাস্টার লিস্ট (সব ডাটা থাকবে এখানে)
  final List<Lawyer> _allLawyers = [
    Lawyer(
      name: 'আব্দুল্লাহ হোসেন',
      role: 'ফৌজদারি আইন',
      experience: '১৫ বছর',
      cases: '৩৩০টি',
      rate: '৳১০০০',
      rating: 4.9,
      status: '১৬+ বছরের অভিজ্ঞতা',
      bio: "ফৌজদারি মামলায় দীর্ঘ ১৫ বছরের অভিজ্ঞতা সম্পন্ন আইনজীবী।",
      practiceAreas: ["ফৌজদারি আইন", "চুক্তি আইন"],
    ),
    Lawyer(
      name: 'সারা রহমান',
      role: 'পারিবারিক আইন',
      experience: '৮ বছর',
      cases: '১২০টি',
      rate: '৳২০০০',
      rating: 4.5,
      status: '৮+ বছরের অভিজ্ঞতা',
      bio: "পারিবারিক সমস্যা ও বিবাহ বিচ্ছেদ সংক্রান্ত আইনি সেবায় বিশেষজ্ঞ।",
      practiceAreas: ["পারিবারিক আইন", "সম্পত্তি আইন"],
    ),
  ];

  // এই লিস্টটি UI-তে প্রদর্শিত হবে (ফিল্টার্ড ডাটা)
  var serviceLawyers = <Lawyer>[].obs;

  @override
  void onInit() {
    super.onInit();
    // শুরুতে সব আইনজীবী দেখাবে
    serviceLawyers.assignAll(_allLawyers);
  }

  // ড্রপডাউন অপশন
  final List<String> divisions = [
    'ফৌজদারি আইন',
    'দেওয়ানি আইন',
    'কর্পোরেট আইন',
    'পারিবারিক আইন',
  ];

  final List<String> serviceTypes = [
    'আইনি পরামর্শ',
    'ডকুমেন্ট ড্রাফটিং',
    'মামলা পরিচালনা',
  ];

  // ফিল্টার লজিক
  void applyFilters() {
    var filtered = _allLawyers.where((lawyer) {
      bool matchesDivision = selectedDivision.value == null ||
          lawyer.role.contains(selectedDivision.value!);
      return matchesDivision;
    }).toList();

    serviceLawyers.assignAll(filtered);
  }

  void toggleFilter() {
    isFilterOpen.value = !isFilterOpen.value;
  }

  void onServiceTypeChanged(String? val) {
    selectedServiceType.value = val;
    applyFilters(); // সিলেকশন পরিবর্তন হলে ফিল্টার কল হবে
  }

  void onDivisionChanged(String? val) {
    selectedDivision.value = val;
    applyFilters();
  }

  void clearFilters() {
    selectedServiceType.value = null;
    selectedDivision.value = null;
    serviceLawyers.assignAll(_allLawyers);
  }
}