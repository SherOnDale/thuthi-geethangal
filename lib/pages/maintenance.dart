import 'package:flutter/material.dart';

class MaintenancePage extends StatelessWidget {
  final String title;

  MaintenancePage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Image(
          image: AssetImage('assets/images/UC.png'),
          height: 150.0,
        ),
      ),
    );
  }
}
