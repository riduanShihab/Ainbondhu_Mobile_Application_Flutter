import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LawyerServiceRequestsController extends GetxController {
  var selectedFilter = 'সব'.obs;
  var filters = ['সব', 'অপেক্ষায়', 'গৃহীত', 'সম্পূর্ণ', 'প্রত্যাখ্যাত'];

  var requests = <Map<String, dynamic>>[
    {
      'id': 'REQ-001',
      'applicantName': 'রহিম আহমেদ',
      'serviceTitle': 'চুক্তিপত্র তৈরি - ব্যবসায়িক চুক্তি',
      'classification': 'স্ট্যান্ডার্ড',
      'price': '৳৫,০০০',
      'date': '২০২৪-০১-১৬',
      'status': 'অপেক্ষায়',
    },
    {
      'id': 'REQ-002',
      'applicantName': 'রহিম আহমেদ',
      'serviceTitle': 'চুক্তিপত্র তৈরি - ব্যবসায়িক চুক্তি',
      'classification': 'স্ট্যান্ডার্ড',
      'price': '৳৫,০০০',
      'date': '২০২৪-০১-১৬',
      'status': 'সম্পূর্ণ',
    },
    {
      'id': 'REQ-003',
      'applicantName': 'সোহেল রানা',
      'serviceTitle': 'জমি রেজিস্ট্রেশন',
      'classification': 'প্রিমিয়াম',
      'price': '৳১৫,০০০',
      'date': '২০২৪-০১-১৫',
      'status': 'গৃহীত',
    },
    {
      'id': 'REQ-001',
      'applicantName': 'রহিম আহমেদ',
      'serviceTitle': 'চুক্তিপত্র তৈরি - ব্যবসায়িক চুক্তি',
      'classification': 'স্ট্যান্ডার্ড',
      'price': '৳৫,০০০',
      'date': '২০২৪-০১-১৬',
      'status': 'প্রত্যাখ্যাত',
    },
  ].obs;

  List<Map<String, dynamic>> get filteredRequests {
    if (selectedFilter.value == 'সব') {
      return requests;
    }
    return requests
        .where((req) => req['status'] == selectedFilter.value)
        .toList();
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
  }

  void acceptRequest(String id) {
    debugPrint('Accept request $id');
  }

  void rejectRequest(String id) {
    debugPrint('Reject request $id');
  }

  void completeService(String id) {
    debugPrint('Complete service $id');
  }
}
