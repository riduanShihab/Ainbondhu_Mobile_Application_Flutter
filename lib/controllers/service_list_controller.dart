import 'package:get/get.dart';
import '../models/lawyer_service_model.dart';
import '../models/lawyer_model.dart';

class ServiceListController extends GetxController {
  late Lawyer lawyer;

  final List<LawyerService> services = [
    LawyerService(
      category: "জমি ও বাড়ি",
      title: "জমি রেজিস্ট্রেশন",
      subTitle: "সম্পত্তি হস্তান্তর",
      description: "মাটি ক্রয়-বিক্রয় দলিলের প্রস্তুতি এবং রেজিস্ট্রেশন",
      packages: [
        ServicePackage(name: "স্ট্যান্ডার্ড", time: "১০ দিন সময়", price: "৳৫,৫০০"),
        ServicePackage(name: "উন্নত", time: "৭ দিন সময়", price: "৳৮,০০০"),
        ServicePackage(name: "প্রিমিয়াম", time: "৩ দিন সময়", price: "৳১০,৫০০"),
      ],
    ),
    LawyerService(
      category: "দেওয়ানি মামলা",
      title: "ফৌজদারি মামলা",
      subTitle: "পারিবারিক আইন",
      description: "ফৌজদারি মামলার সম্পূর্ণ পরিচালনা",
      packages: [
        ServicePackage(name: "স্ট্যান্ডার্ড", time: "৫ দিন সময়", price: "৳১০,০০০"),
        ServicePackage(name: "উন্নত", time: "৩ দিন সময়", price: "৳১৫,০০০"),
        ServicePackage(name: "প্রিমিয়াম", time: "১ দিন সময়", price: "৳২০,০০০"),
      ],
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Lawyer) {
      lawyer = Get.arguments;
    } else {
      lawyer = Lawyer(
        name: "রবার্ট লি",
        role: "ফৌজদারি আইন - কর্পোরেট আইন",
        experience: "১৫ বছর",
        cases: "৩০০টি",
        rate: "৳১০০০",
        rating: 4.9,
        status: "অনলাইন",
        imagePath: 'assets/images/lawyer_image.jpg',
        bio: "",
        practiceAreas: [],
      );
    }
  }
}