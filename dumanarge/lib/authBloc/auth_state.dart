import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  AuthState([List props = const <dynamic>[]]) : super(props);
}

class InitialAuthState extends AuthState {}

class AuthLoading extends AuthState{}

class AuthError extends AuthState{}

class AuthSucces extends AuthState{}

class AuthUnsucces extends AuthState{}