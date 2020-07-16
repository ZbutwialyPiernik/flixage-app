import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterAttempEvent extends RegisterEvent {
  final String username;
  final String password;
  final String repeatPassword;

  RegisterAttempEvent({
    @required this.username,
    @required this.password,
    @required this.repeatPassword,
  });

  @override
  List<Object> get props => [username, password];
}

class TextChangedEvent extends RegisterEvent {
  final String username;
  final String password;
  final String repeatPassword;

  TextChangedEvent({
    @required this.username,
    @required this.password,
    @required this.repeatPassword,
  });

  @override
  List<Object> get props => [username, password];
}
