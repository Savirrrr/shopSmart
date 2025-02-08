import 'package:flutter/material.dart';
import 'package:shopsmart/models/search_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductDetailPage extends StatefulWidget {
  final SearchProductModel product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late WebViewController _controller;
  bool _showReviews = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.product.url ?? ''));
  }

  void _launchUrl() async {
    final Uri url = Uri.parse(widget.product.url ?? '');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch ${widget.product.url}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              widget.product.imageUrl,
              height: 200, 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported, size: 250);
              },
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    'Price: \₹${widget.product.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    'Positive Rating: ${widget.product.reviewAnalysis?.positivePercentage ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showReviews = !_showReviews;
                        });
                      },
                      child: Text(_showReviews ? 'Hide Reviews' : 'Show Reviews'),
                    ),
                  ),
                  
                  if (_showReviews)
                    ...widget.product.reviews.map((review) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            review,
                            style: const TextStyle(fontSize: 14),
                          ),
                        )),
                  
                  const SizedBox(height: 24),
                  
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8, 
                          height: 48, 
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.9,
                                  child: WebViewWidget(controller: _controller),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            child: const Text('Open in WebView'),
                          ),
                        ),
                        
                        const SizedBox(height: 12), 
                        
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8, 
                          height: 48, 
                          child: ElevatedButton(
                            onPressed: _launchUrl,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            child: const Text('Open External Link'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}