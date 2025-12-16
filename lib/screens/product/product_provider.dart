import 'package:flutter/material.dart';
import 'package:formation_flutter/model/product.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider({required this.product});

  Product product;

  void update() {
    product = generateProduct();
    product.name = 'Toto';
    notifyListeners();
  }
}
