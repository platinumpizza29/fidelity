// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

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
        title: Text("Fidelity"),
      ),
      body: FutureBuilder(
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
                leading: Icon(Icons.music_note),
                title: Text(snapshot.data![index].displayNameWOExt),
                subtitle: Text(snapshot.data![index].artist.toString()),
              );
            },
          );
        },
      ),
    );
  }

  void requestPermission() async {
    await Permission.storage.request();
  }
}
