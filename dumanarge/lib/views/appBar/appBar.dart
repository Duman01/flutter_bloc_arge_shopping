import 'package:dumanarge/routeBloc/bloc.dart';
import 'package:dumanarge/views/basket/basket.dart';
import 'package:dumanarge/views/commonWidget/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class appBar extends StatelessWidget with PreferredSizeWidget {
  appBar({this.appText, this.material});
  String appText;
  bool material;

  @override
  Widget build(BuildContext context) {
    final RouteBloc routeBloc = BlocProvider.of<RouteBloc>(context);
    return BlocBuilder(
      bloc: routeBloc,
      builder: (context, RouteState state){
        if(state is RouteProductState){
          appText = appText??"shopping";
          appText=appText.toUpperCase();
        }
        if(state is RouteProfileState){
          appText = appText??"profile";
          appText=appText.toUpperCase();
        }
        return  AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          centerTitle: true,
          title: customText(label: "$appText", color: Theme.of(context).primaryColor, fontSize: 20,),
          actions: <Widget>[
            material ? IconButton(
              icon: Icon(Icons.local_grocery_store),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => basket()
                ));
              },
            ):Container(),
          ],
        );
      }
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}