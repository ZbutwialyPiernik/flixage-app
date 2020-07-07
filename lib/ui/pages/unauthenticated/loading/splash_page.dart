import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Center(
          child: Text("Flixage...",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Theme.of(context).primaryColor)),
        ),
      ),
    );
  }
}
