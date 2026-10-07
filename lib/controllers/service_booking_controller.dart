import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ServiceBookingController extends GetxController {
  // Step State (1 = Form, 2 = Review, 3 = Success)
  var currentStep = 1.obs;

  // Form Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final descController = TextEditingController();

  // Package Info (Passed from previous screen)
  var packageName = "স্ট্যান্ডার্ড".obs;
  var price = "৳১০০০".obs;

  // File Upload State
  var selectedFileName = "".obs;

  @override
  void onInit() {
    super.onInit();
    // Get arguments from Service Details Page
    if(Get.arguments != null) {
      packageName.value = Get.arguments['package'] ?? "স্ট্যান্ডার্ড";
      price.value = Get.arguments['price'] ?? "৳১০০০";
    }
  }

  // ✅ 1. File Picker Logic
  Future<void> pickFile() async {
    // try {
    //   FilePickerResult? result = await FilePicker.platform.pickFiles(
    //     type: FileType.custom,
    //     allowedExtensions: ['pdf', 'doc', 'docx'],
    //   );
    //   if (result != null) {
    //     selectedFileName.value = result.files.single.name;
    //   }
    // } catch (e) {
    //   print("Error picking file: $e");
    // }

    // Dummy logic for now as we we are in doing front end

    selectedFileName.value = "my_document.pdf";
    Get.snackbar("সফল", "ফাইল নির্বাচন করা হয়েছে", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
  }

  //  2. Validate & Move to Step 2
  void goToReviewStep() {
    if (nameController.text.trim().isEmpty) {
      _showError("অনুগ্রহ করে আপনার নাম দিন");
      return;
    }
    if (emailController.text.trim().isEmpty || !emailController.text.contains('@')) {
      _showError("সঠিক ইমেইল ঠিকানা দিন");
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      _showError("ফোন নম্বর প্রয়োজন");
      return;
    }
    if (descController.text.trim().isEmpty) {
      _showError("দয়া করে আপনার সমস্যার বিবরণ দিন");
      return;
    }
    // Optional: Force file upload
    // if (selectedFileName.value.isEmpty) {
    //   _showError("দয়া করে একটি ডকুমেন্ট আপলোড করুন");
    //   return;
    // }

    // If valid, go to next step
    currentStep.value = 2;
  }

  void goBackToForm() {
    currentStep.value = 1;
  }

  //  3. Confirm & Move to Step 3 (Success)
  void confirmRequest() {

    Future.delayed(const Duration(seconds: 1), () {
      currentStep.value = 3;
    });
  }

  void _showError(String msg) {
    Get.snackbar("ত্রুটি", msg,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM
    );
  }

  // Reset for new booking
  void reset() {
    currentStep.value = 1;
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    descController.clear();
    selectedFileName.value = "";
  }
}