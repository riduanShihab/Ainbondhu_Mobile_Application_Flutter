import 'package:ain_bondhu_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  bool _colorsVisible = false;
  bool _whiteCoverVisible = false;
  bool _logoVisible = false;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      _startAnimation();
    });
  }

  void _startAnimation() async {
    if (!mounted) return;
    setState(() => _colorsVisible = true);
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;
    setState(() => _whiteCoverVisible = true);
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;
    setState(() => _logoVisible = true);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Get.width;
    final double screenHeight = Get.height;
    final double halfWidth = screenWidth / 2;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOutQuart,
            left: _colorsVisible ? 0 : -halfWidth,
            top: 0, bottom: 0, width: halfWidth,
            child: Container(color: AppColors.green),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOutQuart,
            right: _colorsVisible ? 0 : -halfWidth,
            top: 0, bottom: 0, width: halfWidth,
            child: Container(color: AppColors.golden),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOutQuart,
            left: _whiteCoverVisible ? 0 : -halfWidth,
            top: 0, bottom: 0, width: halfWidth,
            child: Container(color: AppColors.white),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOutQuart,
            right: _whiteCoverVisible ? 0 : -halfWidth,
            top: 0, bottom: 0, width: halfWidth,
            child: Container(color: AppColors.white),
          ),
          if (_logoVisible)
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/logo.png', width: screenWidth * 0.4),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'আইনবন্ধু',
                      style: GoogleFonts.anekBangla(
                        color: AppColors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      'ন্যায়ের পথে আপনার বিশ্বস্ত বন্ধু!',
                      style: GoogleFonts.anekBangla(color: AppColors.textGrey, fontSize: 14),
                    ),
                    SizedBox(height: screenHeight * 0.15),
                    SizedBox(
                      width: screenWidth * 0.55,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () => Get.offNamed(AppRoutes.intro),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonGreen,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 4,
                        ),
                        child: Text(
                          'চালিয়ে যান',
                          style: GoogleFonts.anekBangla(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}