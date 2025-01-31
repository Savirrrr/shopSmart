import 'package:flutter/material.dart';

class DummyProductWidget extends StatelessWidget {
  final dynamic imageUrl; // Changed to dynamic to handle both String and AssetImage
  final String title;
  final String price;
  final double positiveReviewPercentage;
  final List<String> sampleReviews;

  const DummyProductWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.positiveReviewPercentage,
    required this.sampleReviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(
              title: title,
              imageUrl: imageUrl,
              price: price,
              positiveReviewPercentage: positiveReviewPercentage,
              sampleReviews: sampleReviews,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            imageUrl is String
                ? Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      );
                    },
                  )
                : Image(
                    image: imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Positive Reviews: $positiveReviewPercentage%',
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: sampleReviews.take(2).map((review) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          '• $review',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      );
                    }).toList(),
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

class ProductPage extends StatelessWidget {
  final dynamic imageUrl;
  final String title;
  final String price;
  final double positiveReviewPercentage;
  final List<String> sampleReviews;

  const ProductPage({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.positiveReviewPercentage,
    required this.sampleReviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageUrl is String
                  ? Image.network(
                      imageUrl,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 300,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        );
                      },
                    )
                  : Image(
                      image: imageUrl,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Price: $price',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Positive Rating: $positiveReviewPercentage%',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sampleReviews.map((review) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      review,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}