// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get settingsPage_title {
    return Intl.message(
      'Settings',
      name: 'settingsPage_title',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsPage_language {
    return Intl.message(
      'Language',
      name: 'settingsPage_language',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get settingsPage_logout {
    return Intl.message(
      'Logout',
      name: 'settingsPage_logout',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get buttomAppBar_home {
    return Intl.message(
      'Home',
      name: 'buttomAppBar_home',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get buttomAppBar_search {
    return Intl.message(
      'Search',
      name: 'buttomAppBar_search',
      desc: '',
      args: [],
    );
  }

  /// `Library`
  String get bottomAppBar_library {
    return Intl.message(
      'Library',
      name: 'bottomAppBar_library',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get authenticationPage_login {
    return Intl.message(
      'Login',
      name: 'authenticationPage_login',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Register now`
  String get authenticationPage_register {
    return Intl.message(
      'Don\'t have an account? Register now',
      name: 'authenticationPage_register',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get authenticationPage_username {
    return Intl.message(
      'Username',
      name: 'authenticationPage_username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get authenticationPage_password {
    return Intl.message(
      'Password',
      name: 'authenticationPage_password',
      desc: '',
      args: [],
    );
  }

  /// `Too short`
  String get authenticationPage_tooShort {
    return Intl.message(
      'Too short',
      name: 'authenticationPage_tooShort',
      desc: '',
      args: [],
    );
  }

  /// `Too long`
  String get authenticationPage_tooLong {
    return Intl.message(
      'Too long',
      name: 'authenticationPage_tooLong',
      desc: '',
      args: [],
    );
  }

  /// `Illegal characters`
  String get authenticationPage_illegalCharacters {
    return Intl.message(
      'Illegal characters',
      name: 'authenticationPage_illegalCharacters',
      desc: '',
      args: [],
    );
  }

  /// `Playlists`
  String get libraryPage_title {
    return Intl.message(
      'Playlists',
      name: 'libraryPage_title',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any playlists yet`
  String get libraryPage_noPlaylists {
    return Intl.message(
      'You don\'t have any playlists yet',
      name: 'libraryPage_noPlaylists',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Credentials`
  String get loginPage_invalidCredentials {
    return Intl.message(
      'Invalid Credentials',
      name: 'loginPage_invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password`
  String get loginPage_invalidPassword {
    return Intl.message(
      'Invalid password',
      name: 'loginPage_invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords does not match`
  String get registerPage_passwordDoesNotMatch {
    return Intl.message(
      'Passwords does not match',
      name: 'registerPage_passwordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Should contain at least one digit`
  String get registerPage_oneDigit {
    return Intl.message(
      'Should contain at least one digit',
      name: 'registerPage_oneDigit',
      desc: '',
      args: [],
    );
  }

  /// `Should contain at least one lower-case`
  String get registerPage_oneLower {
    return Intl.message(
      'Should contain at least one lower-case',
      name: 'registerPage_oneLower',
      desc: '',
      args: [],
    );
  }

  /// `Should contain at least one upper-case`
  String get registerPage_oneUpper {
    return Intl.message(
      'Should contain at least one upper-case',
      name: 'registerPage_oneUpper',
      desc: '',
      args: [],
    );
  }

  /// `Username is already taken`
  String get registerPage_usernameTaken {
    return Intl.message(
      'Username is already taken',
      name: 'registerPage_usernameTaken',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password`
  String get registerPage_repeatPassword {
    return Intl.message(
      'Repeat password',
      name: 'registerPage_repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Shuffle play`
  String get queryablePage_playRandomly {
    return Intl.message(
      'Shuffle play',
      name: 'queryablePage_playRandomly',
      desc: '',
      args: [],
    );
  }

  /// `By {name}`
  String albumPage_by(Object name) {
    return Intl.message(
      'By $name',
      name: 'albumPage_by',
      desc: '',
      args: [name],
    );
  }

  /// `Albums`
  String get artistPage_albums {
    return Intl.message(
      'Albums',
      name: 'artistPage_albums',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get artistPage_popular {
    return Intl.message(
      'Popular',
      name: 'artistPage_popular',
      desc: '',
      args: [],
    );
  }

  /// `Singles`
  String get artistPage_singles {
    return Intl.message(
      'Singles',
      name: 'artistPage_singles',
      desc: '',
      args: [],
    );
  }

  /// `Show all`
  String get artistPage_showAll {
    return Intl.message(
      'Show all',
      name: 'artistPage_showAll',
      desc: '',
      args: [],
    );
  }

  /// `Author: {name}`
  String playlistPage_author(Object name) {
    return Intl.message(
      'Author: $name',
      name: 'playlistPage_author',
      desc: '',
      args: [name],
    );
  }

  /// `Thumbnail changed`
  String get playlistPage_thumbnailChanged {
    return Intl.message(
      'Thumbnail changed',
      name: 'playlistPage_thumbnailChanged',
      desc: '',
      args: [],
    );
  }

  /// `Playlist loading error`
  String get playlistPage_playlistLoadingError {
    return Intl.message(
      'Playlist loading error',
      name: 'playlistPage_playlistLoadingError',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported extension`
  String get playlistPage_unsupportedExtension {
    return Intl.message(
      'Unsupported extension',
      name: 'playlistPage_unsupportedExtension',
      desc: '',
      args: [],
    );
  }

  /// `Your playlist is empty`
  String get playlistPage_emptyPlaylist {
    return Intl.message(
      'Your playlist is empty',
      name: 'playlistPage_emptyPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get searchPage_search {
    return Intl.message(
      'Search',
      name: 'searchPage_search',
      desc: '',
      args: [],
    );
  }

  /// `Search in Flixage`
  String get searchPage_searchInFlixage {
    return Intl.message(
      'Search in Flixage',
      name: 'searchPage_searchInFlixage',
      desc: '',
      args: [],
    );
  }

  /// `Find your favorite music`
  String get searchPage_findFavouriteMusic {
    return Intl.message(
      'Find your favorite music',
      name: 'searchPage_findFavouriteMusic',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error has occurred :(`
  String get searchPage_unknownError {
    return Intl.message(
      'Unknown error has occurred :(',
      name: 'searchPage_unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Not found "{query}"`
  String searchPage_notFound(Object query) {
    return Intl.message(
      'Not found "$query"',
      name: 'searchPage_notFound',
      desc: '',
      args: [query],
    );
  }

  /// `Try again, checking the spelling`
  String get searchPage_tryAgain {
    return Intl.message(
      'Try again, checking the spelling',
      name: 'searchPage_tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Track • {name}`
  String trackItem_track(Object name) {
    return Intl.message(
      'Track • $name',
      name: 'trackItem_track',
      desc: '',
      args: [name],
    );
  }

  /// `Artist`
  String get artistItem_artist {
    return Intl.message(
      'Artist',
      name: 'artistItem_artist',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get userItem_user {
    return Intl.message(
      'User',
      name: 'userItem_user',
      desc: '',
      args: [],
    );
  }

  /// `Album`
  String get albumItem_album {
    return Intl.message(
      'Album',
      name: 'albumItem_album',
      desc: '',
      args: [],
    );
  }

  /// `Playlist`
  String get playlistItem_playlist {
    return Intl.message(
      'Playlist',
      name: 'playlistItem_playlist',
      desc: '',
      args: [],
    );
  }

  /// `Created by {name}`
  String playlistItem_createdBy(Object name) {
    return Intl.message(
      'Created by $name',
      name: 'playlistItem_createdBy',
      desc: '',
      args: [name],
    );
  }

  /// `Monthly listeners: {monthlyListeners}`
  String albumPage_monthlyListeners(Object monthlyListeners) {
    return Intl.message(
      'Monthly listeners: $monthlyListeners',
      name: 'albumPage_monthlyListeners',
      desc: '',
      args: [monthlyListeners],
    );
  }

  /// `Problem during fetching user library`
  String get libraryFetchError {
    return Intl.message(
      'Problem during fetching user library',
      name: 'libraryFetchError',
      desc: '',
      args: [],
    );
  }

  /// `Track has been added to playlist "{name}"`
  String trackAdded(Object name) {
    return Intl.message(
      'Track has been added to playlist "$name"',
      name: 'trackAdded',
      desc: '',
      args: [name],
    );
  }

  /// `Error during adding track to playlist "{name}"`
  String trackAddError(Object name) {
    return Intl.message(
      'Error during adding track to playlist "$name"',
      name: 'trackAddError',
      desc: '',
      args: [name],
    );
  }

  /// `Playlist '{name}' has been created`
  String playlistCreated(Object name) {
    return Intl.message(
      'Playlist \'$name\' has been created',
      name: 'playlistCreated',
      desc: '',
      args: [name],
    );
  }

  /// `Problem during creation of playlist '{name}'`
  String playlistCreateError(Object name) {
    return Intl.message(
      'Problem during creation of playlist \'$name\'',
      name: 'playlistCreateError',
      desc: '',
      args: [name],
    );
  }

  /// `Playlist '{name}' has been deleted`
  String playlistDeleted(Object name) {
    return Intl.message(
      'Playlist \'$name\' has been deleted',
      name: 'playlistDeleted',
      desc: '',
      args: [name],
    );
  }

  /// `Playlist during deletion of playlist '{name}'`
  String playlistDeleteError(Object name) {
    return Intl.message(
      'Playlist during deletion of playlist \'$name\'',
      name: 'playlistDeleteError',
      desc: '',
      args: [name],
    );
  }

  /// `Playlist '{name}' has been updated`
  String playlistUpdated(Object name) {
    return Intl.message(
      'Playlist \'$name\' has been updated',
      name: 'playlistUpdated',
      desc: '',
      args: [name],
    );
  }

  /// `Error during update of playlist '{name}'`
  String playlistUpdateError(Object name) {
    return Intl.message(
      'Error during update of playlist \'$name\'',
      name: 'playlistUpdateError',
      desc: '',
      args: [name],
    );
  }

  /// `Remove playlist`
  String get playlistContextMenu_removePlaylist {
    return Intl.message(
      'Remove playlist',
      name: 'playlistContextMenu_removePlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Edit playlist`
  String get playlistContextMenu_editPlaylist {
    return Intl.message(
      'Edit playlist',
      name: 'playlistContextMenu_editPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Share playlist`
  String get playlistContextMenu_sharePlaylist {
    return Intl.message(
      'Share playlist',
      name: 'playlistContextMenu_sharePlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Show artist`
  String get trackContextMenu_showArtist {
    return Intl.message(
      'Show artist',
      name: 'trackContextMenu_showArtist',
      desc: '',
      args: [],
    );
  }

  /// `Show album`
  String get trackContextMenu_showAlbum {
    return Intl.message(
      'Show album',
      name: 'trackContextMenu_showAlbum',
      desc: '',
      args: [],
    );
  }

  /// `Add to playlist`
  String get trackContextMenu_addToPlaylist {
    return Intl.message(
      'Add to playlist',
      name: 'trackContextMenu_addToPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Name your playlist`
  String get createPlaylistPage_namePlaylist {
    return Intl.message(
      'Name your playlist',
      name: 'createPlaylistPage_namePlaylist',
      desc: '',
      args: [],
    );
  }

  /// `New playlist`
  String get pickPlaylistPage_newPlaylist {
    return Intl.message(
      'New playlist',
      name: 'pickPlaylistPage_newPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Add to playlist`
  String get pickPlaylistPage_addToPlaylist {
    return Intl.message(
      'Add to playlist',
      name: 'pickPlaylistPage_addToPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknownError {
    return Intl.message(
      'Unknown error',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginPage_login {
    return Intl.message(
      'Login',
      name: 'loginPage_login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerPage_register {
    return Intl.message(
      'Register',
      name: 'registerPage_register',
      desc: '',
      args: [],
    );
  }

  /// `Welcome {name}!`
  String homePage_welcome(Object name) {
    return Intl.message(
      'Welcome $name!',
      name: 'homePage_welcome',
      desc: '',
      args: [name],
    );
  }

  /// `Latest albums`
  String get homePage_latestAlbums {
    return Intl.message(
      'Latest albums',
      name: 'homePage_latestAlbums',
      desc: '',
      args: [],
    );
  }

  /// `Latest artists`
  String get homePage_latestArtists {
    return Intl.message(
      'Latest artists',
      name: 'homePage_latestArtists',
      desc: '',
      args: [],
    );
  }

  /// `Latest singles`
  String get homePage_latestSingles {
    return Intl.message(
      'Latest singles',
      name: 'homePage_latestSingles',
      desc: '',
      args: [],
    );
  }

  /// `Recently played`
  String get homePage_recentlyPlayed {
    return Intl.message(
      'Recently played',
      name: 'homePage_recentlyPlayed',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't connect to server`
  String get loginPage_serversUnavailable {
    return Intl.message(
      'Couldn\'t connect to server',
      name: 'loginPage_serversUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Authentication service unavailable`
  String get loginPage_authenticationServiceUnvaiable {
    return Intl.message(
      'Authentication service unavailable',
      name: 'loginPage_authenticationServiceUnvaiable',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}