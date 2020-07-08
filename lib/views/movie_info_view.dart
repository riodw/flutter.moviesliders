import 'dart:convert';
// packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
// project
// - auth
// import 'package:flutter_moviesliders/services/auth_service.dart';
import 'package:flutter_moviesliders/services/services.dart';

class MovieInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Rated Movies'),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: ListView(),
      ),
    );
  }
}
