import 'package:flutter_bloc/flutter_bloc.dart';
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
      await Future.delayed(const Duration(seconds: 2));
      Product product = generateProduct();

      emit(ProductLoaded(product));
    } catch (e) {
      emit(ProductError(e));
    }
  }
}
