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

  static m0(name) => "Album wykonawcy ${name}";

  static m1(monthlyListeners) => "Słuchacze w tym miesiącu: ${monthlyListeners}";

  static m2(name) => "Witaj ${name}!";

  static m3(name) => "Wystąpił problem podczas tworzenia playlisty \'${name}\'";

  static m4(name) => "Playlista \'${name}\' została utworzona";

  static m5(name) => "Wystąpił problem podczas usuwania playlisty \'${name}\'";

  static m6(name) => "Playlista \'${name}\' została usunięta";

  static m7(name) => "Stworzona przez ${name}";

  static m8(name) => "Autor: ${name}";

  static m9(name) => "Wystąpił problem podczas aktualizacji playlisty \'${name}\'";

  static m10(name) => "Playlista \'${name}\' została zaktualizowana";

  static m11(query) => "Nie znaleziono \"${query}\"";

  static m13(name) => "Błąd podczas dodawania utworu do playlisty „${name}”";

  static m14(name) => "Utwór został dodany do playlisty „${name}”";

  static m15(name) => "Utwór • ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "albumItem_album" : MessageLookupByLibrary.simpleMessage("Album"),
    "albumPage_by" : m0,
    "albumPage_monthlyListeners" : m1,
    "artistItem_artist" : MessageLookupByLibrary.simpleMessage("Artysta"),
    "artistPage_albums" : MessageLookupByLibrary.simpleMessage("Albumy"),
    "artistPage_popular" : MessageLookupByLibrary.simpleMessage("Popularne"),
    "artistPage_showAll" : MessageLookupByLibrary.simpleMessage("Pokaż wszystkie"),
    "artistPage_singles" : MessageLookupByLibrary.simpleMessage("Single"),
    "authenticationPage_illegalCharacters" : MessageLookupByLibrary.simpleMessage("Niepoprawne znaki"),
    "authenticationPage_login" : MessageLookupByLibrary.simpleMessage("Zaloguj"),
    "authenticationPage_register" : MessageLookupByLibrary.simpleMessage("Nie masz konta? Zarejestruj się już dziś"),
    "bottomAppBar_library" : MessageLookupByLibrary.simpleMessage("Biblioteka"),
    "buttomAppBar_home" : MessageLookupByLibrary.simpleMessage("Home"),
    "buttomAppBar_search" : MessageLookupByLibrary.simpleMessage("Wyszukaj"),
    "common_offline" : MessageLookupByLibrary.simpleMessage("Brak połączenia z internetem"),
    "common_password" : MessageLookupByLibrary.simpleMessage("Hasło"),
    "common_unknownError" : MessageLookupByLibrary.simpleMessage("Nieznany błąd"),
    "common_username" : MessageLookupByLibrary.simpleMessage("Nazwa użytkownika"),
    "common_validation_illegalCharacters" : MessageLookupByLibrary.simpleMessage("Nieprawidłowe znaki"),
    "common_validation_tooLong" : MessageLookupByLibrary.simpleMessage("Zbyt długie"),
    "common_validation_tooShort" : MessageLookupByLibrary.simpleMessage("Zbyt krótkie"),
    "createPlaylistPage_emptyName" : MessageLookupByLibrary.simpleMessage("Nazwa nie może być pusta"),
    "createPlaylistPage_namePlaylist" : MessageLookupByLibrary.simpleMessage("Nazwij swoją playlistę"),
    "dio_connectionTimeout" : MessageLookupByLibrary.simpleMessage("Nie udało się połączyć z serwerem"),
    "dio_receiveTimeout" : MessageLookupByLibrary.simpleMessage("Przekroczono limit czasu oczekiwania"),
    "dio_requestTimeout" : MessageLookupByLibrary.simpleMessage("Przekroczono limit czasu oczekiwania"),
    "homePage_latestArtists" : MessageLookupByLibrary.simpleMessage("Najnowsi artyści"),
    "homePage_latestSingles" : MessageLookupByLibrary.simpleMessage("Najnowsze single"),
    "homePage_newReleases" : MessageLookupByLibrary.simpleMessage("Nowe wydania"),
    "homePage_recentlyPlayed" : MessageLookupByLibrary.simpleMessage("Ostatnio odtwarzane"),
    "homePage_welcome" : m2,
    "libraryFetchError" : MessageLookupByLibrary.simpleMessage("Wystąpił problem podczas pobierania biblioteki"),
    "loginPage_authenticationServiceUnvaiable" : MessageLookupByLibrary.simpleMessage("Serwery uwierzytelniania są niedostępne"),
    "loginPage_invalidCredentials" : MessageLookupByLibrary.simpleMessage("Nieprawidłowe dane logowania"),
    "loginPage_login" : MessageLookupByLibrary.simpleMessage("Zaloguj"),
    "loginPage_serversUnavailable" : MessageLookupByLibrary.simpleMessage("Nie udało się połączyć z serwerem"),
    "pickPlaylistPage_addToPlaylist" : MessageLookupByLibrary.simpleMessage("Dodaj do playlisty"),
    "pickPlaylistPage_newPlaylist" : MessageLookupByLibrary.simpleMessage("Nowa Playlista"),
    "playlistContextMenu_editPlaylist" : MessageLookupByLibrary.simpleMessage("Edytuj playlistę"),
    "playlistContextMenu_removePlaylist" : MessageLookupByLibrary.simpleMessage("Usuń playlistę"),
    "playlistContextMenu_sharePlaylist" : MessageLookupByLibrary.simpleMessage("Udostępnij playlistę"),
    "playlistCreateError" : m3,
    "playlistCreated" : m4,
    "playlistDeleteError" : m5,
    "playlistDeleted" : m6,
    "playlistItem_createdBy" : m7,
    "playlistItem_playlist" : MessageLookupByLibrary.simpleMessage("Playlista"),
    "playlistPage_author" : m8,
    "playlistPage_emptyPlaylist" : MessageLookupByLibrary.simpleMessage("Twoja playlista jest pusta"),
    "playlistPage_playlistLoadingError" : MessageLookupByLibrary.simpleMessage("Wystąpił problem z ładowaniem playlisty"),
    "playlistPage_thumbnailChanged" : MessageLookupByLibrary.simpleMessage("Zmieniono miniaturkę"),
    "playlistPage_unsupportedExtension" : MessageLookupByLibrary.simpleMessage("Niewspierane rozszerzenie"),
    "playlistUpdateError" : m9,
    "playlistUpdated" : m10,
    "queryablePage_playRandomly" : MessageLookupByLibrary.simpleMessage("Odtwarzaj losowo"),
    "registerPage_register" : MessageLookupByLibrary.simpleMessage("Zarejestruj"),
    "registerPage_repeatPassword" : MessageLookupByLibrary.simpleMessage("Powtórz hasło"),
    "registerPage_validation_oneDigit" : MessageLookupByLibrary.simpleMessage("Powinno zawierać co najmniej jedną cyfrę"),
    "registerPage_validation_oneLower" : MessageLookupByLibrary.simpleMessage("Powinno zawierać co najmniej jedną małą literę"),
    "registerPage_validation_oneUpper" : MessageLookupByLibrary.simpleMessage("Powinno zawierać co najmniej jedną wielką literę"),
    "registerPage_validation_passwordDoesNotMatch" : MessageLookupByLibrary.simpleMessage("Hasła nie są takie same"),
    "registerPage_validation_usernameTaken" : MessageLookupByLibrary.simpleMessage("Nazwa użytkownika już jest zajęta"),
    "searchPage_findFavouriteMusic" : MessageLookupByLibrary.simpleMessage("Znajdź swoją ulubioną muzykę"),
    "searchPage_notFound" : m11,
    "searchPage_search" : MessageLookupByLibrary.simpleMessage("Wyszukaj"),
    "searchPage_searchInFlixage" : MessageLookupByLibrary.simpleMessage("Wyszukaj w Flixage"),
    "searchPage_tryAgain" : MessageLookupByLibrary.simpleMessage("Spróbuj ponownie, sprawdzając pisownie"),
    "searchPage_unknownError" : MessageLookupByLibrary.simpleMessage("Wystąpił nieznany błąd :("),
    "settingsPage_language" : MessageLookupByLibrary.simpleMessage("Język"),
    "settingsPage_logout" : MessageLookupByLibrary.simpleMessage("Wyloguj"),
    "settingsPage_title" : MessageLookupByLibrary.simpleMessage("Ustawienia"),
    "splashScreen_offline" : MessageLookupByLibrary.simpleMessage("Jesteś offline, sprawdź swoje połączenie i spróbuj ponownie"),
    "splashScreen_welcome" : MessageLookupByLibrary.simpleMessage("Witaj Ponownie!"),
    "trackAddError" : m13,
    "trackAdded" : m14,
    "trackContextMenu_addToPlaylist" : MessageLookupByLibrary.simpleMessage("Dodaj do playlisty"),
    "trackContextMenu_showAlbum" : MessageLookupByLibrary.simpleMessage("Pokaż album"),
    "trackContextMenu_showArtist" : MessageLookupByLibrary.simpleMessage("Pokaż artystę"),
    "trackItem_track" : m15,
    "userItem_user" : MessageLookupByLibrary.simpleMessage("Użytkownik")
  };
}
