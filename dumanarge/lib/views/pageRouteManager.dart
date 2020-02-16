import 'package:dumanarge/authBloc/bloc.dart';
import 'package:dumanarge/routeBloc/bloc.dart';
import 'package:dumanarge/views/appBar/appBar.dart';
import 'package:dumanarge/views/basket/basket.dart';
import 'package:dumanarge/views/drawer/drawerMenu.dart';
import 'package:dumanarge/views/product/product.dart';
import 'package:dumanarge/views/product/productsBloc/bloc.dart';
import 'package:dumanarge/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class pageRouteManager extends StatefulWidget {
  @override
  _pageRouteManagerState createState() => _pageRouteManagerState();
}

class _pageRouteManagerState extends State<pageRouteManager> {

  @override
  Widget build(BuildContext context) {
    final RouteBloc routeBloc = BlocProvider.of<RouteBloc>(context);
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(material: true,),
      drawer: drawerMenu(routeBloc:routeBloc, authBloc:authBloc),
      body: BlocBuilder(
        bloc: routeBloc,
        builder: (context, RouteState state){
          if(state is InitialRouteState){
            routeBloc.dispatch(RouteProductEvent());
            return Container();
          }
          if(state is RouteProductState){
            return BlocProvider(
              builder: (context) => ProductsBloc()..dispatch(ProductsLoadEvent()),
              child: product()
            );
          }
          if(state is RouteBasketState){
            return basket();
          }
          if(state is RouteProfileState){
            return profile();
          }
          return null;
        },
      ),
    );
  }
}
