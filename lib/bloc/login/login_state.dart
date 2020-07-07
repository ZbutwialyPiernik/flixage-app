import 'package:equatable/equatable.dart';
import 'package:flixage/util/validation/validation_result.dart';

abstract class LoginState extends Equatable {
  LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialized extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginValidatorError extends LoginState {
  final ValidationResult usernameValidator;
  final ValidationResult passwordValidator;

  LoginValidatorError(this.usernameValidator, this.passwordValidator);
}
