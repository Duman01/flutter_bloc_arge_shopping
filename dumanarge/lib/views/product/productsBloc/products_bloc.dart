import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dumanarge/api/productApi/productApi.dart';
import 'package:dumanarge/models/productModel.dart';
import 'package:dumanarge/setupLocator/setupLocator.dart';
import './bloc.dart';

ProductList products = locator<ProductList>();

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  final productApi _productsApi = locator<productApi>();
  
  @override
  ProductsState get initialState => InitialProductsState();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if(event is ProductsLoadEvent){
      yield ProductsLoadingState();
      try{
        try{
          var a = products.listProduct[0].id;
          print(a);
        }catch(e){
          products = await _productsApi.getProduct();
        }
        yield ProductsLoadedState(products:products);
      }catch(e){
        print(e);
        yield ProductsErrorState();
      }
    }
  }
}
