import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  @override
  RouteState get initialState => InitialRouteState();

  @override
  Stream<RouteState> mapEventToState(
    RouteEvent event,
  ) async* {
    if(event is RouteLoginEvent){
      yield RouteLoginState();
    }
    if(event is RouteProductEvent){
      yield RouteProductState();
    }
    if(event is RouteBasketEvent){
      yield RouteBasketState();
    }
    if(event is RouteProfileEvent){
      yield RouteProfileState();
    }
  }
}
