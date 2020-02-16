import 'package:dumanarge/api/loginApi/loginApi.dart';
import 'package:dumanarge/api/productApi/productApi.dart';
import 'package:dumanarge/models/customerModel.dart';
import 'package:dumanarge/models/productModel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void setupLocator(){
  locator.registerLazySingleton(()=>productApi());
  locator.registerLazySingleton(()=>loginApi());
  locator.registerLazySingleton(()=>ProductList());
  locator.registerLazySingleton(()=>Customer());
  locator.registerLazySingleton(()=>List<Product>());
}