import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:launch_review/launch_review.dart';

import '../widgets/songs_list.dart';
import '../widgets/fab.dart';
import '../scoped_models/songs.dart';

class MyHomePage extends StatefulWidget {
  final bool newUser;
  final Function makeOldUser;
  final BuildContext context;

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }

  MyHomePage(this.newUser, this.makeOldUser, this.context, {Key key})
      : super(key: key);
}

class MyHomePageState extends State<MyHomePage> {
  Widget appBarTitle = Text('Thuthi Geethangal');
  Icon actionIcon = Icon(Icons.search);
  TextEditingController _searchQuery = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.newUser) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showDialog(
            context: context,
            builder: (BuildContext context) => new AlertDialog(
                  title: Text('Welcome to Thuthi Geethangal'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Praise be to god',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Thank you for giving this App a shot . It was not easy getting here but we made it 👍🏼 and have a long way to go . Kindly use the Feedback form 📨 to contact us and to notify us if there is any error 👾with the app or content missing 🤖 . Do rate our app in play store . Continue to encourage us for there are goodies yet to come . ciao 😍',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Take me there!'),
                      onPressed: () {
                        widget.makeOldUser();
                        LaunchReview.launch(
                            androidAppId: 'com.cadoapps.telchymns');
                      },
                    ),
                    FlatButton(
                      child: Text('No Thanks'),
                      onPressed: () {
                        widget.makeOldUser();
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      });
    }
  }

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
      }),
    );
  }
}
