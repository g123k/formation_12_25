part of 'product_bloc.dart';

abstract class ProductEvent {}

class LoadProduct extends ProductEvent {
  final String barcode;

  LoadProduct({required this.barcode}) : assert(barcode.isNotEmpty);
}
