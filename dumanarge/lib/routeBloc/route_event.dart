import 'package:equatable/equatable.dart';

abstract class RouteEvent extends Equatable {
  RouteEvent([List props = const <dynamic>[]]) : super(props);
}

class RouteLoginEvent extends RouteEvent{}

class RouteProductEvent extends RouteEvent{}

class RouteBasketEvent extends RouteEvent{}

class RouteProfileEvent extends RouteEvent{}

