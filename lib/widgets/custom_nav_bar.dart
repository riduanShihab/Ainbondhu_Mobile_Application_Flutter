import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final bool isLawyerMode;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.isLawyerMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))
          ]
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: AppColors.green,
        unselectedItemColor: AppColors.textGrey,
        type: BottomNavigationBarType.fixed,
        items: isLawyerMode ? _lawyerItems() : _customerItems(),
      ),
    );
  }

  List<BottomNavigationBarItem> _customerItems() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'হোম'),
      BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: 'অ্যাপয়েন্টমেন্ট'),
      BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'আলোচনা'),
      BottomNavigationBarItem(icon: Icon(Icons.work_outline), label: 'সেবা নিন'),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'প্রোফাইল'),
    ];
  }

  List<BottomNavigationBarItem> _lawyerItems() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'ড্যাশবোর্ড'),
      BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'অনুরোধ'),
      BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'আলোচনা'),
      BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'সেবা নিন'),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'প্রোফাইল'),
    ];
  }
}