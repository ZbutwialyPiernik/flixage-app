import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/util/validation/validator.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class FormBlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class FormInitialized extends FormBlocState {}

class FormLoading extends FormBlocState {}

class FormSubmitSuccess extends FormBlocState {}

class FormValidationError extends FormBlocState {
  final Map<String, ValidationResult> errors;

  FormValidationError(this.errors);
}

class FormEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TextChanged extends FormEvent {
  final Map<String, String> fields;

  TextChanged(this.fields) : assert(fields != null);
}

class SubmitForm extends FormEvent {
  final Map<String, String> fields;

  SubmitForm(this.fields) : assert(fields != null);
}

abstract class FormBloc extends Bloc<FormEvent, FormBlocState> {
  @protected
  final BehaviorSubject<FormBlocState> _formSubject = BehaviorSubject();

  Map<String, Validator> get validators;

  Stream<FormBlocState> get state => _formSubject.stream;

  @protected
  Future<FormBlocState> onValid(SubmitForm event);

  @override
  void onEvent(FormEvent event) {
    if (event is TextChanged) {
      if (_formSubject.value is FormValidationError) {
        _formSubject.add(FormInitialized());
      }
    } else if (event is SubmitForm) {
      Map<String, ValidationResult> errors = {};
      bool hasError = false;

      event.fields.forEach((key, value) {
        final validator = validators[key];

        if (validator == null) {
          errors[key] = ValidationResult.empty();
          return;
        }

        final validationResult = validator.validate(value);

        errors[key] = validationResult;

        if (validationResult.hasError) {
          hasError = true;
        }
      });

      if (hasError) {
        _formSubject.add(FormValidationError(errors));
      } else {
        _formSubject.add(FormLoading());

        onValid(event)
            .then((value) => _formSubject.add(value))
            .catchError((e) => _formSubject.addError(e));
      }
    }
  }

  @override
  void dispose() {
    _formSubject.close();
  }
}
