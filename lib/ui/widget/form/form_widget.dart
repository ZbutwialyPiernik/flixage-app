import 'package:flixage/bloc/form_bloc.dart';
import 'package:flixage/bloc/notification/notification_bloc.dart';
import 'package:flixage/ui/widget/bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:progress_button/progress_button.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

class FormWidget<T extends FormBloc> extends StatefulWidget {
  final T Function(BuildContext context) createBloc;
  final String submitButtonText;

  const FormWidget({
    Key key,
    @required this.createBloc,
    @required this.submitButtonText,
  }) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState<T>();
}

class _FormWidgetState<T extends FormBloc> extends State<FormWidget> {
  final Map<String, TextEditingController> _controllers = Map();

  @override
  Widget build(BuildContext context) {
    final notificationBloc = Provider.of<NotificationBloc>(context);

    return BlocBuilder<T, FormBlocState>(
      create: widget.createBloc,
      builder: (context, bloc, snapshot) {
        final state = snapshot.data;
        final isDisabled = state is FormLoading || state is FormSubmitSuccess;

        if (snapshot.hasError) {
          notificationBloc.dispatch(SimpleNotification.error(content: snapshot.error));
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildTextFields(bloc, state, isDisabled),
            SizedBox(
              height: 16,
            ),
            ProgressButton(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                //S.current.authenticationPage_login.toUpperCase()
                child: Text(
                  widget.submitButtonText,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              onPressed: state is FormLoading
                  ? null
                  : () => bloc.dispatch(SubmitForm(_toMap(bloc))),
              buttonState: state is FormLoading || state is FormSubmitSuccess
                  ? ButtonState.inProgress
                  : ButtonState.normal,
              backgroundColor: Theme.of(context).primaryColor,
              progressColor: Colors.white,
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildTextFields(T bloc, FormBlocState state, bool isDisabled) {
    List<Widget> widgets = List();

    bloc.fields.forEach((field) {
      widgets.addAll(_buildTextField(field, bloc, state, isDisabled));
    });

    return widgets;
  }

  List<Widget> _buildTextField(
      FormBlocField field, T bloc, FormBlocState state, bool isDisabled) {
    _controllers.putIfAbsent(
        field.key,
        () => TextEditingController()
          ..addListener(() => bloc.dispatch(TextChanged(_toMap(bloc)))));

    return [
      Text(field.label),
      SizedBox(
        height: 8,
      ),
      TextFormField(
        controller: _controllers[field.key],
        readOnly: isDisabled,
        obscureText: field.obscuredText,
        decoration: InputDecoration(
          errorText:
              (state is FormValidationError) ? state.errors[field.key].error : null,
          border: InputBorder.none,
          filled: true,
        ),
      ),
      SizedBox(
        height: 16,
      ),
    ];
  }

  @protected
  Map<String, String> _toMap(FormBloc bloc) {
    Map<String, String> fields = Map();

    bloc.fields.forEach((field) => fields[field.key] = _controllers[field.key].text);

    return fields;
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());

    super.dispose();
  }
}
