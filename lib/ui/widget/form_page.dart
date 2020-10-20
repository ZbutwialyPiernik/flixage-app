import 'package:flutter/cupertino.dart';

class FormPage extends StatelessWidget {
  final Widget child;

  const FormPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: child,
          ),
        ),
      ),
    );
  }
}
