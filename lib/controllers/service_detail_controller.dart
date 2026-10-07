import 'package:get/get.dart';

class ServiceDetailController extends GetxController {
  // 0 = Standard, 1 = Advanced, 2 = Premium
  var selectedPackageIndex = 0.obs;

  // Dummy Data for Packages
  final List<Map<String, dynamic>> packages = [
    {
      "name": "স্ট্যান্ডার্ড",
      "price": "৳১০০০",
      "desc": "উন্নত ব্যবসায়িক চুক্তি করা হয়। আপনার ব্যবসার জন্য নিরাপদ ও আইনি ভাবে শক্তিশালী চুক্তিপত্র প্রস্তুত করা হয়।",
      "delivery": "৭ দিনে ডেলিভারি",
      "features": ["সঠিক পর্যালোচনা", "১টি সংশোধন", "স্ট্যান্ডার্ড ফরম্যাট"]
    },
    {
      "name": "উন্নত",
      "price": "৳৩০০০",
      "desc": "দ্রুত এবং বিস্তারিত আইনি সুরক্ষা সহ চুক্তিপত্র। জটিল শর্তাবলী এবং বিশেষ আইনি সুরক্ষা অন্তর্ভুক্ত।",
      "delivery": "৩ দিনে ডেলিভারি",
      "features": ["গভীর পর্যালোচনা", "৩টি সংশোধন", "প্রিন্ট রেডি ফাইল", "লিগাল অ্যাডভাইস"]
    },
    {
      "name": "প্রিমিয়াম",
      "price": "৳৫০০০",
      "desc": "ভিআইপি সাপোর্ট এবং আনলিমিটেড সংশোধন। আপনার ব্যবসার সম্পূর্ণ আইনি সুরক্ষার জন্য সর্বোচ্চ মানের সেবা।",
      "delivery": "১ দিনে ডেলিভারি",
      "features": ["আনলিমিটেড সংশোধন", "ভিআইপি সাপোর্ট", "সরাসরি মিটিং", "সম্পূর্ণ কাস্টম ড্রাফটিং"]
    }
  ];

  void changePackage(int index) {
    selectedPackageIndex.value = index;
  }
}