import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class RequestedAppointmentDetailsScreen extends StatelessWidget {
  const RequestedAppointmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0), // Light grey background
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B431C), // Deep green from image
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text('সেবা', style: GoogleFonts.anekBangla(color: Colors.white, fontSize: 18)),
            Text('আপনার সেবা সমূহ দেখুন', style: GoogleFonts.anekBangla(color: Colors.white70, fontSize: 12)),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 4,
              itemBuilder: (context, index) => _buildServiceCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text("ফিল্টার:", style: GoogleFonts.anekBangla(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              _topChip('সব (৪)', isSelected: true),
              const SizedBox(width: 8),
              _topChip('অপেক্ষমান (২)'),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _subChip('চলমান (১)'),
                _subChip('সম্পূর্ণ (১)'),
                _subChip('প্রত্যাখ্যাত (০)'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _topChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1B431C) : const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(label, style: GoogleFonts.anekBangla(color: isSelected ? Colors.white : Colors.black54)),
    );
  }

  Widget _subChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: GoogleFonts.anekBangla(fontSize: 13, color: Colors.black87)),
    );
  }

  Widget _buildServiceCard(int index) {
    // Status Logic for the UI demo
    List<String> statuses = ['অপেক্ষমান', 'চলমান', 'বাতিল', 'সম্পূর্ণ'];
    List<Color> statusColors = [Colors.orange, Colors.green, Colors.red, Colors.blue];

    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF1B431C), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 25, backgroundColor: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('রহিম আহমেদ', style: GoogleFonts.anekBangla(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('আইনী সেবা', style: GoogleFonts.anekBangla(color: Colors.grey, fontSize: 12)),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 14),
                        Text(' 4.8', style: GoogleFonts.anekBangla(fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(' (১২০ রিভিউ)', style: GoogleFonts.anekBangla(fontSize: 12, color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              ),
              const Icon(Icons.notifications_none, color: Colors.grey),
              const SizedBox(width: 10),
              _statusBadge(statuses[index % 4], statusColors[index % 4]),
            ],
          ),
          const SizedBox(height: 15),
          Text('সেবার ধরন:', style: GoogleFonts.anekBangla(fontSize: 12, color: Colors.grey)),
          Text('চুক্তিনামা তৈরি-ব্যবসায়িক চুক্তি', style: GoogleFonts.anekBangla(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('চুক্তি সংক্রান্ত আইনী সহায়তা প্রদানের মাধ্যমে সকল প্রয়োজনীয় নথি প্রস্তুত।',
              style: GoogleFonts.anekBangla(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 15),
          Row(
            children: [
              _infoBox('অভিজ্ঞতা', '৳৫,০০০', const Color(0xFFE8F5E9), Colors.green),
              const SizedBox(width: 8),
              _infoBox('রেটিং', '---', const Color(0xFFE3F2FD), Colors.blue),
              const SizedBox(width: 8),
              _infoBox('আইডি', 'REQ-001', const Color(0xFFF3E5F5), Colors.purple),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _actionButton('রিপোর্ট দিন', Colors.red, isOutlined: index % 4 == 0)),
              const SizedBox(width: 10),
              Expanded(child: _actionButton('আলোচনা করুন', Colors.blue, isOutlined: index % 4 == 0, icon: Icons.chat_bubble_outline)),
            ],
          ),
          if (index % 4 == 2) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFF37474F), borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  Text('আপনার এই অনুরোধটি বাতিল করা হয়েছে', style: GoogleFonts.anekBangla(color: Colors.white, fontSize: 11)),
                ],
              ),
            )
          ]
        ],
      ),
    );
  }

  Widget _statusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: GoogleFonts.anekBangla(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _infoBox(String title, String value, Color bgColor, Color textColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(title, style: GoogleFonts.anekBangla(fontSize: 10, color: Colors.grey)),
            Text(value, style: GoogleFonts.anekBangla(fontSize: 12, fontWeight: FontWeight.bold, color: textColor)),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String label, Color color, {bool isOutlined = false, IconData? icon}) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: isOutlined ? Colors.transparent : color,
        borderRadius: BorderRadius.circular(10),
        border: isOutlined ? Border.all(color: Colors.grey.shade300) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, color: isOutlined ? Colors.grey : Colors.white, size: 16),
          if (icon != null) const SizedBox(width: 5),
          Text(label, style: GoogleFonts.anekBangla(color: isOutlined ? Colors.grey : Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}