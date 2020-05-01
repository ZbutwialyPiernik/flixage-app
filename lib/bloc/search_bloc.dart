import 'package:equatable/equatable.dart';
import 'package:flixage/model/track.dart';
import 'package:flixage/repository/track_repository.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flixage/bloc/bloc.dart';

abstract class SearchEvent extends Equatable {}

enum QueryType { audio, playlist, album }

class TextChanged extends SearchEvent {
  final String query;
  final QueryType queryType;

  TextChanged({this.query, this.queryType = QueryType.audio});

  @override
  List<Object> get props => [query];
}

abstract class SearchState extends Equatable {
  SearchState();
}

class SearchStateEmpty extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchStateLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchStateSuccess extends SearchState {
  final List<Track> tracks;

  SearchStateSuccess({this.tracks});

  @override
  List<Object> get props => [tracks];
}

class SearchStateError extends SearchState {
  final String error;

  SearchStateError({this.error});

  @override
  List<Object> get props => [error];
}

class SearchBloc extends Bloc<SearchEvent> {
  static final log = Logger();

  final BehaviorSubject<SearchState> searchState =
      BehaviorSubject.seeded(SearchStateEmpty());

  final TrackRepository _trackRepository;

  SearchBloc(this._trackRepository);

  @override
  void dispose() {
    searchState.close();
  }

  @override
  void onEvent(SearchEvent event) {
    if (event is TextChanged) {
      if (event.query.trim().isEmpty) {
        searchState.add(SearchStateEmpty());
        return;
      }

      switch (event.queryType) {
        case QueryType.audio:
          searchState.add(SearchStateLoading());

          _trackRepository.searchAudio(query: event.query, limit: 10).then((tracks) {
            searchState.add(SearchStateSuccess(tracks: tracks));
          }).catchError((error) {
            log.e(error);
            searchState.add(SearchStateError(error: error.toString()));
          });
          break;
        default:
          log.e("not implemented yet");
          break;
      }
    }
  }
}
