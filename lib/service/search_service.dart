import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchApiService {
  static const String baseurl = "http://localhost:3000/api/function";

  Future<void> forwardfunction(String text) async {
    try {
      print("flutter------------>$text");
      final response = await http.post(
        Uri.parse('$baseurl/forwardfunction'),
        headers: {'Content-Type': 'application/json'}, // ✅ Correct header
        body: jsonEncode({'message': text}), // ✅ Convert Map to JSON string
      );

      if (response.statusCode == 200) {
        print("FLUTTER-------------------------------------> success");
      } else {
        print("Error sending search request: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error sending search request: $e");
    }
  }
}