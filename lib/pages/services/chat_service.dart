import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const String baseUrl = "http://127.0.0.1:5000"; 

  static Future<String> sendMessage(String message) async {
    final url = Uri.parse("$baseUrl/chat");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"message": message}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["response"] ?? "Maaf, tidak ada jawaban.";
    } else {
      return "Error: ${response.statusCode}";
    }
  }
}
