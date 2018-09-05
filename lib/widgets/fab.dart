import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:telc_hymns/scoped_models/songs.dart';

class Fab extends StatefulWidget {
  @override
  _FabState createState() => _FabState();
}

class _FabState extends State<Fab> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _translateButton;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });

    _animateIcon = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));

    _animateColor = ColorTween(
      // begin: Colors.lightGreen,
      begin: Color(0xFF3BF793),
      end: Color(0xFF9dfbc9),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget increaseFontSize(model) {
    return new Container(
      child: FloatingActionButton(
        heroTag: 'increaseFontSize',
        backgroundColor: Color(0xFF3BF793),
        foregroundColor: Colors.black,
        onPressed: () {
          model.changeFontSize(true);
        },
        tooltip: 'Increase Font Size',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget decreaseFontSize(model) {
    return new Container(
      child: FloatingActionButton(
        heroTag: 'decreaseFontSize',
        backgroundColor: Color(0xFF3BF793),
        foregroundColor: Colors.black,
        onPressed: () {
          model.changeFontSize(false);
        },
        tooltip: 'Decrease Font Size',
        child: Icon(Icons.remove),
      ),
    );
  }

  Widget toggleNightMode(model) {
    return new Container(
      child: FloatingActionButton(
        heroTag: 'toggleNightMode',
        backgroundColor: Color(0xFF3BF793),
        foregroundColor: Colors.black,
        onPressed: () {
          model.toggleMode();
        },
        tooltip: 'Toggle Night Mode',
        child:
            Icon(model.isNightMode ? Icons.brightness_7 : Icons.brightness_2),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'toggle',
        backgroundColor: _animateColor.value,
        foregroundColor: Colors.black,
        onPressed: animate,
        tooltip: 'Options',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SongsModel>(
      builder: (BuildContext context, Widget child, SongsModel model) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                _translateButton.value * 3.0,
                0.0,
              ),
              child: increaseFontSize(model),
            ),
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                _translateButton.value * 2.0,
                0.0,
              ),
              child: decreaseFontSize(model),
            ),
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                _translateButton.value,
                0.0,
              ),
              child: toggleNightMode(model),
            ),
            toggle(),
          ],
        );
      },
    );
  }
}
