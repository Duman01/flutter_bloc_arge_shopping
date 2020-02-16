import 'package:dumanarge/models/productModel.dart';
import 'package:equatable/equatable.dart';

abstract class BasketState extends Equatable {
  BasketState([List props = const <dynamic>[]]) : super(props);
}

class InitialBasketState extends BasketState {}

class AddBasketState extends BasketState{}

class ExtractBasketState extends BasketState{}

class AllBasketListState extends BasketState{
  List<Product> productList;
  AllBasketListState({this.productList}):super([productList]);
}
