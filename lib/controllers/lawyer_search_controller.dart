import 'package:get/get.dart';
import '../models/lawyer_model.dart';

class LawyerSearchController extends GetxController {
  var minRating = 0.0.obs;
  var selectedCategory = Rxn<String>();
  var selectedSubService = Rxn<String>();

  final Map<String, List<String>> serviceData = {
    '⚖️ আদালত সেবা': ['দেওয়ানি মামলা', 'ফৌজদারি মামলা', 'পারিবারিক মামলা', 'জামিন'],
    '🏠 সম্পত্তি সেবা': ['জমি ক্রয়-বিক্রয়', 'দলিল যাচাই', 'নামজারি', 'উত্তরাধিকার'],
    '📄 চুক্তিপত্র তৈরি': ['ব্যবসায়িক চুক্তি', 'পার্টনারশিপ', 'ভাড়া চুক্তি'],
    '💰 কর ও হিসাব': ['আয়কর পরামর্শ', 'ট্যাক্স রিটার্ন', 'ভ্যাট সেবা'],
    '™️ ট্রেডমার্ক ও মেধাস্বত্ব': ['রেজিস্ট্রেশন', 'কপিরাইট', 'ব্র্যান্ড সুরক্ষা'],
    '📝 নোটারি সেবা': ['নোটারি সত্যায়ন', 'এফিডেভিট', 'পাওয়ার অফ অ্যাটর্নি'],
    '📜 লাইসেন্স ও রেজিস্ট্রেশন': ['ট্রেড লাইসেন্স', 'কোম্পানি গঠন', 'NGO'],
    '🧠 বিশেষজ্ঞ পরামর্শ': ['আইনি পরামর্শ', 'নোটিশ প্রস্তুত', 'ডকুমেন্ট রিভিউ'],
    '🚀 ব্যবসা শুরু সহায়তা': ['স্টার্টআপ সহায়তা', 'কমপ্লায়েন্স', 'কাঠামো'],
    '🤝 বিবাদ সমাধান': ['মধ্যস্থতা', 'সালিশি', 'বিরোধ নিষ্পত্তি'],
  };

  final List<Lawyer> _allLawyers = [
    Lawyer(
      name: 'সারা মিচেল',
      role: 'সিনিয়র পার্টনার - কর্পোরেট আইন',
      experience: '১৫ বছর',
      cases: '৩৩০টি',
      rate: '৳৩০০০ প্রতি ঘন্টা',
      rating: 4.9,
      status: 'online',
      bio: "বারের একজন অত্যন্ত প্রতিষ্ঠিত আইনজীবী, দীর্ঘ অভিজ্ঞতা সম্পন্ন। কর্পোরেট সমস্যা ও মামলার বিচার এবং দ্রুত সমাধানে বিশেষজ্ঞ।",
      practiceAreas: ["কর্পোরেট আইন", "চুক্তিপত্র তৈরি", "ট্রেডমার্ক", "ব্যবসায়িক বিরোধ"],
    ),
    Lawyer(
      name: 'ড্যানিয়েল ব্রায়ান',
      role: 'সিনিয়র কাউন্সিল - পারিবারিক আইন',
      experience: '১০ বছর',
      cases: '২৫০টি',
      rate: '৳২০০০ প্রতি ঘন্টা',
      rating: 4.8,
      status: 'busy',
      bio: "পারিবারিক বিবাদ এবং সম্পত্তি আইন সংক্রান্ত জটিলতা সমাধানে ১০ বছরের অভিজ্ঞতা সম্পন্ন।",
      practiceAreas: ["পারিবারিক আইন", "সম্পত্তি সেবা", "মধ্যস্থতা", "উত্তরাধিকার"],
    ),
    Lawyer(
      name: 'আব্দুল্লাহ হোসেন',
      role: 'ফৌজদারি বিশেষজ্ঞ',
      experience: '১২ বছর',
      cases: '৪১০টি',
      rate: '৳১৫০০ প্রতি ঘন্টা',
      rating: 4.7,
      status: 'online',
      bio: "ফৌজদারি মামলা পরিচালনা এবং জামিন সংক্রান্ত বিষয়ে আদালত পাড়ায় সুপরিচিত।",
      practiceAreas: ["ফৌজদারি মামলা", "জামিন", "আদালত সেবা"],
    ),
  ];

  var lawyers = <Lawyer>[].obs;

  @override
  void onInit() {
    super.onInit();
    lawyers.assignAll(_allLawyers);
  }

  List<String> get categories => serviceData.keys.toList();

  List<String> get subServices => selectedCategory.value != null
      ? serviceData[selectedCategory.value] ?? []
      : [];

  void applyFilters() {
    var filtered = _allLawyers.where((lawyer) {
      bool matchesRating = lawyer.rating >= minRating.value;

      bool matchesCategory = true;
      if (selectedCategory.value != null) {
        String categoryName = selectedCategory.value!.replaceAll(RegExp(r'[^\w\s\u0980-\u09FF]'), '').trim();
        matchesCategory = lawyer.role.contains(categoryName) ||
            lawyer.practiceAreas.any((area) => area.contains(categoryName));
      }

      return matchesRating && matchesCategory;
    }).toList();

    lawyers.assignAll(filtered);
  }

  void updateRating(double value) {
    minRating.value = value;
    applyFilters();
  }

  void onCategoryChanged(String? val) {
    selectedCategory.value = val;
    selectedSubService.value = null;
    applyFilters();
  }

  void onSubServiceChanged(String? val) {
    selectedSubService.value = val;
    applyFilters();
  }

  void clearFilters() {
    selectedCategory.value = null;
    selectedSubService.value = null;
    minRating.value = 0.0;
    lawyers.assignAll(_allLawyers);
  }
}