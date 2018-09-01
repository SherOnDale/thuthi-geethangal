import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/songs.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Praise be to god',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontFamily: 'Merriweather',
                  fontSize: 40.0,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Thank you for giving this App a shot.\nIt was not easy getting here but we\nmade it 👍🏼and have a long way to go.\nKindly use the Feedback form 📨\nto contact us and to notify us if\nthere is any error 👾 with the app\nor content missing 🤖.Do rate\nour app in play store and Continue to\nencourage us for there are goodies yet to come.\n ciao 😍',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Alpaca',
                  height: 1.3,
                ),
              ),
            ),
            Container(
              child: ScopedModelDescendant<SongsModel>(
                builder:
                    (BuildContext context, Widget child, SongsModel model) {
                  return Column(
                    children: <Widget>[
                      // RaisedButton(
                      //   child: Text('TAKE ME THERE!'),
                      //   onPressed: () {
                      //     // model.makeOldUser();
                      //     LaunchReview.launch(
                      //         androidAppId: 'com.cadoapps.telchymns');
                      //   },
                      // ),
                      MaterialButton(
                        height: 50.0,
                        minWidth: double.infinity,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: new Text(
                          "RATE US NOW!",
                          style: TextStyle(fontSize: 25.0),
                        ),
                        onPressed: () {
                          model.makeOldUser();
                          LaunchReview.launch(
                              androidAppId: 'com.cadoapps.telchymns');
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      MaterialButton(
                        height: 50.0,
                        minWidth: double.infinity,
                        // color: Theme.of(context).secondaryHeaderColor,
                        textColor: Colors.white,
                        child: new Text(
                          "NOT NOW",
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          model.makeOldUser();
                          Navigator.pushReplacementNamed(context, '/');
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
