import 'package:ain_bondhu_app/screens/splash_screen.dart';
import 'package:ain_bondhu_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/nav_controller.dart';
import 'controllers/user_profile_controller.dart';
import 'utils/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NavController(), permanent: true);
  Get.put(UserProfileController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ainbondhu',
      theme: ThemeData(
        primaryColor: AppColors.green,
        textTheme: GoogleFonts.anekBanglaTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: AppColors.white,
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}
