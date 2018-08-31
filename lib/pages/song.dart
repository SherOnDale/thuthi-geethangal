import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:share/share.dart';

import '../scoped_models/songs.dart';
import '../widgets/fab.dart';

class SongPage extends StatelessWidget {
  final int index;
  final String type;

  SongPage(this.index, this.type);

  Widget _buildLyrics(int index, String type, SongsModel model, int i) {
    List<Widget> columnList = [];
    for (int j = 0; j < model.selectedSong.lyrics[i].length; j++) {
      Widget para;
      if (model.selectedSong.lyrics[i][j].contains('<header>')) {
        String text =
            model.selectedSong.lyrics[i][j].replaceAll(RegExp('<header>'), '');
        para = Text(
          text,
          style: TextStyle(
            fontSize: model.fontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            wordSpacing: 4.0,
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        );
      } else {
        para = Text(
          model.selectedSong.lyrics[i][j],
          style: TextStyle(
            fontSize: model.fontSize,
            fontWeight: FontWeight.w100,
            letterSpacing: 1.1,
            wordSpacing: 4.0,
            height: 1.3,
          ),
        );
      }
      columnList.add(para);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SongsModel>(
      builder: (BuildContext context, Widget child, SongsModel model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              model.selectedSong.title,
              style: TextStyle(fontSize: 20.0),
              overflow: TextOverflow.fade,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  String shareText = '${model.selectedSong.title}\n\n';
                  for (int i = 0; i < model.selectedSong.lyrics.length; i++) {
                    shareText += '${(i + 1).toString()}. ';
                    for (int j = 0;
                        j < model.selectedSong.lyrics[i].length;
                        j++) {
                      shareText += '${model.selectedSong.lyrics[i][j]}\n';
                    }
                    shareText += '\n';
                  }
                  shareText +=
                      '\nGet TELC Hymns from Play Store: https://play.google.com/store/apps/details?id=com.cadoapps.telchymns';
                  Share.share(shareText);
                },
              )
            ],
          ),
          body: Container(
            margin: EdgeInsets.all(20.0),
            alignment: Alignment.topCenter,
            child: ListView.builder(
              itemCount: model.selectedSong.lyrics.length,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  margin: EdgeInsets.only(bottom: 25.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        (i + 1).toString(),
                        style: TextStyle(fontSize: model.fontSize - 2),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(child: _buildLyrics(index, type, model, i)),
                    ],
                  ),
                );
              },
            ),
          ),
          floatingActionButton: Fab(),
        );
      },
    );
  }
}
