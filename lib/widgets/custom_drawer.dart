import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Using Material with transparent color instead of Drawer to allow custom transparency
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Blur Effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.transparent),
            ),
          ),

          Column(
            children: [
              /// Opaque Menu Content
              Container(
                color: Colors.white,
                width: double.infinity,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Wrap content height
                    children: [
                      /// Header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 40,
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
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'ন্যায়ের পথে আপনার বিশ্বস্ত বন্ধু!',
                                      style: GoogleFonts.anekBangla(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),

                      /// Menu Items
                      _buildMenuItem(
                        Icons.home_outlined,
                        'হোম',
                        () => Get.toNamed(AppRoutes.home),
                      ),
                      _buildMenuItem(
                        Icons.work_outline,
                        'সেবা নিন',
                        () => Get.toNamed(AppRoutes.serviceSearch),
                      ),
                      _buildMenuItem(
                        Icons.calendar_today_outlined,
                        'অ্যাপয়েন্টমেন্ট',
                        () => Get.toNamed(AppRoutes.requestedAppointments),
                      ),
                      _buildMenuItem(Icons.person_outline, 'প্রোফাইল', () {
                        // Profile navigation placeholder
                      }),

                      /// Logout
                      _buildMenuItem(
                        Icons.logout,
                        'লগআউট',
                        () {
                          Get.offAllNamed(AppRoutes.authSelection);
                        },
                        textColor: Colors.red,
                        iconColor: Colors.red,
                      ),

                      /// Footer Button
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              // Lawyer register action
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF1B5E20)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'আইনজীবী রেজিস্টার',
                              style: GoogleFonts.anekBangla(
                                color: const Color(0xFF1B5E20),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ), // Bottom padding for the white area
                    ],
                  ),
                ),
              ),

              /// Transparent Area (Clickable to close)
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  behavior: HitTestBehavior.translucent,
                  child: Container(color: Colors.transparent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? const Color(0xFF1B5E20)),
      title: Text(
        title,
        style: GoogleFonts.anekBangla(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor ?? Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }
}
