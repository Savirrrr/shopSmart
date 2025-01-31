import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopsmart/models/search_model.dart';

class SearchApiService {
  static const String baseUrl = "http://localhost:3000/api/function/forwardfunction";

  Future<List<SearchProductModel>> searchProducts(String message) async {
    try {
      // Validate input
      if (message.isEmpty) {
        print("Search message cannot be empty");
        return [];
      }

      // Construct the full URL with proper endpoint
      final Uri url = Uri.parse(baseUrl);

      // Add more detailed logging
      print("Sending request to: $url");
      print("Request body: ${jsonEncode({'message': message})}");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'message': message}),
      );

      // Log the response details
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Handle different response scenarios
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Check if the response is successful and contains a message list
        if (jsonResponse['success'] == true && jsonResponse['message'] is List) {
          List<dynamic> productList = jsonResponse['message'];

          // Validate the parsed response
          if (productList.isEmpty) {
            print("No products found for the message");
            return [];
          }

          // Convert JSON to SearchProductModel
          return productList
              .map((product) => SearchProductModel.fromJson(product))
              .toList();
        } else {
          print("Invalid response structure");
          return [];
        }
      } else {
        // Handle non-200 status codes
        print("Server returned an error: ${response.statusCode}");
        print("Error response body: ${response.body}");
        throw Exception('Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Catch and log any network or other errors
      print("Detailed error fetching products: $e");
      
      throw Exception('Network error: $e');
    }
  }
}