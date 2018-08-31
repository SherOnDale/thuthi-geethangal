import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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

  // MyHomePageState() {
  // _searchQuery.addListener(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SongsModel>(
        builder: (BuildContext context, Widget child, SongsModel model) {
      _searchQuery.addListener(() {
        if (_searchQuery.text.isEmpty) {
          model.stopSearching();
        } else {
          model.startSearching(_searchQuery.text.trim());
        }
      });
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
                            color:
                                model.isNightMode ? Colors.white : Colors.black,
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
                  child: SizedBox(),
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
                Divider(),
                ListTile(
                  title: Text('Feedback'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/feedback');
                  },
                ),
                ListTile(
                  title: Text('About Us'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/about');
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
    });
  }
}
