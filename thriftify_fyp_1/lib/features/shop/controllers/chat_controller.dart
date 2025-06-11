import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatController extends GetxController {
  var messages = <Map<String, String>>[].obs;
  var isLoading = false.obs;
  final String _laptopIpAddress = "192.168.137.1";
  final int _port = 9999;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message to chat
    messages.add({"role": "user", "content": text});
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse("http://$_laptopIpAddress:$_port/chat"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data["response"];

        if (reply != null && reply is String) {
          // Add bot reply to chat
          messages.add({"role": "assistant", "content": reply});
        } else {
          messages
              .add({"role": "assistant", "content": "Error: No reply found"});
        }
      } else {
        messages.add({
          "role": "assistant",
          "content": "Server error: ${response.statusCode}"
        });
      }
    } catch (e) {
      messages.add({"role": "assistant", "content": "Error: $e"});
    } finally {
      isLoading.value = false;
    }
  }
}
