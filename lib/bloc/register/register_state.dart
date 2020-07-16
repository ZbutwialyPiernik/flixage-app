import 'package:equatable/equatable.dart';
import 'package:flixage/util/validation/validator.dart';

abstract class RegisterState extends Equatable {
  RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitialized extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterValidatorError extends RegisterState {
  final ValidationResult usernameValidator;
  final ValidationResult passwordValidator;
  final ValidationResult reapeatPasswordValidator;

  RegisterValidatorError(
      this.usernameValidator, this.passwordValidator, this.reapeatPasswordValidator);

  @override
  List<Object> get props =>
      [usernameValidator, passwordValidator, reapeatPasswordValidator];
}
