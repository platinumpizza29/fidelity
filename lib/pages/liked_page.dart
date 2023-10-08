import 'package:flutter/material.dart';
import 'package:musicplayer/provider/provider_store.dart';
import 'package:provider/provider.dart';

class LikedSongs extends StatelessWidget {
  const LikedSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderStore>(
      builder: (context, providerStore, child) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView.builder(
            itemCount: providerStore.likedSongs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(providerStore.likedSongs![index].displayNameWOExt
                    .toString()),
              );
            },
          ),
        );
      },
    );
  }
}
