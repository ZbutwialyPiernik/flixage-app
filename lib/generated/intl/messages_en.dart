// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(monthlyListeners) => "Listeners in this month: ${monthlyListeners}";

  static m1(name) => "Problem during creation of playlist \'${name}\'";

  static m2(name) => "Playlist \'${name}\' has been created";

  static m3(name) => "Playlist during deletion of playlist \'${name}\'";

  static m4(name) => "Playlist \'${name}\' has been deleted";

  static m5(name) => "Created by ${name}";

  static m6(name) => "Author: ${name}";

  static m7(name) => "Error during update of playlist \'${name}\'";

  static m8(name) => "Playlist \'${name}\' has been updated";

  static m9(query) => "Not found \"${query}\"";

  static m10(name) => "Error during adding track to playlist \"${name}\"";

  static m11(name) => "Track has been added to playlist \"${name}\"";

  static m12(name) => "Track • ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "albumItem_album" : MessageLookupByLibrary.simpleMessage("Album"),
    "albumPage_monthlyListeners" : m0,
    "artistItem_artist" : MessageLookupByLibrary.simpleMessage("Artist"),
    "artistPage_albums" : MessageLookupByLibrary.simpleMessage("Albums"),
    "artistPage_popular" : MessageLookupByLibrary.simpleMessage("Popular"),
    "artistPage_showAll" : MessageLookupByLibrary.simpleMessage("Show all"),
    "artistPage_singles" : MessageLookupByLibrary.simpleMessage("Singles"),
    "authenticationPage_illegalCharacters" : MessageLookupByLibrary.simpleMessage("Illegal characters"),
    "authenticationPage_login" : MessageLookupByLibrary.simpleMessage("Login"),
    "authenticationPage_password" : MessageLookupByLibrary.simpleMessage("Password"),
    "authenticationPage_register" : MessageLookupByLibrary.simpleMessage("Register"),
    "authenticationPage_tooLong" : MessageLookupByLibrary.simpleMessage("Too long"),
    "authenticationPage_tooShort" : MessageLookupByLibrary.simpleMessage("Too short"),
    "authenticationPage_username" : MessageLookupByLibrary.simpleMessage("Username"),
    "bottomAppBar_library" : MessageLookupByLibrary.simpleMessage("Library"),
    "buttomAppBar_home" : MessageLookupByLibrary.simpleMessage("Home"),
    "buttomAppBar_search" : MessageLookupByLibrary.simpleMessage("Search"),
    "createPlaylistPage_namePlaylist" : MessageLookupByLibrary.simpleMessage("Name your playlist"),
    "libraryFetchError" : MessageLookupByLibrary.simpleMessage("Problem during fechting user library"),
    "libraryPage_noPlaylists" : MessageLookupByLibrary.simpleMessage("You don\'t have any playlists yet"),
    "libraryPage_title" : MessageLookupByLibrary.simpleMessage("Playlists"),
    "loginPage_invalidCredentials" : MessageLookupByLibrary.simpleMessage("Invalid Credentials"),
    "loginPage_invalidPassword" : MessageLookupByLibrary.simpleMessage("Invalid password"),
    "pickPlaylistPage_addToPlaylist" : MessageLookupByLibrary.simpleMessage("Add to playlist"),
    "pickPlaylistPage_newPlaylist" : MessageLookupByLibrary.simpleMessage("New playlist"),
    "playlistContextMenu_editPlaylist" : MessageLookupByLibrary.simpleMessage("Edit playlist"),
    "playlistContextMenu_removePlaylist" : MessageLookupByLibrary.simpleMessage("Remove playlist"),
    "playlistContextMenu_sharePlaylist" : MessageLookupByLibrary.simpleMessage("Share playlist"),
    "playlistCreateError" : m1,
    "playlistCreated" : m2,
    "playlistDeleteError" : m3,
    "playlistDeleted" : m4,
    "playlistItem_createdBy" : m5,
    "playlistItem_playlist" : MessageLookupByLibrary.simpleMessage("Playlist"),
    "playlistPage_author" : m6,
    "playlistPage_emptyPlaylist" : MessageLookupByLibrary.simpleMessage("Your playlist is empty"),
    "playlistPage_playlistLoadingError" : MessageLookupByLibrary.simpleMessage("Playlist loading error"),
    "playlistPage_thumbnailChanged" : MessageLookupByLibrary.simpleMessage("Thumbnail changed"),
    "playlistPage_unsupportedExtension" : MessageLookupByLibrary.simpleMessage("Unsupported extension"),
    "playlistUpdateError" : m7,
    "playlistUpdated" : m8,
    "queryablePage_playRandomly" : MessageLookupByLibrary.simpleMessage("Play Randomly"),
    "registerPage_oneDigit" : MessageLookupByLibrary.simpleMessage("Should contain at least one digit"),
    "registerPage_oneLower" : MessageLookupByLibrary.simpleMessage("Should contain at least one lower-case"),
    "registerPage_oneUpper" : MessageLookupByLibrary.simpleMessage("Should contain at least one upper-case"),
    "registerPage_passwordDoesNotMatch" : MessageLookupByLibrary.simpleMessage("Passwords does not match"),
    "registerPage_repeatPassword" : MessageLookupByLibrary.simpleMessage("Repeat password"),
    "registerPage_usernameTaken" : MessageLookupByLibrary.simpleMessage("Username is already taken"),
    "searchPage_findFavouriteMusic" : MessageLookupByLibrary.simpleMessage("Find your favorite music"),
    "searchPage_notFound" : m9,
    "searchPage_search" : MessageLookupByLibrary.simpleMessage("Search"),
    "searchPage_searchInFlixage" : MessageLookupByLibrary.simpleMessage("Search in Flixage"),
    "searchPage_tryAgain" : MessageLookupByLibrary.simpleMessage("Try again, checking the spelling"),
    "searchPage_unknownError" : MessageLookupByLibrary.simpleMessage("\'Unknown error has occured :(\'"),
    "settingsPage_language" : MessageLookupByLibrary.simpleMessage("Language"),
    "settingsPage_logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "settingsPage_title" : MessageLookupByLibrary.simpleMessage("Settings"),
    "trackAddError" : m10,
    "trackAdded" : m11,
    "trackContextMenu_addToPlaylist" : MessageLookupByLibrary.simpleMessage("Add to playlist"),
    "trackContextMenu_showAlbum" : MessageLookupByLibrary.simpleMessage("Show album"),
    "trackContextMenu_showArtist" : MessageLookupByLibrary.simpleMessage("Show artist"),
    "trackItem_track" : m12,
    "unknownError" : MessageLookupByLibrary.simpleMessage("Unknown error"),
    "userItem_user" : MessageLookupByLibrary.simpleMessage("User")
  };
}
