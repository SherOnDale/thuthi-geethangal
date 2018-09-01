import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:launch_review/launch_review.dart';

import '../widgets/songs_list.dart';
import '../widgets/fab.dart';
import '../scoped_models/songs.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }

  MyHomePage({Key key}) : super(key: key);
}

class MyHomePageState extends State<MyHomePage> {
  Widget appBarTitle = Text('Thuthi Geethangal');
  Icon actionIcon = Icon(Icons.search);
  TextEditingController _searchQuery = TextEditingController();

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit Thuthi Geethangal?'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('NO'),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('YES'),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: ScopedModelDescendant<SongsModel>(
          builder: (BuildContext context, Widget child, SongsModel model) {
        _searchQuery.addListener(() {
          if (_searchQuery.text.isEmpty) {
            model.stopSearching();
          } else {
            model.startSearching(_searchQuery.text.trim());
          }
        });
        // _showWelcomeMessage(model.newUser, model.makeOldUser);
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: appBarTitle,
              actions: <Widget>[
                IconButton(
                    icon: actionIcon,
                    onPressed: () {
                      setState(() {
                        if (this.actionIcon.icon == Icons.search) {
                          this.actionIcon = Icon(Icons.close);
                          this.appBarTitle = TextField(
                            controller: _searchQuery,
                            style: TextStyle(
                              color: model.isNightMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(
                                  color: model.isNightMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          );
                        } else {
                          model.stopSearching();
                          this.actionIcon = Icon(Icons.search);
                          this.appBarTitle = Text('TELC Hymns');
                        }
                      });
                    }),
              ],
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(text: 'HYMNS'),
                  Tab(text: 'KEERTHANAI'),
                  Tab(text: 'PAAMALAI'),
                ],
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'THUTHI',
                          style:
                              TextStyle(fontFamily: 'Alpaca', fontSize: 25.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('GEETHANGAL',
                            style:
                                TextStyle(fontFamily: 'Alpaca', fontSize: 25.0))
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text('Songs'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Bible'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/bible');
                    },
                  ),
                  ListTile(
                    title: Text('Order of Service'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/oos');
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                    child: new Center(
                      child: new Container(
                        margin: new EdgeInsetsDirectional.only(
                            start: 1.0, end: 1.0),
                        height: 1.5,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('About Us'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                  ListTile(
                    title: Text('Feedback'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/feedback');
                    },
                  ),
                  ListTile(
                    title: Text('Rate Us'),
                    onTap: () {
                      LaunchReview.launch(
                          androidAppId: 'com.cadoapps.telchymns');
                    },
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                SongsList(model.allHymns, 'hymn'),
                SongsList(model.allKeerthanais, 'keerthanai'),
                SongsList(model.allPaamalais, 'paamalai'),
              ],
            ),
            floatingActionButton: Fab(),
          ),
        );
      }),
    );
  }
}
