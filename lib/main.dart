import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import './models/song.dart';
import './scoped_models/songs.dart';
import './pages/home.dart';
import './pages/song.dart';
import './pages/about.dart';
import './pages/maintenance.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final List<Song> songs = [];
  @override
  Widget build(BuildContext context) {
    return ScopedModel<SongsModel>(
      model: SongsModel(),
      child: ScopedModelDescendant<SongsModel>(
        builder: (BuildContext context, Widget child, SongsModel model) {
          return MaterialApp(
            title: 'Thuthi Geethangal',
            theme: new ThemeData(
              accentColor: Colors.black,
              primarySwatch: MaterialColor(0xFF3BF793, {
                50: Color(0xFFb6fcd6),
                100: Color(0xFF9dfbc9),
                200: Color(0xFF85fabb),
                300: Color(0xFF6cf9ae),
                400: Color(0xFF54f8a0),
                500: Color(0xFF3bf793),
                600: Color(0xFF23f685),
                700: Color(0xFF0af578),
                800: Color(0xFF09dc6c),
                900: Color(0xFF08c460),
              }),
              brightness:
                  model.isNightMode ? Brightness.dark : Brightness.light,
            ),
            home: new MyHomePage(),
            routes: {
              '/bible': (_) => MaintenancePage('Bible'),
              '/oos': (_) => MaintenancePage('Order of Service'),
              '/about': (_) => AboutPage(),
              '/feedback': (_) => new WebviewScaffold(
                    url: 'https://goo.gl/forms/uzNHwEr9DqudLFxx2',
                    appBar: new AppBar(title: Text('Feedback')),
                  )
            },
            onGenerateRoute: (RouteSettings settings) {
              final List<String> pathElements = settings.name.split('/');
              if (pathElements[1] == 'hymn' ||
                  pathElements[1] == 'keerthanai' ||
                  pathElements[1] == 'paamalai') {
                return MaterialPageRoute<bool>(
                  builder: (BuildContext context) =>
                      SongPage(int.parse(pathElements[2]), pathElements[1]),
                );
              }
            },
          );
        },
      ),
    );
  }
}
