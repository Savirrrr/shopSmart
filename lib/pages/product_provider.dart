import 'package:flutter/foundation.dart';
import 'package:shopsmart/models/search_model.dart';

class ProductProvider with ChangeNotifier {
  final List<SearchProductModel> _products = [];

  List<SearchProductModel> get products => List.unmodifiable(_products);

  void addProducts(List<SearchProductModel> newProducts) {
    for (var newProduct in newProducts) {
      if (!_products.any((p) => p.title == newProduct.title)) {
        _products.add(newProduct);
      }
    }
    notifyListeners();
  }

  void clearProducts() {
    _products.clear();
    notifyListeners();
  }
}