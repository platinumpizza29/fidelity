// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ProviderStore with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  Duration _duration = Duration();
  Duration _position = Duration();
  bool _isPlaying = false;
  int _seekPosition = 0;

  bool get isPlaying => _isPlaying;
  Duration get position => _position;
  Duration get duration => _duration;
  int get seekPosition => _seekPosition;

  handleIsPlaying(bool status) {
    _isPlaying = status;
    notifyListeners();
  }

  void playAudio(String audioUrl) async {
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(audioUrl)));
      _isPlaying = true;
      _player.play();
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
    notifyListeners();
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

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
