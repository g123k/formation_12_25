import 'package:formation_flutter/api/model/product_response.dart';
import 'package:formation_flutter/api/openfoodfacts_api.dart';
import 'package:formation_flutter/model/product.dart';
import 'package:formation_flutter/repositories/i_product_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IProductRepository)
class ProductRepository implements IProductRepository {
  ProductRepository({IAPIManager? apiManager})
    : _apiManager = apiManager ?? OpenFoodFactsAPIManager();
  final IAPIManager _apiManager;

  @override
  Future<Product> getProduct(String barcode) async {
    if (barcode.isEmpty) {
      throw ArgumentError('Barcode cannot be empty');
    }

    try {
      final ProductAPIEntity response = await _apiManager.loadProduct(barcode);

      if (response.response == null) {
        throw Exception('Product not found');
      }

      return response.response!.toProduct();
    } catch (e) {
      rethrow;
    }
  }
}
