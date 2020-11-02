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

  static m0(name) => "By ${name}";

  static m1(monthlyListeners) => "Monthly listeners: ${monthlyListeners}";

  static m2(name) => "Welcome ${name}!";

  static m3(name) => "Problem during creation of playlist \'${name}\'";

  static m4(name) => "Playlist \'${name}\' has been created";

  static m5(name) => "Playlist during deletion of playlist \'${name}\'";

  static m6(name) => "Playlist \'${name}\' has been deleted";

  static m7(name) => "Created by ${name}";

  static m8(name) => "Author: ${name}";

  static m9(name) => "Error during update of playlist \'${name}\'";

  static m10(name) => "Playlist \'${name}\' has been updated";

  static m11(query) => "Not found \"${query}\"";

  static m12(name) => "Error during adding track to playlist \"${name}\"";

  static m13(name) => "Track has been added to playlist \"${name}\"";

  static m14(name) => "Track • ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "albumItem_album" : MessageLookupByLibrary.simpleMessage("Album"),
    "albumPage_by" : m0,
    "albumPage_monthlyListeners" : m1,
    "artistItem_artist" : MessageLookupByLibrary.simpleMessage("Artist"),
    "artistPage_albums" : MessageLookupByLibrary.simpleMessage("Albums"),
    "artistPage_popular" : MessageLookupByLibrary.simpleMessage("Popular"),
    "artistPage_showAll" : MessageLookupByLibrary.simpleMessage("Show all"),
    "artistPage_singles" : MessageLookupByLibrary.simpleMessage("Singles"),
    "authenticationPage_illegalCharacters" : MessageLookupByLibrary.simpleMessage("Illegal characters"),
    "authenticationPage_login" : MessageLookupByLibrary.simpleMessage("Login"),
    "authenticationPage_register" : MessageLookupByLibrary.simpleMessage("Don\'t have an account? Register now"),
    "bottomAppBar_library" : MessageLookupByLibrary.simpleMessage("Library"),
    "buttomAppBar_home" : MessageLookupByLibrary.simpleMessage("Home"),
    "buttomAppBar_search" : MessageLookupByLibrary.simpleMessage("Search"),
    "common_offline" : MessageLookupByLibrary.simpleMessage("You\'re offline"),
    "common_password" : MessageLookupByLibrary.simpleMessage("Password"),
    "common_unknownError" : MessageLookupByLibrary.simpleMessage("Unknown error"),
    "common_username" : MessageLookupByLibrary.simpleMessage("Username"),
    "common_validation_illegalCharacters" : MessageLookupByLibrary.simpleMessage("Illegal characters"),
    "common_validation_tooLong" : MessageLookupByLibrary.simpleMessage("Too long"),
    "common_validation_tooShort" : MessageLookupByLibrary.simpleMessage("Too short"),
    "createPlaylistPage_emptyName" : MessageLookupByLibrary.simpleMessage("Name cannot be empty"),
    "createPlaylistPage_namePlaylist" : MessageLookupByLibrary.simpleMessage("Name your playlist"),
    "dio_connectionTimeout" : MessageLookupByLibrary.simpleMessage("Failed to connect to the server"),
    "dio_receiveTimeout" : MessageLookupByLibrary.simpleMessage("Timed out"),
    "dio_requestTimeout" : MessageLookupByLibrary.simpleMessage("Request timeout"),
    "homePage_latestArtists" : MessageLookupByLibrary.simpleMessage("Latest artists"),
    "homePage_latestSingles" : MessageLookupByLibrary.simpleMessage("Latest singles"),
    "homePage_newReleases" : MessageLookupByLibrary.simpleMessage("New releases"),
    "homePage_recentlyPlayed" : MessageLookupByLibrary.simpleMessage("Recently played"),
    "homePage_welcome" : m2,
    "libraryFetchError" : MessageLookupByLibrary.simpleMessage("Problem during fetching user library"),
    "libraryPage_tab_artists_noPlayed" : MessageLookupByLibrary.simpleMessage("You haven\'t played any song yet"),
    "libraryPage_tab_artists_title" : MessageLookupByLibrary.simpleMessage("Artists"),
    "libraryPage_tab_followed_title" : MessageLookupByLibrary.simpleMessage("Followed"),
    "libraryPage_tab_playlists_createPlaylist" : MessageLookupByLibrary.simpleMessage("Create playlist"),
    "libraryPage_tab_playlists_noPlaylists" : MessageLookupByLibrary.simpleMessage("You don\'t have any playlists yet"),
    "libraryPage_tab_playlists_title" : MessageLookupByLibrary.simpleMessage("Playlists"),
    "loginPage_authenticationServiceUnvaiable" : MessageLookupByLibrary.simpleMessage("Authentication service unavailable"),
    "loginPage_invalidCredentials" : MessageLookupByLibrary.simpleMessage("Invalid Credentials"),
    "loginPage_invalidPassword" : MessageLookupByLibrary.simpleMessage("Invalid password"),
    "loginPage_login" : MessageLookupByLibrary.simpleMessage("Login"),
    "loginPage_serversUnavailable" : MessageLookupByLibrary.simpleMessage("Couldn\'t connect to server"),
    "pickPlaylistPage_addToPlaylist" : MessageLookupByLibrary.simpleMessage("Add to playlist"),
    "pickPlaylistPage_newPlaylist" : MessageLookupByLibrary.simpleMessage("New playlist"),
    "playlistContextMenu_editPlaylist" : MessageLookupByLibrary.simpleMessage("Edit playlist"),
    "playlistContextMenu_removePlaylist" : MessageLookupByLibrary.simpleMessage("Remove playlist"),
    "playlistContextMenu_sharePlaylist" : MessageLookupByLibrary.simpleMessage("Share playlist"),
    "playlistCreateError" : m3,
    "playlistCreated" : m4,
    "playlistDeleteError" : m5,
    "playlistDeleted" : m6,
    "playlistItem_createdBy" : m7,
    "playlistItem_playlist" : MessageLookupByLibrary.simpleMessage("Playlist"),
    "playlistPage_author" : m8,
    "playlistPage_emptyPlaylist" : MessageLookupByLibrary.simpleMessage("Your playlist is empty"),
    "playlistPage_playlistLoadingError" : MessageLookupByLibrary.simpleMessage("Playlist loading error"),
    "playlistPage_thumbnailChanged" : MessageLookupByLibrary.simpleMessage("Thumbnail changed"),
    "playlistPage_unsupportedExtension" : MessageLookupByLibrary.simpleMessage("Unsupported extension"),
    "playlistUpdateError" : m9,
    "playlistUpdated" : m10,
    "queryablePage_playRandomly" : MessageLookupByLibrary.simpleMessage("Shuffle play"),
    "registerPage_register" : MessageLookupByLibrary.simpleMessage("Register"),
    "registerPage_repeatPassword" : MessageLookupByLibrary.simpleMessage("Repeat password"),
    "registerPage_validation_oneDigit" : MessageLookupByLibrary.simpleMessage("Should contain at least one digit"),
    "registerPage_validation_oneLower" : MessageLookupByLibrary.simpleMessage("Should contain at least one lower-case"),
    "registerPage_validation_oneUpper" : MessageLookupByLibrary.simpleMessage("Should contain at least one upper-case"),
    "registerPage_validation_passwordDoesNotMatch" : MessageLookupByLibrary.simpleMessage("Passwords does not match"),
    "registerPage_validation_usernameTaken" : MessageLookupByLibrary.simpleMessage("Username is already taken"),
    "searchPage_findFavouriteMusic" : MessageLookupByLibrary.simpleMessage("Find your favorite music"),
    "searchPage_notFound" : m11,
    "searchPage_search" : MessageLookupByLibrary.simpleMessage("Search"),
    "searchPage_searchInFlixage" : MessageLookupByLibrary.simpleMessage("Search in Flixage"),
    "searchPage_tryAgain" : MessageLookupByLibrary.simpleMessage("Try again, checking the spelling"),
    "searchPage_unknownError" : MessageLookupByLibrary.simpleMessage("Unknown error has occurred :("),
    "settingsPage_language" : MessageLookupByLibrary.simpleMessage("Language"),
    "settingsPage_logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "settingsPage_section_account" : MessageLookupByLibrary.simpleMessage("Account"),
    "settingsPage_title" : MessageLookupByLibrary.simpleMessage("Settings"),
    "trackAddError" : m12,
    "trackAdded" : m13,
    "trackContextMenu_addToPlaylist" : MessageLookupByLibrary.simpleMessage("Add to playlist"),
    "trackContextMenu_showAlbum" : MessageLookupByLibrary.simpleMessage("Show album"),
    "trackContextMenu_showArtist" : MessageLookupByLibrary.simpleMessage("Show artist"),
    "trackItem_track" : m14,
    "userItem_user" : MessageLookupByLibrary.simpleMessage("User")
  };
}
