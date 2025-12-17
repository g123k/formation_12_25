import 'package:formation_flutter/model/product.dart';

abstract class IProductRepository {
  Future<Product> getProduct(String barcode);
}
