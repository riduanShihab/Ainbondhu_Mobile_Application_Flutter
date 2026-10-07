import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';

class ChatDetailScreen extends StatelessWidget {
  final String userName;
  ChatDetailScreen({super.key, required this.userName});

  final ChatController chatController = Get.find<ChatController>();
  final TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double h = Get.height / 812;
    double w = Get.width / 375;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F2E9),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        elevation: 0,
        toolbarHeight: 60 * h,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24 * w),
          onPressed: () => Get.back(),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20 * w,
              backgroundImage: const AssetImage('assets/images/user_avatar.png'),
            ),
            SizedBox(width: 10 * w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(userName, style: TextStyle(color: Colors.white, fontSize: 16 * w)),
                Text("Active 1 hour ago", style: TextStyle(color: Colors.white70, fontSize: 11 * w)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.phone, color: Colors.white, size: 22 * w), onPressed: () {}),
          IconButton(icon: Icon(Icons.videocam, color: Colors.white, size: 22 * w), onPressed: () {}),
          IconButton(icon: Icon(Icons.info_outline, color: Colors.white, size: 22 * w), onPressed: () {}),
        ],
      ),

      body: Column(
        children: [

          Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 12 * w, vertical: 8 * h),
            color: const Color(0xFF37474F),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.white, size: 20 * w),
                SizedBox(width: 8 * w),
                Expanded(
                  child: Text(
                    "জন এন্ড্রুয়াসন এর সাথে ১০/১২/২০২৩ তারিখ সকাল ১০ টায় অ্যাপয়েন্টমেন্ট আছে",
                    style: TextStyle(color: Colors.white, fontSize: 11 * w),
                  ),
                ),
              ],
            ),
          ),

          // CHAT MESSAGES
          Expanded(
            child: Obx(() => ListView.builder(
              padding: EdgeInsets.all(16 * w),
              itemCount: chatController.messages.length,
              itemBuilder: (context, index) {
                final msg = chatController.messages[index];
                bool isMe = msg["sender"] == "me";

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: Get.width * 0.75),
                        padding: EdgeInsets.symmetric(horizontal: 14 * w, vertical: 10 * h),
                        margin: EdgeInsets.symmetric(vertical: 4 * h),
                        decoration: BoxDecoration(
                          color: isMe ? const Color(0xFF1B5E20) : Colors.white,
                          borderRadius: BorderRadius.circular(8 * w),
                          border: isMe ? null : Border.all(color: Colors.black12),
                        ),
                        child: Text(
                          msg["text"],
                          style: TextStyle(color: isMe ? Colors.white : Colors.black, fontSize: 14 * w),
                        ),
                      ),
                      Text(
                        msg["time"],
                        style: TextStyle(fontSize: 10 * w, color: Colors.grey),
                      ),
                      SizedBox(height: 8 * h),
                    ],
                  ),
                );
              },
            )),
          ),

          // CUSTOM INPUT AREA
          _buildInputArea(h, w),
        ],
      ),
    );
  }

  Widget _buildInputArea(double h, double w) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * w, vertical: 10 * h),
      color: const Color(0xFF1B5E20),
      child: SafeArea(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.add_circle_outline, color: Colors.white, size: 26 * w),
            Icon(Icons.camera_alt_outlined, color: Colors.white, size: 26 * w),
            Icon(Icons.image_outlined, color: Colors.white, size: 26 * w),
            Icon(Icons.mic_none, color: Colors.white, size: 26 * w),
            SizedBox(width: 5 * w),
            Expanded(
              child: Container(
                height: 40 * h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20 * w),
                ),
                child: TextField(
                  controller: msgController,
                  style: TextStyle(fontSize: 14 * w),
                  decoration: InputDecoration(
                    hintText: "Message",
                    contentPadding: EdgeInsets.symmetric(horizontal: 15 * w, vertical: 8 * h),
                    border: InputBorder.none,
                    suffixIcon: Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: Colors.grey,
                        size: 22 * w
                    ),
                  ),
                  onSubmitted: (value) {
                    chatController.sendMessage(value);
                    msgController.clear();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}