import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';

class ProfessionProfileScreen extends StatelessWidget {
  const ProfessionProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("পেশাগত প্রোফাইল"),
        centerTitle: true,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textBlack,
        elevation: 0,
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("প্রোফাইল তথ্য"),
            rowFields("নাম", "ইমেইল"),
            space(),
            inputField("ফোন নাম্বার"),
            space(),
            inputField("ঠিকানা"),
            spaceLarge(),

            sectionTitle("শিক্ষাগত যোগ্যতা"),
            inputField("ডিগ্রি"),
            space(),
            inputField("প্রতিষ্ঠানের নাম"),
            space(),
            inputField("পাসের সাল"),
            addButton("যোগ্যতা যোগ করুন"),
            spaceLarge(),

            sectionTitle("বার কোয়ালিফিকেশন"),
            inputField("স্টেট বার লাইসেন্স"),
            addButton("লাইসেন্স যোগ করুন"),
            spaceLarge(),

            sectionTitle("পুরস্কার ও স্বীকৃতি"),
            inputField("সেরা আইন উপদেষ্টা পুরস্কার"),
            space(),
            inputField("ন্যাশনাল বার অ্যাসোসিয়েশন", maxLines: 2),
            space(),
            inputField("২০২৫"),
            addButton("অভিজ্ঞতা যোগ করুন"),
            space(),

            sectionTitle("আপনার সম্পর্কে"),
            inputField("আপনার সম্পর্কে", maxLines: 7),
            spaceLarge(),

            SizedBox(
              width: w,
              height: h * 0.065,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "সংরক্ষণ করুন",
                  style: TextStyle(fontSize: 16, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textBlack,
        ),
      ),
    );
  }

  Widget inputField(String hint, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.green, width: 1.5),
        ),
      ),
    );
  }

  Widget rowFields(String h1, String h2) {
    return Row(
      children: [
        Expanded(child: inputField(h1)),
        const SizedBox(width: 12),
        Expanded(child: inputField(h2)),
      ],
    );
  }

  Widget addButton(String text) {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.add, color: AppColors.green),
      label: Text(
        text,
        style: const TextStyle(color: AppColors.green),
      ),
    );
  }

  Widget space() => const SizedBox(height: 10);
  Widget spaceLarge() => const SizedBox(height: 20);
}
