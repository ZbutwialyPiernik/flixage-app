import 'package:equatable/equatable.dart';

abstract class PlaylistLoadingState extends Equatable {
  PlaylistLoadingState();

  @override
  List<Object> get props => [];
}

class PlaylistLoadingError extends PlaylistLoadingState {
  final String error;

  PlaylistLoadingError(this.error);

  @override
  List<Object> get props => [error];
}
