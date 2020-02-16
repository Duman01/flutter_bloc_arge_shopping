import 'package:dumanarge/views/appBar/appBar.dart';
import 'package:dumanarge/views/basket/basketBloc/bloc.dart';
import 'package:dumanarge/views/commonWidget/customText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class basket extends StatefulWidget {
  @override
  _basketState createState() => _basketState();
}

class _basketState extends State<basket> {
  @override
  Widget build(BuildContext context) {
    final BasketBloc basketBloc = BlocProvider.of<BasketBloc>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(appText: "BASKET", material: false,),
      body: Container(
        child: BlocBuilder(
          bloc: basketBloc,
          builder: (context, BasketState state){
            if(state is InitialBasketState){
              return Center(child: customText(label: "No Product in The Basket"));
            }
            if(state is AllBasketListState){
              int total=0;
              state.productList.forEach((f) {
                total = total+f.price;
              });
              return state.productList.length>0 ? ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left:10,right: 10),
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.productList.length,
                    itemBuilder: (context, index){
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: Image.network(state.productList[index].thumbnailUrl),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left:5.0),
                                        child: Column(
                                          children: <Widget>[
                                            customText(label:"${state.productList[index].title}", fontWeight: FontWeight.bold, maxLines: 2,),
                                            //customText(label:"${state.productList[index].price} ₺",),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: customText(label:"${state.productList[index].price} ₺", color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.black38),
                            onPressed: (){
                              setState(() {
                                basketBloc.dispatch(ExtractBasketEvent(product: state.productList[index]));
                              });
                              Toast.show("DELETE SUCCESS", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customText(label:"Total Price :  $total ₺", color: Theme.of(context).primaryColor, fontSize: 30, fontWeight: FontWeight.bold, alignment: Alignment.center),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(left:50,right:50),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: Theme.of(context).buttonColor,
                      child: customText(label:"PAYMENT", color: Colors.white, fontWeight: FontWeight.bold,),
                      onPressed: () {
                        // uyarı kapanınca sepete sayfasıda kapanıyor,
                        //Toast.show("PAYMENT SUCCESS", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("PAYMENT SUCCESS"),
                          elevation: 8,
                          duration: Duration(milliseconds: 1500),
                        )).closed.then((close){
                          Navigator.of(context).pop();
                        });
                      }
                    ),
                  ),
                ],
              ):Center(child: customText(label: "No Product in The Basket"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}