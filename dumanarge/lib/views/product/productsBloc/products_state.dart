import 'package:dumanarge/models/productModel.dart';
import 'package:equatable/equatable.dart';

abstract class ProductsState extends Equatable {
  ProductsState([List props = const <dynamic>[]]) : super(props);
}

class InitialProductsState extends ProductsState {}

class ProductsLoadingState extends ProductsState{}

class ProductsErrorState extends ProductsState{}

class ProductsLoadedState extends ProductsState{
  ProductList products;
  ProductsLoadedState({this.products});
}
