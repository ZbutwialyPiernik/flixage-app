import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

enum NetworkStatus { Online, Offline }

class NetworkStatusBloc extends BaseBloc<NetworkStatus> {
  final logger = Logger();

  final BehaviorSubject<NetworkStatus> _networkStatusSubject =
      BehaviorSubject<NetworkStatus>();

  @override
  Stream<NetworkStatus> get state => _networkStatusSubject.stream;

  final _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _listener;

  NetworkStatusBloc() {
    _listener = _connectivity.onConnectivityChanged.listen((status) {
      logger.d("Network status changed: $status");

      _networkStatusSubject.add(_mapStatus(status));
    });
  }

  Future<NetworkStatus> getNetworkStatus() async {
    return _mapStatus(await _connectivity.checkConnectivity());
  }

  NetworkStatus _mapStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile || status == ConnectivityResult.wifi
        ? NetworkStatus.Online
        : NetworkStatus.Offline;
  }

  @override
  void dispose() {
    _listener.cancel();
  }
}
