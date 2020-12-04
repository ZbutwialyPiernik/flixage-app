import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

ProxyProvider<Dio, T> repositoryProvider<T>(T Function(Dio) create) =>
    ProxyProvider<Dio, T>(
      update: (_, dio, __) => create(dio),
    );
