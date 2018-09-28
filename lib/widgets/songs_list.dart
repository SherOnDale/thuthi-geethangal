import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

import 'package:telc_hymns/scoped_models/songs.dart';
import 'package:telc_hymns/models/song.dart';

class SongsList extends StatelessWidget {
  final List<Song> songs;
  final String type;
  final ScrollController scrollController;

  SongsList(
    this.songs,
    this.type,
    this.scrollController,
  );

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SongsModel>(
      builder: (BuildContext context, Widget child, SongsModel model) {
        return DraggableScrollbar.semicircle(
          controller: scrollController,
          labelTextBuilder: (offset) {
            final int currentItem = (scrollController.offset /
                    scrollController.position.maxScrollExtent *
                    songs.length)
                .ceil();
            return Text(currentItem.toString());
          },
          labelConstraints: BoxConstraints.tightFor(width: 80.0, height: 30.0),
          child: ListView.builder(
            controller: scrollController,
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
