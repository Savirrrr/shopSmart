import 'package:flutter/material.dart';
import 'package:shopsmart/models/search_model.dart';
import 'package:shopsmart/service/search_service.dart';
import 'package:shopsmart/widget/navbar.dart';
import 'package:shopsmart/widget/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final SearchApiService _apiService = SearchApiService();
  List<SearchProductModel> _products = [];
  bool _isLoading = false;
  String _errorMessage = '';

  void _searchProducts() async {
    // Clear previous results and errors
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _products.clear();
    });

    try {
      final results = await _apiService.searchProducts(_searchController.text);
      setState(() {
        _products = results;
        
        // Show a message if no products are found
        if (_products.isEmpty) {
          _errorMessage = 'No products found for your search.';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error searching products: ${e.toString()}';
      });

      // Optional: Show a snackbar for additional visibility
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Product Search'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _searchProducts,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            
            // Error message display
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            
            // Loading indicator
            if (_isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            
            // Products list
            if (!_isLoading)
              Expanded(
                child: _products.isEmpty
                    ? const Center(
                        child: Text(
                          'Search for products to get started',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          return SearchProductWidget(product: _products[index]);
                        },
                      ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}