class SearchProductModel {
  final String title;
  final String price;
  final String imageUrl;
  final List<String> reviews;
  final String? url;
  final ReviewAnalysis? reviewAnalysis;

  SearchProductModel({
    required this.title,
    this.price = 'Price Not Found',
    this.imageUrl = '',
    this.reviews = const [],
    this.url,
    this.reviewAnalysis,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
      title: json['title'] ?? 'No Title',
      price: json['price'] ?? 'Price Not Found',
      imageUrl: json['image_url'] ?? '',
      reviews: json['reviews'] != null 
        ? List<String>.from(json['reviews']) 
        : [],
      url: json['url'],
      reviewAnalysis: json['review_analysis'] != null 
        ? ReviewAnalysis.fromJson(json['review_analysis']) 
        : null,
    );
  }
}

class ReviewAnalysis {
  final String positivePercentage;

  ReviewAnalysis({this.positivePercentage = '0%'});

  factory ReviewAnalysis.fromJson(Map<String, dynamic> json) {
    return ReviewAnalysis(
      positivePercentage: json['positive_percentage'] ?? '0%',
    );
  }
}