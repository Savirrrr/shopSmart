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
            // Product Image
            Image.network(
              widget.product.imageUrl,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported, size: 300);
              },
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Price
                  Text(
                    'Price: \$${widget.product.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Positive Rating
                  Text(
                    'Positive Rating: ${widget.product.reviewAnalysis?.positivePercentage ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Reviews Button
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showReviews = !_showReviews;
                      });
                    },
                    child: Text(_showReviews ? 'Hide Reviews' : 'Show Reviews'),
                  ),
                  
                  // Reviews Section
                  if (_showReviews)
                    ...widget.product.reviews.map((review) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            review,
                            style: const TextStyle(fontSize: 14),
                          ),
                        )),
                  
                  const SizedBox(height: 16),
                  
                  // Open in WebView Button
                  ElevatedButton(
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
                    child: const Text('Open in WebView'),
                  ),
                  
                  // External Link Button
                  ElevatedButton(
                    onPressed: _launchUrl,
                    child: const Text('Open External Link'),
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

// class SearchProductWidget extends StatelessWidget {
//   final SearchProductModel product;

//   const SearchProductWidget({Key? key, required this.product}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailPage(product: product),
//           ),
//         );
//       },
//       child: Card(
//         margin: const EdgeInsets.all(8),
//         elevation: 4,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             Image.network(
//               product.imageUrl,
//               height: 200,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
            
//             // Product Details
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Title
//                   Text(
//                     product.title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
                  
//                   // Price
//                   Text(
//                     '\$${product.price}',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       color: Colors.green,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
                  
//                   // Review Analysis
//                   Text(
//                     'Positive Reviews: ${product.reviewAnalysis?.positivePercentage}',
//                     style: const TextStyle(
//                       color: Colors.blue,
//                     ),
//                   ),
                  
//                   // Reviews Preview
//                   if (product.reviews.isNotEmpty)
//                     Text(
//                       'Sample Review: ${product.reviews.first}',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontStyle: FontStyle.italic,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }