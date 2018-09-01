import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DefaultTextStyle(
              style: Theme.of(context).textTheme.title,
              child: AckWidget(),
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.title,
              child: AbtWidget(),
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.title,
              child: CrdWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class AckWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: RichText(
        textAlign: TextAlign.center,
        text: new TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            new TextSpan(
                text: '"Praise The Lord"',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                  fontSize: 30.0,
                  height: 0.7,
                )),
            new TextSpan(
                text:
                    '\nWhat started as a simple\nLyrics app has turned out to be the\nsong book for all denominations.\nIt couldn\'t have been possible if not\nfor ',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 30.0,
                  height: 0.7,
                )),
            new TextSpan(
                text: 'TELC Arulnathar Youth',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                  fontSize: 30.0,
                  height: 0.7,
                )),
            new TextSpan(
                text: ' for taking\ninitiation and ',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 30.0,
                  height: 0.7,
                )),
            new TextSpan(
                text: 'Hannah John',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                  fontSize: 30.0,
                  height: 0.7,
                )),
            new TextSpan(
                text:
                    ' for\nlaying the foundation by\nbringing the song books in a\ndigital format.',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 30.0,
                  height: 0.7,
                )),
          ],
        ),
      ),
    );
  }
}

class AbtWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: RichText(
        textAlign: TextAlign.center,
        text: new TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            new TextSpan(text: 'This is an '),
            new TextSpan(
                text: 'adfree',
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new TextSpan(
                text:
                    ' app and we request you to\nshare your thoughts and suggestions.'),
          ],
        ),
      ),
    );
  }
}

class CrdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: RichText(
        textAlign: TextAlign.center,
        text: new TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            new TextSpan(text: 'App created & maintained by\n'),
            new TextSpan(
                text: 'Rohan Joshua Godwin\nSherin Binu',
                style: new TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Merriweather')),
          ],
        ),
      ),
    );
  }
}
