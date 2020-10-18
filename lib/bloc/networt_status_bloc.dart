import 'package:connectivity/connectivity.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

enum NetworkStatus { Online, Offline }

class NetworkStatusBloc {
  final logger = Logger();

  final BehaviorSubject<NetworkStatus> _networkStatusSubject =
      BehaviorSubject<NetworkStatus>();

  Stream<NetworkStatus> get networkStatus => _networkStatusSubject.stream;

  final _connectivity = Connectivity();

  NetworkStatusBloc() {
    _connectivity.onConnectivityChanged.listen((status) {
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
}
