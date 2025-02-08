import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopsmart/models/search_model.dart';

class SearchApiService {
  static const String baseUrl = "http://localhost:3000/api/function/forwardfunction";

  Future<List<SearchProductModel>> searchProducts(String message) async {
    try {
      if (message.isEmpty) {
        print("Search message cannot be empty");
        return [];
      }

      final Uri url = Uri.parse(baseUrl);

      print("Sending request to: $url");
      print("Request body: ${jsonEncode({'message': message})}");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'message': message}),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['success'] == true && jsonResponse['message'] is List) {
          List<dynamic> productList = jsonResponse['message'];

          if (productList.isEmpty) {
            print("No products found for the message");
            return [];
          }

          return productList
              .map((product) => SearchProductModel.fromJson(product))
              .toList();
        } else {
          print("Invalid response structure");
          return [];
        }
      } else {
        print("Server returned an error: ${response.statusCode}");
        print("Error response body: ${response.body}");
        throw Exception('Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Detailed error fetching products: $e");
      
      throw Exception('Network error: $e');
    }
  }
}