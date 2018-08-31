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
        child: Text('Coming Soon'),
      ),
    );
  }
}
