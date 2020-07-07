import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/notification/simple_notification.dart';
import 'package:rxdart/rxdart.dart';

class NotificationBloc extends Bloc<SimpleNotification> {
  final PublishSubject<SimpleNotification> _notificationSubject = PublishSubject();

  Stream<SimpleNotification> get notifications => _notificationSubject.stream;

  @override
  void onEvent(SimpleNotification notification) {
    _notificationSubject.add(notification);
  }

  @override
  void dispose() {
    _notificationSubject.close();
  }
}
