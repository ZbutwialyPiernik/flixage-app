import 'package:equatable/equatable.dart';
import 'package:flixage/model/search_response.dart';
import 'package:flixage/repository/search_repository.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flixage/bloc/bloc.dart';

abstract class SearchEvent extends Equatable {}

enum QueryType { Track, Album, Artist, User, Playlist }

class TextChanged extends SearchEvent {
  final String query;
  final List<QueryType> types;

  TextChanged({@required this.query, @required this.types});

  @override
  List<Object> get props => [query];
}

abstract class SearchState extends Equatable {}

class SearchStateEmpty extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchStateLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchStateSuccess extends SearchState {
  final SearchResponse response;
  final String query;

  SearchStateSuccess({this.response, this.query});

  @override
  List<Object> get props => [response, query];
}

class SearchStateError extends SearchState {
  final String error;

  SearchStateError({this.error});

  @override
  List<Object> get props => [error];
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  static final log = Logger();

  final BehaviorSubject<SearchState> _searchSubject =
      BehaviorSubject.seeded(SearchStateEmpty());

  final SearchRepository _searchRepository;

  @override
  Stream<SearchState> get state => _searchSubject.stream;

  SearchBloc(this._searchRepository);

  @override
  void dispose() {
    _searchSubject.close();
  }

  @override
  void onEvent(SearchEvent event) {
    if (event is TextChanged) {
      if (event.query.trim().isEmpty) {
        _searchSubject.add(SearchStateEmpty());
        return;
      }

      _searchSubject.add(SearchStateLoading());

      _searchRepository
          .search(
              query: event.query,
              limit: 3,
              type: event.types.map((type) => type.toString().split('.').last).join(','))
          .then((response) {
        _searchSubject.add(SearchStateSuccess(response: response, query: event.query));
      }).catchError((error) {
        _searchSubject.add(SearchStateError(error: error.toString()));
      });
    }
  }
}
