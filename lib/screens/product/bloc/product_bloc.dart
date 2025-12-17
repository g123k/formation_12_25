import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formation_flutter/main.dart';
import 'package:formation_flutter/model/product.dart';
import 'package:formation_flutter/repositories/i_product_repository.dart';

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
      Product product = await getIt<IProductRepository>().getProduct(
        '5000159484695',
      );

      emit(ProductLoaded(product));
    } catch (e) {
      emit(ProductError(e));
    }
  }
}
