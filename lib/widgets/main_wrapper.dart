import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import '../controllers/nav_controller.dart';
import '../controllers/user_profile_controller.dart';
import '../screens/lawyer_main_profile_screen.dart';
import '../screens/lawyer_my_services_screen.dart';
import 'custom_nav_bar.dart';
import '../screens/home_screen.dart';
import '../screens/lawyer_appointment_screen.dart';
import '../screens/lawyer_home_screen.dart';
import '../screens/lawyer_search_screen.dart';
import '../screens/chat_list_screen.dart';
import '../screens/search_service_screen.dart';
import '../screens/user_profile_screen.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});

  // These must stay in memory for the life of the app
  final NavController navController = Get.put(NavController(), permanent: true);
  final UserProfileController profileController = Get.find<UserProfileController>();
  final ChatController chatController = Get.put(ChatController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isLawyer = profileController.isLawyerMode.value;
      int currentIndex = navController.selectedIndex.value;

      final List<Widget> customerScreens = [
        HomeScreen(),
        LawyerSearchScreen(),
        ChatListScreen(),
        ServiceSearchScreen(),
        UserProfileScreen(),
      ];

      final List<Widget> lawyerScreens = [
        LawyerHomeScreen(),
        LawyerAppointmentScreen(),
        ChatListScreen(),
        LawyerMyServicesScreen(),
        LawyerSideProfileScreen(),
      ];

      return Scaffold(
        // The IndexedStack keeps the 5 tabs alive in memory
        body: IndexedStack(
          index: currentIndex,
          children: isLawyer ? lawyerScreens : customerScreens,
        ),
        bottomNavigationBar: CustomNavBar(
          isLawyerMode: isLawyer,
          selectedIndex: currentIndex,
          onItemTapped: (index) {
            // When clicking Bottom Nav, we simply change the index
            navController.changeIndex(index);
          },
        ),
      );
    });
  }
}