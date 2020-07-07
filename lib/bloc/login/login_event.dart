import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginAttempEvent extends LoginEvent {
  final String username;
  final String password;

  LoginAttempEvent({this.username, this.password});

  @override
  List<Object> get props => [username, password];
}

class TextChangedEvent extends LoginEvent {
  final String username;
  final String password;

  TextChangedEvent({this.username, this.password});

  @override
  List<Object> get props => [username, password];
}
