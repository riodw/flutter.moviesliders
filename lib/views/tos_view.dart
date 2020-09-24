// Pub
import 'package:flutter/material.dart';

class TermsOfServiceView extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('TOS for MovieSliders'),
        actions: <Widget>[],
      ),
      body: SafeArea(
          child: Container(
        // margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Center(
            child: Text(
          'Terms Of Service View',
          style: Theme.of(context).textTheme.headline5,
        )),
      )),
    );
  }
}
