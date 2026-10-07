import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/user_profile_controller.dart';
import '../utils/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserProfileController userController =
  Get.find<UserProfileController>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController nidController;
  late TextEditingController addressController;
  late TextEditingController cityController;

  @override
  void initState() {
    super.initState();
    final profile = userController.userProfile.value;
    nameController = TextEditingController(text: profile.name);
    // Split name if first/last needed, but we have full name in model
    emailController = TextEditingController(text: profile.email);
    phoneController = TextEditingController(text: profile.phone ?? "");
    nidController = TextEditingController(text: profile.nid ?? "");
    addressController = TextEditingController(text: profile.address ?? "");
    cityController = TextEditingController(text: profile.city ?? "");
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nidController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: AppColors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "প্রোফাইল সেটিংস",
          style: GoogleFonts.anekBangla(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Get.width * 0.04),
        child: Column(
          children: [
            // Profile Image Section
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Obx(
                              () => CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.green,
                            backgroundImage: NetworkImage(
                              userController.userProfile.value.image,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "প্রোফাইল ছবি পরিবর্তন করুন",
                    style: GoogleFonts.anekBangla(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "JPG, PNG বা GIF (সর্বোচ্চ ৫MB)",
                    style: GoogleFonts.anekBangla(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Get.height * 0.04),

            // Form
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputGroup(
                  "নাম",
                  "আপনার নাম",
                  controller: nameController,
                ),
                _buildInputGroup(
                  "ইমেইল",
                  "আপনার ইমেইল",
                  icon: Icons.email_outlined,
                  controller: emailController,
                ),
                _buildInputGroup(
                  "ফোন নম্বর",
                  "আপনার ফোন নম্বর",
                  icon: Icons.phone_outlined,
                  controller: phoneController,
                ),
                _buildInputGroup(
                  "জাতীয় পরিচয়পত্র নম্বর",
                  "NID নম্বর",
                  controller: nidController,
                ),
                _buildInputGroup(
                  "ঠিকানা",
                  "আপনার ঠিকানা",
                  icon: Icons.location_on_outlined,
                  minLines: 2,
                  controller: addressController,
                ),
                _buildInputGroup(
                  "শহর",
                  "আপনার শহর",
                  controller: cityController,
                ),
              ],
            ),

            SizedBox(height: Get.height * 0.03),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "বাতিল করুন",
                      style: GoogleFonts.anekBangla(
                        color: Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      userController.updateUserInfo(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        nid: nidController.text,
                        address: addressController.text,
                        city: cityController.text,
                      );
                      Get.back(); // Close screen
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "সংরক্ষণ করুন",
                      style: GoogleFonts.anekBangla(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.05),
          ],
        ),
      ),
    );
  }

  Widget _buildInputGroup(
      String label,
      String hint, {
        IconData? icon,
        int minLines = 1,
        required TextEditingController controller,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.anekBangla(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller,
            minLines: minLines,
            maxLines: minLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.anekBangla(color: Colors.grey.shade400),
              prefixIcon: icon != null
                  ? Icon(icon, color: Colors.grey.shade500, size: 20)
                  : null,
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}