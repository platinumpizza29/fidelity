import 'package:flutter/material.dart';
import 'package:musicplayer/provider/provider_store.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key, required this.model});
  final SongModel model;

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    ProviderStore providerStore =
        Provider.of<ProviderStore>(context, listen: false);
    providerStore.playAudio(widget.model.uri!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderStore>(
      builder: (context, providerStore, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.9,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Center(
                child: Text(
                  widget.model.displayNameWOExt.toString(),
                ),
              ),
              Center(
                child: Text(widget.model.artist.toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("0.0"),
                    Expanded(
                      child: Slider(
                        value: 0.9,
                        onChanged: (value) {},
                      ),
                    ),
                    const Text("0.0")
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (providerStore.isPlaying) {
                        providerStore.pauseAudio();
                      } else {
                        providerStore.playAudio(widget.model.uri!);
                      }
                    },
                    icon: Icon(
                      providerStore.isPlaying == true
                          ? Icons.pause
                          : Icons.play_arrow_rounded,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_next_rounded,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
