
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/features/shop/controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GetX ChatBot")),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.messages.length,
                  itemBuilder: (_, i) {
                    final msg = controller.messages[i];
                    return ListTile(
                      title: Align(
                        alignment: msg["role"] == "user"
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: msg["role"] == "user"
                                ? Colors.blue[100]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(msg["content"] ?? ""),
                        ),
                      ),
                    );
                  },
                )),
          ),
          Obx(() => controller.isLoading.value
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
              : SizedBox()),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  controller.sendMessage(textController.text);
                  textController.clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
