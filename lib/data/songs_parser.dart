import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../models/song.dart';

Future<String> _loadHymnsAsset() async {
  return await rootBundle.loadString('assets/data/hymns.json');
}

Future<String> _loadKeerthanaiAsset() async {
  return await rootBundle.loadString('assets/data/keerthanai.json');
}

Future<String> _loadPaamalaiAsset() async {
  return await rootBundle.loadString('assets/data/paamalai.json');
}

List<Song> _parseJsonSongs(String jsonSongs) {
  List decoded = jsonDecode(jsonSongs);
  List<Song> songs = [];
  for (var song in decoded) {
    List<List<String>> lyrics = [];
    for (var el in song['lyrics']) {
      List<String> para = [];
      for (var line in el) {
        para.add(line.toString());
      }
      lyrics.add(para);
    }
    songs.add(Song(
      lyrics: lyrics,
      title: song['title'],
      songNumber: song['sNo'],
      orderNumber: song['oNo'],
    ));
  }
  return songs;
}

Future loadHymns() async {
  String jsonHymns = await _loadHymnsAsset();
  List<Song> hymns = _parseJsonSongs(jsonHymns);
  return hymns;
}

Future loadKeerthanai() async {
  String jsonKeerthanai = await _loadKeerthanaiAsset();
  List<Song> keerthanais = _parseJsonSongs(jsonKeerthanai);
  return keerthanais;
}

Future loadPaamalai() async {
  String jsonPaamalai = await _loadPaamalaiAsset();
  List<Song> paamalais = _parseJsonSongs(jsonPaamalai);
  return paamalais;
}
