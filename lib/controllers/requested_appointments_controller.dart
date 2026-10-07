import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/nav_controller.dart';

class RequestedAppointmentsController extends GetxController {
  // Finding the global NavController
  final NavController navController = Get.find<NavController>();

  // Mock data for the list
  var appointments = <Map<String, String>>[
    {'lawyerName': 'অ্যাডভোকেট মাহমুদ হাসান', 'category': 'ফৌজদারি আইন'},
    {'lawyerName': 'অ্যাডভোকেট ফাতিমা খানম', 'category': 'পারিবারিক আইন'},
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Highlight Profile tab (Index 4)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navController.selectedIndex.value = 4;
    });
  }

  void showCancelDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'আপনি কি নিশ্চিত আপনার অনুরোধ বাতিল করবেন?',
                textAlign: TextAlign.center,
                style: GoogleFonts.anekBangla(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('না, ফিরে যান', style: GoogleFonts.anekBangla(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(); // Close Dialog
                        Get.back(); // Return to list
                        Get.snackbar("সফল", "অনুরোধটি বাতিল করা হয়েছে",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('হ্যাঁ বাতিল করুন', style: GoogleFonts.anekBangla(color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}