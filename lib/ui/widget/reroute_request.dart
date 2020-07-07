import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class RerouteRequest {
  final String route;
  final Object arguments;

  RerouteRequest({@required this.route, @required this.arguments});
}

final Logger logger = Logger();

handleReroute(NavigatorState state, Future<dynamic> future) {
  future.then(
    (request) {
      if (request != null) {
        if (request is RerouteRequest) {
          state.pushNamed(request.route, arguments: request.arguments);
        } else {
          logger.w("Page returned value of other type than RerouteRequest");
        }
      }
    },
    onError: (e) {
      logger.e(e);
    },
  );
}
