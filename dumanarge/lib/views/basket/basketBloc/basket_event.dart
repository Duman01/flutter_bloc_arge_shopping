import 'package:dumanarge/models/productModel.dart';
import 'package:equatable/equatable.dart';

abstract class BasketEvent extends Equatable {
  BasketEvent([List props = const <dynamic>[]]) : super(props);
}

class AddBasketEvent extends BasketEvent{
  Product product;
  AddBasketEvent({this.product}):super([product]);
}

class ExtractBasketEvent extends BasketEvent{
  Product product;
  ExtractBasketEvent({this.product}):super([product]);
}

class ListBasketEvent extends BasketEvent{}