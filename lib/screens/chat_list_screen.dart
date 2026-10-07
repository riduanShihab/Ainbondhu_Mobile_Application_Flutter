import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});

  final ChatController controller = Get.find<ChatController>();
  final TextEditingController searchCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find<ChatController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(" আলোচনা"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                hintText: "আইনজীবী খুঁজুন…",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) => controller.filterChats(value),
            ),
          ),


          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.filteredChatList.length,
              itemBuilder: (context, index) {
                final chat = controller.filteredChatList[index];
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(chat["name"].toString()),
                  subtitle: Text(chat["lastMessage"].toString()),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        chat["time"].toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      if (chat["unread"] != null && chat["unread"] > 0)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            chat["unread"].toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    controller.loadChat(chat["id"]);
                    Get.to(() => ChatDetailScreen(userName: chat["name"].toString()));
                  },
                );
              },
            ),
            ),
          ),
        ],
      ),
    );
  }
}