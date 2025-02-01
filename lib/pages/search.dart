import 'package:flutter/material.dart';
import 'package:shopsmart/models/search_model.dart';
import 'package:shopsmart/service/search_service.dart';
import 'package:shopsmart/widget/navbar.dart';
import 'package:shopsmart/widget/search_widget.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final SearchApiService _apiService = SearchApiService();
  final stt.SpeechToText _speech = stt.SpeechToText();
  
  List _products = [];
  bool _isLoading = false;
  bool _isListening = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
    
    // Add listener to update UI when text changes
    _searchController.addListener(() {
      setState(() {});  // This will rebuild the UI when text changes
    });
  }

  // Initialize speech recognition
  void _initializeSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done') {
          setState(() => _isListening = false);
          _searchProducts();
        }
      },
      onError: (errorNotification) {
        setState(() {
          _isListening = false;
          _errorMessage = 'Error with speech recognition: $errorNotification';
        });
      },
    );
    if (!available) {
      setState(() => _errorMessage = 'Speech recognition not available on this device');
    }
  }

  // Toggle voice listening
  void _toggleListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _searchController.text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  // Clear search text
  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _products.clear();
      _errorMessage = '';
    });
  }

  void _searchProducts() async {
    // Don't search if the text is empty
    if (_searchController.text.trim().isEmpty) {
      setState(() {
        _products.clear();
        _errorMessage = '';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _products.clear();
    });

    try {
      final results = await _apiService.searchProducts(_searchController.text);
      setState(() {
        _products = results;
        
        if (_products.isEmpty) {
          _errorMessage = 'No products found for your search.';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error searching products: ${e.toString()}';
      });

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
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                enabled: !_isListening, // Disable text input while listening
                onSubmitted: (_) => _searchProducts(), // Search when Enter is pressed
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Show clear button only when there is text
                      if (_searchController.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _clearSearch,
                        ),
                      IconButton(
                        icon: Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                          color: _isListening ? Colors.red : null,
                        ),
                        onPressed: _toggleListening,
                      ),
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            if (_isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),

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

  @override
  void dispose() {
    _searchController.dispose(); // Don't forget to dispose the controller
    _speech.cancel();
    super.dispose();
  }
}