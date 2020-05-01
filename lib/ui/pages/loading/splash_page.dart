import 'package:flixage/bloc/authentication_bloc.dart';
import 'package:flixage/bloc/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Flixage..."),
        ),
      ),
    );
  }
}
