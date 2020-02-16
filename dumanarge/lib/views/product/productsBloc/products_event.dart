import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  ProductsEvent([List props = const <dynamic>[]]) : super(props);
}

class ProductsLoadEvent extends ProductsEvent{}