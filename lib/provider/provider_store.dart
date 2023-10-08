import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongModelProvider with ChangeNotifier {
  int _id = 0;
  List<SongModel> _likedSongs = [];

  int get id => _id;
  List<SongModel> get likedSongs => _likedSongs;

  void setId(int id) {
    _id = id;
    notifyListeners();
  }

  void handleLikedSongs(SongModel model) {
    if (_likedSongs.contains(model)) {
      _likedSongs.remove(model);
      notifyListeners();
    } else {
      _likedSongs.add(model);
      notifyListeners();
    }
  }
}
