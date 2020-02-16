import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dumanarge/models/productModel.dart';
import 'package:dumanarge/setupLocator/setupLocator.dart';
import './bloc.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {

  final List<Product> productList = locator<List<Product>>();

  @override
  BasketState get initialState => InitialBasketState();

  @override
  Stream<BasketState> mapEventToState(
    BasketEvent event,
  ) async* {
    if(event is ListBasketEvent){
      yield AllBasketListState(productList: productList);
    }
    if(event is AddBasketEvent){
      productList.add(event.product);
      yield AllBasketListState(productList: productList);
    }
    if(event is ExtractBasketEvent){
      productList.remove(event.product);
      yield AllBasketListState(productList: productList);
    }
  }
}
