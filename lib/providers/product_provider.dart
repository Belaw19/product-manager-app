import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  bool isLoading = false;

  final ProductApiService apiService = ProductApiService();

  Future<void> getProducts() async {
    isLoading = true;
    notifyListeners();

    products = await apiService.fetchProducts();

    isLoading = false;
    notifyListeners();
  }

  void addProduct(Product product) {
    products.insert(0, product);
    notifyListeners();
  }

  void updateProduct(Product updatedProduct) {
    int index = products.indexWhere(
      (product) => product.id == updatedProduct.id,
    );

    if (index != -1) {
      products[index] = updatedProduct;
      notifyListeners();
    }
  }

  void deleteProduct(int id) {
    products.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
