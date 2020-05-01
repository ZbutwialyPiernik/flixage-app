import 'package:equatable/equatable.dart';
import 'package:flixage/bloc/bloc.dart';
import 'package:flixage/bloc/notification/simple_notification.dart';
import 'package:rxdart/rxdart.dart';

abstract class NotificationEvent extends Equatable {}

class DisplayNotification extends NotificationEvent {
  final SimpleNotification notification;

  DisplayNotification(this.notification);

  @override
  List<Object> get props => [notification];
}

class NotificationBloc extends Bloc<NotificationEvent> {
  final PublishSubject<SimpleNotification> _notificationSubject = PublishSubject();

  Stream<SimpleNotification> get notificationStream => _notificationSubject.stream;

  @override
  void onEvent(NotificationEvent event) {
    if (event is DisplayNotification) {
      _notificationSubject.add(event.notification);
    }
  }

  @override
  void dispose() {
    _notificationSubject.close();
  }
}
