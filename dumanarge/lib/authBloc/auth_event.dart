import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const <dynamic>[]]) : super(props);
}

class AppStart extends AuthEvent{}

class Login extends AuthEvent{
  String username;
  String password;
  Login({this.username,this.password}):super([username,password]);
}

class Logout extends AuthEvent{}