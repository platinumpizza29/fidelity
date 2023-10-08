import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
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
    providerStore.playAudio(widget.model.uri!, widget.model.id);
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
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: imageContainer(),
              ),
              Center(
                child: Text(
                  widget.model.displayNameWOExt.toString(),
                ),
              ),
              Center(
                child: Text(
                  widget.model.artist.toString(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(context
                        .watch<ProviderStore>()
                        .position
                        .toString()
                        .split(".")[0]),
                    Expanded(
                      child: Slider(
                        value: providerStore.position.inSeconds.toDouble(),
                        min: const Duration(microseconds: 0)
                            .inSeconds
                            .toDouble(),
                        max: providerStore.duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          providerStore.handleSliderSeek(value.toInt());
                        },
                      ),
                    ),
                    Text(context
                        .watch<ProviderStore>()
                        .duration
                        .toString()
                        .split(".")[0])
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
                        providerStore.playAudio(
                            widget.model.uri!, widget.model.id);
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

class imageContainer extends StatelessWidget {
  const imageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.9,
      width: double.infinity,
      decoration: BoxDecoration(
        color: CupertinoColors.lightBackgroundGray,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const ArtWorkWidget(),
    );
  }
}

class ArtWorkWidget extends StatelessWidget {
  const ArtWorkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      artworkFit: BoxFit.cover,
      key: ValueKey<int>(context.watch<ProviderStore>().songId),
      id: context.watch<ProviderStore>().songId,
      type: ArtworkType.AUDIO,
      nullArtworkWidget: const Icon(
        Ionicons.musical_note,
        size: 55,
      ),
    );
  }
}
