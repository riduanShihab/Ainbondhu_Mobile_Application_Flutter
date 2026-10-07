import 'package:get/get.dart';
import '../models/lawyer_side_model.dart';

class LawyerAppointmentController extends GetxController {
  var selectedTab = 0.obs; // 0 = Requests, 1 = My Appointments
  var appointmentRequests = <AppointmentModel>[].obs;
  var myAppointments = <AppointmentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAppointments();
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void loadAppointments() {
    // Mock Data for Requests
    appointmentRequests.value = [
      AppointmentModel(
        id: '1',
        name: 'খালেদ আল্লাম',
        date: '১২/১২/২০২৪',
        time: 'দুপুর ২:২০',
        type: 'General',
        image: 'https://i.pravatar.cc/150?img=11',
        status: 'Pending',
        email: 'email@gmail.com',
        phone: '+880123456789',
        subject: 'help lagbe',
        summary: 'need help to get justice',
      ),
      AppointmentModel(
        id: '2',
        name: 'খালেদ আল্লাম',
        date: '১২/১২/২০২৪',
        time: 'দুপুর ২:২০',
        type: 'General',
        image: 'https://i.pravatar.cc/150?img=12',
        status: 'Pending',
        email: 'email@gmail.com',
        phone: '+880123456789',
        subject: 'help lagbe',
        summary: 'need help to get justice',
      ),
    ];

    // Mock Data for Confirmed Appointments
    myAppointments.value = [
      AppointmentModel(
        id: '3',
        name: 'khaled ammar',
        date: '12/12/2342',
        time: 'সকাল ১০:৩০',
        type: 'প্রাথমিক পরামর্শ',
        image: 'https://i.pravatar.cc/150?img=5',
        status: 'Confirmed',
        duration: '১ ঘণ্টা',
        meetLink: 'Meet',
        email: 'khaledammar2@gmail.com',
        phone: '234',
        subject: '2342',
        summary:
        'আমার সমস্যা হলো, আমি সম্প্রতি একটি আইনগত জটিলতার মধ্যে পড়েছি এবং সাহায্য চাই। আমি চাই একজন অভিজ্ঞ আইনজীবী আমার পরিস্থিতি বুঝে আমাকে পরামর্শ এবং সমাধান দিতে পারে।',
      ),
      AppointmentModel(
        id: '4',
        name: 'khaled ammar',
        date: '12/12/2342',
        time: 'সকাল ১০:৩০',
        type: 'প্রাথমিক পরামর্শ',
        image: 'https://i.pravatar.cc/150?img=5',
        status: 'Confirmed',
        duration: '১ ঘণ্টা',
        meetLink: 'Zoom',
        email: 'khaledammar2@gmail.com',
        phone: '234',
        subject: '2342',
        summary: 'Testing summary text.',
      ),
    ];
  }
}