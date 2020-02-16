import 'package:equatable/equatable.dart';

abstract class RouteState extends Equatable {
  RouteState([List props = const <dynamic>[]]) : super(props);
}

class InitialRouteState extends RouteState {}

class RouteLoginState extends RouteState{}

class RouteProductState extends RouteState{}

class RouteBasketState extends RouteState{}

class RouteProfileState extends RouteState{}
