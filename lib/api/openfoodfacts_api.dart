import 'package:dio/dio.dart';
import 'package:formation_flutter/api/model/product_response.dart';
import 'package:retrofit/retrofit.dart';

part 'openfoodfacts_api.g.dart';

@RestApi()
abstract class OpenFoodFactsAPI {
  factory OpenFoodFactsAPI(Dio dio, {required String baseUrl}) =
      _OpenFoodFactsAPI;

  @GET('/getProduct')
  Future<ProductAPIEntity> loadProduct(@Query('barcode') String barcode);
}

class OpenFoodFactsAPIManager {
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

  Future<ProductAPIEntity> loadProduct(String barcode) =>
      _api.loadProduct(barcode);
}
