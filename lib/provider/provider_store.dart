// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ProviderStore with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool _isPlaying = false;
  int _seekPosition = 0;
  int _songId = 0;
  List<SongModel> _likedSongs = [];

  bool get isPlaying => _isPlaying;
  Duration get position => _position;
  Duration get duration => _duration;
  int get seekPosition => _seekPosition;
  int get songId => _songId;
  List<SongModel> get likedSongs => _likedSongs;

  handleIsPlaying(bool status) {
    _isPlaying = status;
    notifyListeners();
  }

  void playAudio(String audioUrl, int id) async {
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(audioUrl)));
      _isPlaying = true;
      _player.play();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    _player.positionStream.listen(
      (event) {
        _position = event;
        notifyListeners();
      },
    );
    _player.durationStream.listen(
      (event) {
        _duration = event!;
        notifyListeners();
      },
    );
  }

  void pauseAudio() {
    _player.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void handleSliderSeek(int value) {
    Duration duration = Duration(seconds: value);
    _player.seek(duration);
    _seekPosition = value;
    notifyListeners();
  }

  void handleSetSongId(int id) {
    _songId = id;
    notifyListeners();
  }

  void handleLikedSongs(SongModel song) {
    if (_likedSongs.contains(song)) {
      _likedSongs.remove(song);
      notifyListeners();
    } else {
      _likedSongs.add(song);
      notifyListeners();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
