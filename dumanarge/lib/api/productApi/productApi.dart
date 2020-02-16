import 'dart:convert';
import 'package:dumanarge/models/productModel.dart';
import 'package:http/http.dart' as http;

final baseUrl = "https://jsonplaceholder.typicode.com/photos";

class productApi{

  Future getProduct()async{
    var response = await http.get(baseUrl);
    if(response.statusCode!=200){
      // hata
    }
    var data = json.decode(response.body);
    var products = ProductList.fromJson(data);
    return products;
  }
}