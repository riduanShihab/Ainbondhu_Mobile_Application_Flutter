import 'package:get/get.dart';

class ChatController extends GetxController {
  var chatList = <Map<String, dynamic>>[].obs;
  var filteredChatList = <Map<String, dynamic>>[].obs;
  var messages = <Map<String, dynamic>>[].obs; // চ্যাট ডিটেইলের জন্য

  @override
  void onInit() {
    super.onInit();
    loadDemoData();
  }

  void loadDemoData() {
    var data = [
      {"id": 1, "name": "অ্যাডভোকেট রহিম", "lastMessage": "কাল কোর্টে দেখা হবে।", "time": "10:30 AM", "unread": 2},
      {"id": 2, "name": "ব্যারিস্টার ফাহিম", "lastMessage": "আপনার ফাইলটি পেয়েছি।", "time": "Yesterday", "unread": 0},
      {"id": 3, "name": "অ্যাডভোকেট সুমি", "lastMessage": "ধন্যবাদ স্যার।", "time": "Monday", "unread": 5},
    ];
    chatList.assignAll(data);
    filteredChatList.assignAll(data);
  }

  void filterChats(String query) {
    if (query.isEmpty) {
      filteredChatList.assignAll(chatList);
    } else {
      filteredChatList.assignAll(
        chatList.where((chat) => chat["name"].toString().toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
  }

  void loadChat(int id) {
    int index = chatList.indexWhere((element) => element["id"] == id);
    if (index != -1) {
      chatList[index]["unread"] = 0;
      chatList.refresh();
    }
    // ডেমো মেসেজ
    messages.assignAll([
      {"sender": "other", "text": "আসসালামু আলাইকুম", "time": "10:00 AM"},
      {"sender": "me", "text": "ওয়ালাইকুম আসসালাম", "time": "10:05 AM"},
    ]);
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    messages.add({"sender": "me", "text": text, "time": "Just now"});
  }
}