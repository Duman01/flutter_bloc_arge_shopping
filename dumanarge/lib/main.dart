import 'package:dumanarge/authBloc/auth_bloc.dart';
import 'package:dumanarge/authBloc/bloc.dart';
import 'package:dumanarge/routeBloc/route_bloc.dart';
import 'package:dumanarge/setupLocator/setupLocator.dart';
import 'package:dumanarge/views/basket/basketBloc/bloc.dart';
import 'package:dumanarge/views/login/login.dart';
import 'package:dumanarge/views/pageRouteManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {

  setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<RouteBloc>(
          builder: (context) => RouteBloc(),
        ),
        BlocProvider<AuthBloc>(
          builder: (context) => AuthBloc()..dispatch(AppStart()),
        ),
        BlocProvider<BasketBloc>(
          builder: (context) => BasketBloc(),
        ),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Duman Arge E-Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Color(0xFFFDF9F3), //
        primaryColorLight: Color(0xFFE2C992),
        primaryColor: Color(0xFF348F6C), //
        buttonColor: Color(0xFF348F6C),
        textSelectionColor: Colors.black
      ),
      home: BlocBuilder(
        bloc: authBloc,
        builder: (context, AuthState state){
          print(state);
          if(state is InitialAuthState){
            return Container();
          }
          if(state is AuthLoading){
            return Center(child: CircularProgressIndicator());
          }
          if(state is AuthError){
            print("error");
            return login();
          }
          if(state is AuthUnsucces){
            return login();
          }
          if(state is AuthSucces){
            return pageRouteManager();
          }

          return Container();
        },
      )
    );
  }
}