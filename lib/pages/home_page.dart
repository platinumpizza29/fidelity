// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:musicplayer/pages/now_playing.dart';
import 'package:musicplayer/provider/provider_store.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final audioQuery = OnAudioQuery();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discover",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Consumer<ProviderStore>(
        builder: (context, providerStore, child) {
          return Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: audioQuery.querySongs(
                      sortType: null,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Ionicons.musical_note),
                          trailing: Icon(
                            Icons.more_vert_rounded,
                          ),
                          title: Text(snapshot.data![index].displayNameWOExt),
                          subtitle:
                              Text(snapshot.data![index].artist.toString()),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => NowPlaying(
                                  model: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              providerStore.isPlaying == true
                  ? InkWell(
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    )
                  : Text(""),
            ],
          );
        },
      ),
    );
  }

  void requestPermission() async {
    await Permission.storage.request();
  }
}
