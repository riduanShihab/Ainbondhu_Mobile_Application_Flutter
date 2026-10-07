import 'package:ain_bondhu_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/routes.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboarding1.png",
      "text": "একই অ্যাপে সব ধরণের আইনগত সেবা সহজ প্রক্রিয়ায়, আরও বেশি সুবিধাসহ।"
    },
    {
      "image": "assets/images/onboarding2.png",
      "text": "আপনার শহরের নাম এবং যেসব আইনি বিশেষজ্ঞ খুঁজছেন তা লিখুন।"
    },
    {
      "image": "assets/images/onboarding3.png",
      "text": "আপনার সমস্যার ধরন অনুযায়ী যোগ্যতা, অভিজ্ঞতা এবং রিভিউ দেখে সেরা ভেরিফায়েড আইনজীবীর প্রোফাইল বেছে নিন।"
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      Get.toNamed(AppRoutes.authSelection);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Get.height;
    final double screenWidth = Get.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: screenWidth * 0.15,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textBlack,
            size: screenWidth * 0.07,
          ),
          onPressed: () => Get.offAllNamed(AppRoutes.splash),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      onboardingData[index]["image"]!,
                      height: screenHeight * 0.35,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
                      child: Text(
                        onboardingData[index]["text"]!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.anekBangla(
                          fontSize: screenWidth * 0.048,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(right: screenWidth * 0.02),
                  height: screenHeight * 0.008,
                  width: _currentPage == index ? screenWidth * 0.08 : screenWidth * 0.025,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? AppColors.primaryBlue : AppColors.textGrey,
                    borderRadius: BorderRadius.circular(screenWidth * 0.01),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.06),
              child: SizedBox(
                width: screenWidth * 0.65,
                height: screenHeight * 0.068,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.08),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'চালিয়ে যান',
                    style: GoogleFonts.anekBangla(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}