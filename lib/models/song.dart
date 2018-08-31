import 'package:flutter/material.dart';

class Song {
  final List<List<String>> lyrics;
  final String title;
  final int songNumber;
  final int orderNumber;

  Song({
    @required this.lyrics,
    @required this.title,
    @required this.songNumber,
    @required this.orderNumber,
  });
}
