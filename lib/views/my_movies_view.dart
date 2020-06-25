import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// project
import 'package:flutter_moviesliders/services/services.dart';
// - auth
import 'package:flutter_moviesliders/services/auth_service.dart';

/* Comparison from episode to episode
https://google.github.io/charts/flutter/example/scatter_plot_charts/comparison_points
*/

class MyMoviesView extends StatefulWidget {
  MyMoviesView({Key key}) : super(key: key);

  @override
  _MyMoviesState createState() => _MyMoviesState();
}

class _MyMoviesState extends State<MyMoviesView> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Rated Movies'),
        actions: <Widget>[
          IconButton(
            icon: themeProvider.isDarkModeOn
                ? Icon(Icons.brightness_low)
                : Icon(Icons.brightness_high),
            onPressed: () {
              var theme = themeProvider.isDarkModeOn ? 'light' : 'dark';
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(theme);
            },
          ),
          // action buttons
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              final actionSheet = CupertinoActionSheet(
                  // title: Text('Select Option'),
                  // message: Text('Which option?'),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: Text('About MovieSliders'),
                      onPressed: () {
                        print('pressed: About MovieSliders');
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text('Terms of Service'),
                      onPressed: () {
                        print('pressed: Terms of Service');
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text('Privacy'),
                      onPressed: () {
                        print('pressed: Privacy Policy');
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text('Log Out'),
                      onPressed: () {
                        AuthService _auth = AuthService();
                        _auth.signOut();
                        Navigator.of(context).pushNamed('/signin');
                      },
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ));
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => actionSheet);
            },
          ),
        ],
      ),
      body: Container(
        child: SafeArea(
            child: ListView(children: <Widget>[
          Container(
              margin: EdgeInsets.only(
                  top: 20.0, left: 25.0, right: 20.0, bottom: 10.0),
              child: Row(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius:
                              22.0, // has the effect of softening the shadow
                          spreadRadius:
                              0, // has the effect of extending the shadow
                          // offset: Offset(
                          // 10.0, // horizontal, move right 10
                          // 10.0, // vertical, move down 10
                          // ),
                        )
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius:
                                0, // has the effect of softening the shadow
                            spreadRadius:
                                0, // has the effect of extending the shadow
                          )
                        ],
                      ),
                      child: Image.asset('assets/images/moviesliders_icon.png',
                          width: 60),
                    )),
                Column(children: <Widget>[
                  Text(
                    'Movie Sliders',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text('Data Driven Movie Reviews',
                      style: Theme.of(context).textTheme.bodyText1)
                ])
              ])),
          Divider(
            color: Colors.grey[300],
            height: 25,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          Container(
            margin:
                EdgeInsets.only(top: 0.0, right: 30.0, bottom: 0, left: 30.0),
            child: ButtonTheme(
              minWidth: 320.0,
              height: 40.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sliders',
                      arguments: 'this is a test');
                },
                // textColor: Colors.white,
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  child: Text(
                    'New Review',
                    style: Theme.of(context).textTheme.button,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300],
            height: 25,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          color: Colors.grey[400],
                          height: 170.0,
                        ),
                        Text(
                          'Altered Carbon: Season 1 Episode 5 (The Wrong Man)',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          '2017 - Rating 6.9',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(height: 10.0),
                        Row(children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0))),
                            width: 34.0,
                            height: 34.0,
                            margin: EdgeInsets.only(right: 10.0),
                            child: Center(
                                child: Text('RW',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ))),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Rio Weber',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  '22 Mar 2018 - asdf',
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                              ])
                        ]),
                        Divider(
                          color: Colors.grey[300],
                          height: 35,
                          thickness: 1,
                          indent: 15,
                          endIndent: 15,
                        ),
                      ],
                    )),
                onTap: () {
                  Navigator.pushNamed(context, '/movie_review');
                },
              )
            ],
          ),
        ])),
      ),
    );
  }
}