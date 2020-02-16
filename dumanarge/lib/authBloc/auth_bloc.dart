import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dumanarge/api/loginApi/loginApi.dart';
import 'package:dumanarge/localData/customerLocal.dart';
import 'package:dumanarge/models/customerModel.dart';
import 'package:dumanarge/setupLocator/setupLocator.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  Customer customer = locator<Customer>();

  loginApi _loginApi = locator<loginApi>();

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if(event is AppStart){
      bool token = await customerCheck();
      if(token){
        customer = await customerGet();
        yield AuthSucces();
      }
      else {
        yield AuthUnsucces();
      }
    }
    if(event is Login){
      yield AuthLoading();
      try{
        bool state = await _loginApi.login(event.username, event.password);
        if(state)customer = await customerGet();
        yield AuthSucces();
      }catch(e){
        print(e);
        yield AuthUnsucces();
      }
    }
    if(event is Logout){
      yield AuthLoading();
      try{
        await customerDelete();
        yield AuthUnsucces();
      }catch(e){
        print(e);
        yield AuthSucces();
      }
    }
  }
}
