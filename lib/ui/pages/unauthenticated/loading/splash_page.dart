import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: TextLiquidFill(
          text: "Flixage",
          boxWidth: MediaQuery.of(context).size.width,
          boxHeight: MediaQuery.of(context).size.height,
          loadDuration: Duration(seconds: 3),
          waveDuration: Duration(milliseconds: 1000),
          boxBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          waveColor: Colors.amberAccent,
          textStyle: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
