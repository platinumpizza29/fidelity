import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/pages/now_playing.dart';
import 'package:musicplayer/provider/provider_store.dart';
import 'package:provider/provider.dart';

class LikeSongs extends StatelessWidget {
  LikeSongs({super.key});
  final AudioPlayer _audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Consumer<SongModelProvider>(
      builder: (context, songModelProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Liked Songs"),
          ),
          body: ListView.builder(
            itemCount: songModelProvider.likedSongs.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  context
                      .read<SongModelProvider>()
                      .setId(songModelProvider.likedSongs[index].id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NowPlaying(songModelList: [
                                songModelProvider.likedSongs[index]
                              ], audioPlayer: _audioPlayer)));
                },
                title:
                    Text(songModelProvider.likedSongs[index].displayNameWOExt),
                subtitle:
                    Text(songModelProvider.likedSongs[index].artist.toString()),
              );
            },
          ),
        );
      },
    );
  }
}
