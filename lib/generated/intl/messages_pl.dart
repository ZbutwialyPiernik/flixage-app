// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pl';

  static m0(monthlyListeners) => "Słuchawcze w tym miesiącu: ${monthlyListeners}";

  static m1(name) => "Wystąpił problem podczas tworzenia playlisty \'${name}\'";

  static m2(name) => "Playlista \'${name}\' została utworzona";

  static m3(name) => "Wystąpił problem podczas usuwania playlisty \'${name}\'";

  static m4(name) => "Playlista \'${name}\' została usunięta";

  static m5(name) => "Stworzona przez ${name}";

  static m6(name) => "Author: ${name}";

  static m7(name) => "Error during update of playlist";

  static m8(name) => "Playlista \'${name}\' została zaktualizowana";

  static m9(query) => "Nie znaleziono \"${query}\"";

  static m12(name) => "Utwór • ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "albumItem_album" : MessageLookupByLibrary.simpleMessage("Album"),
    "albumPage_monthlyListeners" : m0,
    "artistItem_artist" : MessageLookupByLibrary.simpleMessage("Artysta"),
    "artistPage_albums" : MessageLookupByLibrary.simpleMessage("Albumy"),
    "artistPage_popular" : MessageLookupByLibrary.simpleMessage("Popularne"),
    "artistPage_showAll" : MessageLookupByLibrary.simpleMessage("Pokaż wszystkie"),
    "artistPage_singles" : MessageLookupByLibrary.simpleMessage("Single"),
    "bottomAppBar_library" : MessageLookupByLibrary.simpleMessage("Biblioteka"),
    "buttomAppBar_home" : MessageLookupByLibrary.simpleMessage("Home"),
    "buttomAppBar_search" : MessageLookupByLibrary.simpleMessage("Wyszukaj"),
    "createPlaylistPage_namePlaylist" : MessageLookupByLibrary.simpleMessage("Nazwij swoją playliste"),
    "libraryFetchError" : MessageLookupByLibrary.simpleMessage("Problem during fechting user library"),
    "libraryPage_noPlaylists" : MessageLookupByLibrary.simpleMessage("Nie masz jeszcze żadnej playlisty"),
    "libraryPage_title" : MessageLookupByLibrary.simpleMessage("Playlisty"),
    "pickPlaylistPage_addToPlaylist" : MessageLookupByLibrary.simpleMessage("Dodaj do playlisty"),
    "pickPlaylistPage_newPlaylist" : MessageLookupByLibrary.simpleMessage("Nowa Playlista"),
    "playlistCreateError" : m1,
    "playlistCreated" : m2,
    "playlistDeleteError" : m3,
    "playlistDeleted" : m4,
    "playlistItem_createdBy" : m5,
    "playlistItem_playlist" : MessageLookupByLibrary.simpleMessage("Playlista"),
    "playlistPage_author" : m6,
    "playlistPage_emptyPlaylist" : MessageLookupByLibrary.simpleMessage("Twoja playlista jest pusta"),
    "playlistUpdateError" : m7,
    "playlistUpdated" : m8,
    "queryablePage_playRandomly" : MessageLookupByLibrary.simpleMessage("Odtwarzaj losowo"),
    "searchPage_findFavouriteMusic" : MessageLookupByLibrary.simpleMessage("Znajdź swoją ulubioną muzykę"),
    "searchPage_notFound" : m9,
    "searchPage_search" : MessageLookupByLibrary.simpleMessage("Wyszukaj"),
    "searchPage_searchInFlixage" : MessageLookupByLibrary.simpleMessage("Wyszukaj w Flixage"),
    "searchPage_tryAgain" : MessageLookupByLibrary.simpleMessage("Spróbuj ponownie, sprawdzając pisownie"),
    "searchPage_unknownError" : MessageLookupByLibrary.simpleMessage("Wystąpił nieznany błąd :("),
    "settingsPage_language" : MessageLookupByLibrary.simpleMessage("Język"),
    "settingsPage_title" : MessageLookupByLibrary.simpleMessage("Ustawienia"),
    "trackItem_track" : m12,
    "userItem_user" : MessageLookupByLibrary.simpleMessage("Użytkownik")
  };
}
