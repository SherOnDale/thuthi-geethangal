import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/songs.dart';
import '../models/song.dart';

class SongsList extends StatelessWidget {
  final List<Song> songs;
  final String type;

  SongsList(
    this.songs,
    this.type,
  );

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SongsModel>(
      builder: (BuildContext context, Widget child, SongsModel model) {
        return Scrollbar(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  InkWell(
                    child: ListTile(
                      onTap: () {
                        model.selectSong(songs[index].songNumber, type);
                        Navigator.pushNamed(
                          context,
                          '/$type/${index.toString()}',
                        );
                      },
                      leading: Text(
                        '${songs[index].songNumber}.',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      title: Text(
                        '${songs[index].title}',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: model.fontSize),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                  ),
                  Divider(),
                ],
              );
            },
            itemCount: songs.length,
          ),
        );
      },
    );
  }
}
