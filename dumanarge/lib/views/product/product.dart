import 'dart:ui';
import 'package:dumanarge/models/productModel.dart';
import 'package:dumanarge/views/basket/basketBloc/bloc.dart';
import 'package:dumanarge/views/commonWidget/customText.dart';
import 'package:dumanarge/views/commonWidget/heroImage.dart';
import 'package:dumanarge/views/product/productDetail.dart';
import 'package:dumanarge/views/product/productsBloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spring_button/spring_button.dart';
import 'package:toast/toast.dart';

class product extends StatefulWidget {
  @override
  _productState createState() => _productState();
}

class _productState extends State<product> {

  @override
  Widget build(BuildContext context) {
    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);
    final BasketBloc basketBloc = BlocProvider.of<BasketBloc>(context);
    return BlocBuilder(
      bloc: productsBloc,
      builder: (context, ProductsState state){
        print(state);
        if(state is InitialProductsState){
          return Container();
        }
        if(state is ProductsLoadingState){
          return Center(child: CircularProgressIndicator());
        }
        if(state is ProductsErrorState){
          return Center(child: customText(label: "ERROR"));
        }
        if(state is ProductsLoadedState){
          ProductList products = state.products;
          return Container(
            margin: EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: products.listProduct.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75
              ),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).primaryColorLight,
                    ),
                    //padding: EdgeInsets.all(5),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        GestureDetector( // photo
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => productDetail(product: products.listProduct[index], tag: index, basketBloc:basketBloc)
                            ));
                          },
                          child: ClipRRect( // photo
                            borderRadius: BorderRadius.circular(5),
                            child: heroImage(
                              tag: "$index",
                              url: products.listProduct[index].thumbnailUrl,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            customText(label:"CATEGORY", fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15,),
                            basketBloc.productList.firstWhere((e) => e.id==products.listProduct[index].id, orElse: () => Product(id: -1)).id!=-1 ? 
                            Column(
                              children: <Widget>[
                                Icon(Icons.check_circle_outline, size: 75,),
                                customText(label:"already in the basket", color: Colors.white,)
                              ],
                            ) : Container(),
                            Align( // price and addtocart
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: customText(label:"${products.listProduct[index].price} ₺", fontWeight: FontWeight.bold, fontSize: 20,),
                                  ),
                                  Container( // spring button
                                    margin: EdgeInsets.only(right:10),
                                    child: SpringButton(
                                      SpringButtonType.OnlyScale,
                                      basketBloc.productList.firstWhere((e) => e.id==products.listProduct[index].id, orElse: () => Product(id: -1)).id==-1 ? 
                                      Icon(
                                        Icons.add_shopping_cart,
                                      ):
                                      Icon(Icons.remove_shopping_cart),
                                      onTap: () {
                                        var a = basketBloc.productList.firstWhere((e) => e.id==products.listProduct[index].id, orElse: () => Product(id: -1));
                                        if(a.id==-1){
                                          setState(() {
                                            basketBloc.dispatch(AddBasketEvent(product: products.listProduct[index]));
                                          });
                                          Toast.show("ADD TO BASKET", context, gravity: Toast.CENTER);
                                        }
                                        else {
                                          setState(() {
                                            basketBloc.dispatch(ExtractBasketEvent(product: products.listProduct[index]));
                                          });
                                          Toast.show("EXTRACT TO BASKET", context, gravity: Toast.CENTER);
                                        }
                                      },
                                      useCache : false,
                                      alignment : Alignment.center,
                                      scaleCoefficient : 0.1,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          );
        }
        return null;
      },
    );
  }
}
