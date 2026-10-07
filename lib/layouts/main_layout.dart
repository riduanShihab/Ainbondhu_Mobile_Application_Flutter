import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nav_controller.dart';
import '../screens/home_screen.dart';
import '../widgets/custom_nav_bar.dart';

class MainLayout extends StatelessWidget {
  MainLayout({super.key});

  final NavController navController = Get.put(NavController());

  final List<Widget> _pages = [
    HomeScreen(),
    // AppointmentScreen(),
    // ChatScreen(),
    // ServiceScreen(),
    // ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 35,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.balance, color: Color(0xFF1B5E20), size: 32),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('আইনবন্ধু',
                    style: TextStyle(
                        color: Color(0xFF1B5E20),
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
                Text('ন্যায়ের পথে আপনার বিশ্বস্ত বন্ধু!',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => print("Menu Clicked"),
          ),
        ],
      ),
      body: Obx(() => _pages[navController.selectedIndex.value]),
      bottomNavigationBar: Obx(() => CustomNavBar(
        selectedIndex: navController.selectedIndex.value,
        onItemTapped: navController.changeIndex,
      )),
    );
  }
}
