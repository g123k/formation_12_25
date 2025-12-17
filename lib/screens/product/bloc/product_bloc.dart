import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formation_flutter/api/model/product_response.dart';
import 'package:formation_flutter/api/openfoodfacts_api.dart';
import 'package:formation_flutter/model/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductInitial()) {
    on<LoadProduct>(_onLoadProduct);
  }

  Future<void> _onLoadProduct(
    LoadProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());

    try {
      ProductAPIEntity res = await OpenFoodFactsAPIManager().loadProduct(
        '5000159484695',
      );

      Product product = res.response!.toProduct();
      emit(ProductLoaded(product));
    } catch (e) {
      emit(ProductError(e));
    }
  }
}
