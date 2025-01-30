import 'package:flutter/material.dart';
import 'package:shopsmart/service/search_service.dart';
import 'package:shopsmart/widget/navbar.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final SearchApiService apiService = SearchApiService(); // Create an instance of the API service

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50), // Corrected placement of SizedBox
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () async {
                    String searchText = searchController.text.trim();
                    if (searchText.isNotEmpty) {
                      try {
                        await apiService.forwardfunction(searchText); 
                        print("Search request sent successfully");
                      } catch (e) {
                        print("Error sending search request: $e");
                      }
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}