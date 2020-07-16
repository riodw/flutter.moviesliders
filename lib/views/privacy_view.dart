import 'package:flutter/material.dart';

class PrivacyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('MovieSliders Privacy Policy'),
        actions: <Widget>[],
      ),
      body: SafeArea(
          child: Container(
        // margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Center(
            child: Text(
          'Privacy Privacy View',
          style: Theme.of(context).textTheme.headline5,
        )),
      )),
    );
  }
}
