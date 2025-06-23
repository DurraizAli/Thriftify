import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/features/shop/controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final comfyBg = LinearGradient(
      colors: [Color(0xFFE0F7FA), Color(0xFFF1F8E9)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thriftify Chatbot 👋🏻",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
              fontFamily: 'Poppins'),
        ),
        backgroundColor: const Color.fromARGB(255, 56, 208, 145),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: comfyBg),
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    itemCount: controller.messages.length,
                    itemBuilder: (_, i) {
                      final msg = controller.messages[i];
                      final isUser = msg["role"] == "user";
                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.75),
                          decoration: BoxDecoration(
                            color:
                                isUser ? Color(0xFFB2DFDB) : Color(0xFFF8BBD0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18),
                              bottomLeft: Radius.circular(isUser ? 18 : 0),
                              bottomRight: Radius.circular(isUser ? 0 : 18),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            msg["content"] ?? "",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            ),
            Obx(() => controller.isLoading.value
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox()),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(24),
                color: Colors.white.withOpacity(0.95),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: "What's brewing in your mind?",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        style: TextStyle(fontSize: 16),
                        minLines: 1,
                        maxLines: 4,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: Color(0xFF26A69A)),
                      onPressed: () {
                        if (textController.text.trim().isNotEmpty) {
                          controller.sendMessage(textController.text.trim());
                          textController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
