import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flixage/bloc/disposable.dart';
import 'package:flixage/bloc/networt_status_bloc.dart';
import 'package:logger/logger.dart';

///
/// Interceptor for blocking requests when network state is Offline
/// till internet connection will be again avaiable
///
class NetworkStateInterceptor extends Interceptor implements Disposable {
  static final log = Logger();

  StreamSubscription _streamSubscription;
  NetworkStatus _currentState;

  NetworkStateInterceptor(NetworkStatusBloc networkBloc) {
    _streamSubscription = networkBloc.state.listen((state) => _currentState = state);
  }

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    bool lock = _isOffline;

    if (lock) {
      log.d("Blocking dio, because network is offline");
    }

    while (_isOffline) {
      await Future.delayed(Duration(milliseconds: 200));
    }

    if (lock) {
      log.d("Unblocking dio after network reconnect");
    }

    return options;
  }

  /// We're negating here instead of checking for NetworkStatus.Offline
  /// because null is taken as Offline
  bool get _isOffline => _currentState != NetworkStatus.Online;

  @override
  void dispose() {
    _streamSubscription.cancel();
  }
}
