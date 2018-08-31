import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/songs.dart';
import '../models/song.dart';

class SongsList extends StatelessWidget {
  final List<Song> songs;
  final String type;

  SongsList(this.songs, this.type);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SongsModel>(
      builder: (BuildContext context, Widget child, SongsModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                ListTile(
                  leading: Text(
                    '${songs[index].songNumber}.',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  title: InkWell(
                    onTap: () {
                      model.selectSong(songs[index].songNumber, type);
                      Navigator.pushNamed(
                        context,
                        '/$type/${index.toString()}',
                      );
                    },
                    child: Text(
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
        );
      },
    );
  }
}
