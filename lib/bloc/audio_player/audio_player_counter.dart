import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flixage/repository/track_repository.dart';
import 'package:logger/logger.dart';

/// Counter that sends info to API when user has listened to song over 30 seconds
class AudioPlayerCounter {
  static final logger = Logger();

  final AssetsAudioPlayer _audioPlayer;
  final TrackRepository _trackRepository;

  PlayingAudio currentAudio;
  int listeningDuration = 0;
  int lastPosition = 0;
  bool hasSent = false;

  AudioPlayerCounter(this._audioPlayer, this._trackRepository) {
    _audioPlayer.current.listen((event) {
      currentAudio = event?.audio ?? null;
      listeningDuration = 0;
      lastPosition = 0;
      hasSent = false;
    });

    _audioPlayer.currentPosition.listen((event) async {
      if (_audioPlayer.current.value == null) {
        return;
      }

      if (currentAudio != _audioPlayer.current.value.audio) {}

      if (event.inSeconds - lastPosition == 1) {
        listeningDuration++;
      }

      if (listeningDuration >= 30 && !hasSent) {
        hasSent = true;

        logger.d(
            "User has been listening for more than 30 seconds, increasing stream count");

        await _trackRepository.increaseStreamCount(currentAudio.audio.metas.id);
      }

      lastPosition = event.inSeconds;
    });
  }
}
