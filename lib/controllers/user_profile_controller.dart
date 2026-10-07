import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../utils/routes.dart';
import 'nav_controller.dart';

class UserProfileController extends GetxController {
  // Mode Management
  var isLawyerMode = false.obs;

  // Reactive user data using the Model Class
  var userProfile = UserProfileModel(
    name: "আহমেদ রহমান",
    email: "rahul.ahmed@email.com",
    image: "https://i.pravatar.cc/150?img=11",
    totalInterviews: 3,
    services: 4,
    completed: 12,
    phone: "01700000000",
    nid: "৭৮৬০৯২",
    address: "ধানমন্ডি, ঢাকা",
    city: "ঢাকা",
  ).obs;

  // Toggle logic that works with MainWrapper
  void toggleMode(bool value) {
    isLawyerMode.value = value;
    // Reset MainWrapper index to Home (0)
    Get.find<NavController>().selectedIndex.value = 0;
  }

  // Update User Info Logic
  void updateUserInfo({
    String? name,
    String? email,
    String? phone,
    String? nid,
    String? address,
    String? city,
  }) {
    userProfile.update((val) {
      if (val != null) {
        if (name != null) val.name = name;
        if (email != null) val.email = email;
        if (phone != null) val.phone = phone;
        if (nid != null) val.nid = nid;
        if (address != null) val.address = address;
        if (city != null) val.city = city;
      }
    });

    Get.snackbar(
      "সফল",
      "প্রোফাইল আপডেট করা হয়েছে",
      backgroundColor: const Color(0xFF196420),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Menu Items for the Profile Screen
  final List<ProfileMenuItemModel> menuItems = [
    ProfileMenuItemModel(
      title: "প্রোফাইল",
      subtitle: "আপনার প্রোফাইল পরিচালনা করুন",
      icon: Icons.person_outline,
      route: AppRoutes.editProfile,
    ),
    ProfileMenuItemModel(
      title: "নতুন অ্যাপয়েন্টমেন্ট",
      subtitle: "নতুন অ্যাপয়েন্টমেন্ট নিন",
      icon: Icons.add,
      route: AppRoutes.lawyer_search,
    ),
    ProfileMenuItemModel(
      title: "সেবা দেখুন",
      subtitle: "আপনার সেবা গুলো দেখুন",
      icon: Icons.work_outline,
      route: AppRoutes.serviceSearch,
    ),
    ProfileMenuItemModel(
      title: "সেটিংস",
      subtitle: "অ্যাপের পছন্দসমূহ",
      icon: Icons.settings_outlined,
      route: AppRoutes.settings,
    ),
  ];

  void logout() {
    Get.snackbar("Logout", "Logging out...", snackPosition: SnackPosition.BOTTOM);
  }
}