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
import 'package:flutter_moviesliders/models/models.dart';

/**
 * http://www.omdbapi.com/?i=tt3896198&apikey=cf1629a0
 */

final String omdbUrl = "http://www.omdbapi.com/apikey=cf1629a0";

Future<OmdbModel> _fetchOmdb(String imbdId) async {
  // OmdbModel omdb_selected;

  final String url = omdbUrl + "&i=" + imbdId;
  final response = await http.get(url);

  if (response.statusCode != 200) return null;

  var omdbJson = response.body;

  return OmdbModel.fromJson(json.decode(omdbJson));
}

class MovieInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ImdbModel suggestion = ModalRoute.of(context).settings.arguments;
    print(suggestion.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(suggestion.title),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: ListView(),
      ),
    );
  }
}
