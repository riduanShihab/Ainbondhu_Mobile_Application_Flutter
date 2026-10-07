import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/service_detail_controller.dart';
import '../controllers/nav_controller.dart';
import '../widgets/custom_nav_bar.dart';
import '../utils/routes.dart';
import '../utils/app_colors.dart';

class ServiceDetailScreen extends StatelessWidget {
  ServiceDetailScreen({super.key});

  final ServiceDetailController controller = Get.put(ServiceDetailController());
  final NavController navController = Get.find<NavController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navController.selectedIndex.value = 3;
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('সেবা',
                style: GoogleFonts.anekBangla(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)
            ),
            Text('চুক্তিপত্র তৈরি - ব্যবসায়িক চুক্তি',
                style: GoogleFonts.anekBangla(color: AppColors.white.withOpacity(0.7), fontSize: 12, fontWeight: FontWeight.w300)
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGallery(context),
            const SizedBox(height: 20),
            Text(
              'উন্নত ব্যবসায়িক চুক্তি করতে আমরা সহায়তা করি',
              style: GoogleFonts.anekBangla(fontSize: 22, fontWeight: FontWeight.bold, height: 1.2, color: AppColors.textBlack),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/lawyer_image.jpg'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('আব্দুল্লাহ হোসেন', style: GoogleFonts.anekBangla(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.golden, size: 16),
                        Text(' 4.9 (১২৭)', style: GoogleFonts.anekBangla(color: AppColors.textGrey, fontSize: 12)),
                      ],
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Text('সেবার বিবরণ', style: GoogleFonts.anekBangla(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
            const SizedBox(height: 8),
            Text(
              'এই সেবা আপনার সকল ব্যবসায়িক এবং ব্যক্তিগত আইনি প্রয়োজনের জন্য একটি সম্পূর্ণ সমাধান। আমি বিশেষজ্ঞ পরামর্শ প্রদান করি যা আপনার ব্যবসা এবং ব্যক্তিগত বিষয়গুলির জন্য তৈরি করা হয়েছে।',
              style: GoogleFonts.anekBangla(color: AppColors.textGrey, fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 8),
            Text('• আইনি পরামর্শ এবং পরিকল্পনা\n• ডকুমেন্ট প্রস্তুতি এবং পর্যালোচনা\n• চুক্তি আলোচনা\n• আদালতে প্রতিনিধিত্ব\n• মামলার পরিচালনা',
                style: GoogleFonts.anekBangla(color: AppColors.textGrey, fontSize: 13, height: 1.6)),
            const SizedBox(height: 24),
            _buildPackageSection(),
            const SizedBox(height: 24),
            Text('পর্যালোচনা (১২৭)', style: GoogleFonts.anekBangla(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
            const SizedBox(height: 12),
            _buildReviewItem("রাহিম আহমেদ", 4.0, "অসাধারণ সেবা পেয়েছি! অত্যন্ত সহায়ক এবং পেশাদার।"),
            _buildReviewItem("করিম চৌধুরী", 5.0, "খুব দ্রুত কাজ করে দিয়েছেন। আমি সন্তুষ্ট।"),
            _buildReviewItem("সুমাইয়া আক্তার", 4.5, "ধন্যবাদ ভাইয়া, খুব ভালো সার্ভিস।"),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => CustomNavBar(
        selectedIndex: navController.selectedIndex.value,
        onItemTapped: (index) {
          navController.changeIndex(index);
          if (index == 0) Get.offAllNamed(AppRoutes.home);
        },
      )),
    );
  }

  Widget _buildImageGallery(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              'assets/images/service3.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildThumbnail('assets/images/service1.png'),
            const SizedBox(width: 10),
            _buildThumbnail('assets/images/service2.png'),
            const SizedBox(width: 10),
            _buildThumbnail('assets/images/service3.png'),
          ],
        )
      ],
    );
  }

  Widget _buildThumbnail(String path) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Image.asset(
            path,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildPackageSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.green, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            height: 45,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.green)),
            ),
            child: Row(
              children: [
                _buildTabButton("স্ট্যান্ডার্ড", 0),
                Container(width: 1, color: AppColors.green),
                _buildTabButton("উন্নত", 1),
                Container(width: 1, color: AppColors.green),
                _buildTabButton("প্রিমিয়াম", 2),
              ],
            ),
          ),
          Obx(() {
            final package = controller.packages[controller.selectedPackageIndex.value];
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Container(
                key: ValueKey<int>(controller.selectedPackageIndex.value),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(package['name'] + " ব্যবসায়িক চুক্তি", style: GoogleFonts.anekBangla(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textBlack))),
                        Text(package['price'], style: GoogleFonts.anekBangla(color: AppColors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(package['desc'], style: GoogleFonts.anekBangla(fontSize: 12, color: AppColors.textGrey)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 16, color: AppColors.textBlack),
                        const SizedBox(width: 6),
                        Text(package['delivery'], style: GoogleFonts.anekBangla(fontWeight: FontWeight.bold, color: AppColors.textBlack)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...package['features'].map<Widget>((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.check, size: 16, color: AppColors.textBlack),
                          const SizedBox(width: 8),
                          Text(feature, style: GoogleFonts.anekBangla(fontSize: 12, color: AppColors.textBlack)),
                        ],
                      ),
                    )).toList(),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonGreen,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          final package = controller.packages[controller.selectedPackageIndex.value];
                          Get.toNamed(
                              AppRoutes.serviceBooking,
                              arguments: {
                                'package': package['name'],
                                'price': package['price']
                              }
                          );
                        },
                        child: Text("সেবাটি নিন", style: GoogleFonts.anekBangla(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    return Expanded(
      child: Obx(() {
        bool isSelected = controller.selectedPackageIndex.value == index;
        return InkWell(
          onTap: () => controller.changePackage(index),
          child: Container(
            alignment: Alignment.center,
            color: isSelected ? AppColors.green.withOpacity(0.1) : AppColors.white,
            child: Text(
              title,
              style: GoogleFonts.anekBangla(
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.green : AppColors.textBlack,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildReviewItem(String name, double rating, String comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.green.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: GoogleFonts.anekBangla(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textBlack)),
              Row(
                children: List.generate(5, (index) => Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: AppColors.golden, size: 16
                )),
              )
            ],
          ),
          const SizedBox(height: 4),
          Text("২ সপ্তাহ আগে", style: GoogleFonts.anekBangla(color: AppColors.textGrey, fontSize: 10)),
          const SizedBox(height: 6),
          Text(comment, style: GoogleFonts.anekBangla(fontSize: 12, color: AppColors.textBlack)),
        ],
      ),
    );
  }
}