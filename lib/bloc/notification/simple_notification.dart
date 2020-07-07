import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleNotification extends Equatable {
  final String content;
  final Duration duration;
  final Color backgroundColor;
  final Color fontColor;

  SimpleNotification._(
      {this.content, this.duration, this.backgroundColor, this.fontColor});

  static SimpleNotification error({content, duration: const Duration(seconds: 5)}) =>
      SimpleNotification._(
          content: content,
          duration: duration,
          backgroundColor: Colors.red,
          fontColor: Colors.white);

  static SimpleNotification info({content, duration: const Duration(seconds: 5)}) =>
      SimpleNotification._(
          content: content,
          duration: duration,
          backgroundColor: Colors.blue,
          fontColor: Colors.white);

  @override
  List<Object> get props => [content, duration, backgroundColor, fontColor];
}
