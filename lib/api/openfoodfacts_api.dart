import 'package:dio/dio.dart';
import 'package:formation_flutter/api/model/product_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'openfoodfacts_api.g.dart';

@RestApi()
abstract class OpenFoodFactsAPI {
  factory OpenFoodFactsAPI(Dio dio, {required String baseUrl}) =
      _OpenFoodFactsAPI;

  @GET('/getProduct')
  Future<ProductAPIEntity> loadProduct(@Query('barcode') String barcode);
}

@Singleton(as: IAPIManager, env: ['prod'])
class OpenFoodFactsAPIManager implements IAPIManager {
  factory OpenFoodFactsAPIManager() {
    _instance ??= OpenFoodFactsAPIManager._();
    return _instance!;
  }

  OpenFoodFactsAPIManager._()
    : _api = OpenFoodFactsAPI(
        Dio(),
        baseUrl: 'https://api.formation-flutter.fr/v2/',
      );

  static OpenFoodFactsAPIManager? _instance;

  final OpenFoodFactsAPI _api;

  @override
  Future<ProductAPIEntity> loadProduct(String barcode) =>
      _api.loadProduct(barcode);
}

@Singleton(as: IAPIManager, env: ['test'])
class MockAPIManager implements IAPIManager {
  @override
  Future<ProductAPIEntity> loadProduct(String barcode) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (barcode == '0000000000000') {
      throw Exception('Product not found');
    }

    return ProductAPIEntity.fromJson({
      'status': 1,
      'response': {
        'barcode': barcode,
        'name': 'Mock Product',
        'brand': 'Mock Brand',
        'quantity': '1 pc',
        'imageUrl': 'https://via.placeholder.com/150',
      },
    });
  }
}

abstract class IAPIManager {
  Future<ProductAPIEntity> loadProduct(String barcode);
}
