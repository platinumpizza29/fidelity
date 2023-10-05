import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ProviderStore with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

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
    notifyListeners();
  }

  void pauseAudio() {
    _player.pause();
    _isPlaying = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
