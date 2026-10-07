import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../utils/routes.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('অ্যাপ থেকে বের হতে চান?',
            style: GoogleFonts.anekBangla(fontWeight: FontWeight.bold)),
        content: Text('আপনি কি নিশ্চিত যে আপনি অ্যাপটি বন্ধ করতে চান?',
            style: GoogleFonts.anekBangla()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('না', style: GoogleFonts.anekBangla(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20)),
            child: Text('হ্যাঁ', style: GoogleFonts.anekBangla(color: Colors.white)),
          ),
        ],
      ),
    ) ??
        false;
  }

  final List<Map<String, dynamic>> bannerData = [
    {
      'title': 'আইনজীবীর সেবা খুঁজুন',
      'subtitle': 'বিশ্বাসযোগ্য আইনজীবীর সেবা নিন খুব সহজেই',
      'buttonText': 'সেবা নিন',
      'image': 'assets/images/banner_couple.png',
      'route': AppRoutes.serviceSearch,
      'colors': [const Color(0xFF2E7D32), const Color(0xFF43A047)],
    },
    {
      'title': 'পরামর্শ নিন',
      'subtitle': 'পরামর্শ নিন খুব সহজেই',
      'buttonText': 'পরামর্শ বুক করুন',
      'image': 'assets/images/banner_lady.png',
      'route': AppRoutes.consultation,
      'colors': [const Color(0xFFD4A017), const Color(0xFFB8860B)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool canPop = Navigator.canPop(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        final bool shouldExit = await _showExitDialog(context);
        if (shouldExit) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        endDrawer: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const CustomDrawer(),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: canPop
              ? IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
            onPressed: () => Get.back(),
          )
              : null,
          titleSpacing: canPop ? 0 : 16,
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
                children: [
                  Text(
                    'আইনবন্ধু',
                    style: GoogleFonts.anekBangla(
                      color: const Color(0xFF1B5E20),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    'ন্যায়ের পথে আপনার বিশ্বস্ত বন্ধু!',
                    style: GoogleFonts.anekBangla(
                      color: Colors.grey[600],
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSlider(context),
              _buildServiceGrid(context),
              _buildActionCards(),
              _buildTopLawyersSection(),
              _buildContactCard(),
              _buildMeetingSection(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSlider(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 240.0,
            autoPlay: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) => controller.updateSliderIndex(index),
          ),
          items: bannerData.map((data) => _buildSingleBannerItem(data)).toList(),
        ),
        Obx(
              () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bannerData.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF2E7D32).withOpacity(
                    controller.currentSliderIndex.value == entry.key ? 0.9 : 0.2,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleBannerItem(Map<String, dynamic> data) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: data['colors'] as List<Color>,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 40,
            right: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['title'],
                  style: GoogleFonts.anekBangla(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data['subtitle'],
                  style: GoogleFonts.anekBangla(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Get.toNamed(data['route']),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: (data['colors'] as List<Color>).first,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text(
                    data['buttonText'],
                    style: GoogleFonts.anekBangla(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(data['image'], height: 220, fit: BoxFit.fitHeight),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceGrid(BuildContext context) {
    final services = [
      {'image': 'assets/images/contract.png', 'label': 'চুক্তিপত্র তৈরি'},
      {'image': 'assets/images/trademark.png', 'label': 'ট্রেডমার্ক'},
      {'image': 'assets/images/tax.png', 'label': 'কর ও হিসাব'},
      {'image': 'assets/images/notary.png', 'label': 'নোটারি'},
      {'image': 'assets/images/property.png', 'label': 'সম্পত্তি সেবা'},
      {'image': 'assets/images/court.png', 'label': 'আদালত'},
      {'image': 'assets/images/license.png', 'label': 'লাইসেন্স'},
      {'image': 'assets/images/expert.png', 'label': 'বিশেষজ্ঞ পরামর্শ'},
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE3F2FD), Color(0xFFF1F8E9)],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('আমাদের সেবা', style: GoogleFonts.anekBangla(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.75,
              mainAxisSpacing: 16,
              crossAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                    ),
                    child: Image.asset(services[index]['image']!, fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    services[index]['label']!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: GoogleFonts.anekBangla(fontSize: 12, fontWeight: FontWeight.w500, height: 1.1),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('তাৎক্ষণিক কার্যক্রম', style: GoogleFonts.anekBangla(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.consultation),
                  child: _buildVerticalActionCard('assets/images/appointment.png', "পরামর্শ নিন"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.serviceSearch),
                  child: _buildVerticalActionCard('assets/images/service.png', "সেবা নিন"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalActionCard(String imagePath, String title) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF388E3C), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(imagePath, height: 32, width: 32, color: Colors.white),
          Text(title, style: GoogleFonts.anekBangla(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildTopLawyersSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('শীর্ষ আইনজীবী', style: GoogleFonts.anekBangla(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('সব দেখুন', style: GoogleFonts.anekBangla(color: const Color(0xFF2E7D32), fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 180,
                margin: const EdgeInsets.only(right: 16, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1B5E20), width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    children: [
                      Positioned.fill(child: Image.asset('assets/images/lawyer_image.jpg', fit: BoxFit.cover)),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(9.0),
                          color: Colors.white.withOpacity(0.9),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('রবার্ট লি', style: GoogleFonts.anekBangla(fontWeight: FontWeight.bold, fontSize: 18)),
                              Text('আইন বিশেষজ্ঞ', style: GoogleFonts.anekBangla(fontSize: 14, color: Colors.amber[800])),
                              Row(
                                children: [
                                  const Icon(Icons.star, size: 16, color: Colors.amber),
                                  Text(" 4.5", style: GoogleFonts.anekBangla()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(color: const Color(0xFF1B5E20), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('যোগাযোগের তথ্য', style: GoogleFonts.anekBangla(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildContactRow(Icons.phone, 'ফোন নম্বর', '+8801811111111'),
          const SizedBox(height: 16),
          _buildContactRow(Icons.email, 'ইমেইল', 'PDA@gmail.com'),
          const SizedBox(height: 16),
          _buildContactRow(Icons.location_on, 'ঠিকানা', 'IT Business Incubator, CUET'),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        CircleAvatar(backgroundColor: Colors.white24, child: Icon(icon, color: Colors.white, size: 20)),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: GoogleFonts.anekBangla(color: Colors.white70, fontSize: 12)),
            Text(value, style: GoogleFonts.anekBangla(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  Widget _buildMeetingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/images/meeting.jpg', height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B5E20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => Get.toNamed(AppRoutes.consultation),
              child: Text("পরামর্শ নিন", style: GoogleFonts.anekBangla(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}