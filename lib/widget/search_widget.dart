import 'package:flutter/material.dart';
import 'package:shopsmart/models/search_model.dart';
import 'package:shopsmart/pages/product_details.dart';

class SearchProductWidget extends StatelessWidget {
  final SearchProductModel product;

  const SearchProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        elevation: 2,
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              // Left side - Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
                child: Image.network(
                  product.imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 120,
                      height: 120,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported, size: 40),
                    );
                  },
                ),
              ),
              
              // Right side - Product Details
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      // Title
                      Expanded(
                        flex: 2,
                        child: Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      // Price
                      Expanded(
                        child: Text(
                          '\₹${product.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      
                      // Review Analysis
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.thumb_up, size: 14, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text(
                              '${product.reviewAnalysis?.positivePercentage}% Positive',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Sample Review (if available)
                      if (product.reviews.isNotEmpty)
                        Expanded(
                          child: Text(
                            product.reviews.first,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}