import 'package:dumanarge/models/productModel.dart';
import 'package:dumanarge/views/basket/basketBloc/bloc.dart';
import 'package:dumanarge/views/commonWidget/customText.dart';
import 'package:dumanarge/views/commonWidget/heroImage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class productDetail extends StatefulWidget {
  BasketBloc basketBloc;
  Product product;
  int tag;
  productDetail({this.product,this.tag,this.basketBloc});
  @override
  _productDetailState createState() => _productDetailState(product:product);
}

class _productDetailState extends State<productDetail> {
  Product product;
  _productDetailState({this.product});
  
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  Widget front,back;

  @override
  void initState() {
    super.initState();

    var a = widget.basketBloc.productList.firstWhere((e) => e.id==product.id, orElse: () => Product(id: -1));
    //
    if(a.id==-1){
      front = basketButton("Add To Basket", Icons.add_shopping_cart);
      back = basketButton("Extract To Basket", Icons.shopping_cart);
    }
    else {
      back = basketButton("Add To Basket", Icons.add_shopping_cart);
      front = basketButton("Extract To Basket", Icons.shopping_cart);
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom:20),
                    alignment: Alignment.center,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        heroImage(
                          tag: "${widget.tag}",
                          url: product.url,
                        ),
                        Align( // back button
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(top:20),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios, size: 40, color: Colors.white,),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Align( // product name
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.only(top:35),
                            child: customText(label:"Product Name", color: Colors.white, fontSize: 20,)
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: ListView(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  children: <Widget>[
                    customText(label:"About", fontSize: 20, fontWeight: FontWeight.bold),
                    customText(label:"${product.title}", maxLines: 4, fontSize: 15,)
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          height: 50,
          margin: EdgeInsets.only(left:20, right: 20, bottom: 5),
          child: Builder(
            builder: (context) {
              return FlipCard(
                direction: FlipDirection.VERTICAL,
                key: cardKey,
                flipOnTouch: false,
                front: front,
                back: back,
              );
            }
          ),
        ),
      ),
    );
  }

  Widget basketButton(String label, IconData icon,){
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      onPressed: (){
        var a = widget.basketBloc.productList.firstWhere((e) => e.id==product.id, orElse: () => Product(id: -1));
        if(a.id==-1){
          setState(() {
            widget.basketBloc.dispatch(AddBasketEvent(product: product));
          });
          Toast.show("ADD TO BASKET", context, gravity: Toast.CENTER);
        }
        else {
          setState(() {
            widget.basketBloc.dispatch(ExtractBasketEvent(product: product));
          });
          Toast.show("EXTRACT TO BASKET", context, gravity: Toast.CENTER);
        }
        cardKey.currentState.toggleCard();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          customText(label:"$label", color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          Icon(icon, color: Colors.white,)
        ],
      ),
    );
  }
}