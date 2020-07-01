import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// charts
import 'package:flutter_moviesliders/widgets/chart_widget.dart';

/* Comparison from episode to episode
https://google.github.io/charts/flutter/example/scatter_plot_charts/comparison_points
*/

class MovieReviewView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review'),
        actions: <Widget>[],
      ),
      body: SafeArea(
          child: ListView(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 15, right: 15),
          child: Text(
            'Black Mirror: Season 4 Episode 5 (Metalhead)',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15, right: 15),
          child: Text(
            '2017 - Rating: 6.9',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: NumericComboLinePointChart.withSampleData()),
        Container(
          // margin: EdgeInsets.only(bottom: 20.0),
          child: ButtonTheme(
            // minWidth: 200.0,
            height: 50.0,
            child: FlatButton(
              // textColor: Colors.white,
              child: Text(
                'View Full Graph',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/chart');
              },
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0, left: 15, right: 15),
          child: Text(
            'Received a rating of 69/100',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 6.0, bottom: 10.0, left: 15, right: 15),
          child: Text(
            'Exact rating: 69.0658333',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        Divider(
          color: Colors.grey[300],
          height: 35,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        Container(
            margin:
                EdgeInsets.only(top: 6.0, bottom: 10.0, left: 15, right: 15),
            child: Text(
              'Review',
              style: Theme.of(context).textTheme.headline2,
            )),
        Container(
            margin: EdgeInsets.only(bottom: 10.0, left: 15, right: 15),
            child: Image.network(
              'https://m.media-amazon.com/images/M/MV5BYTM3YWVhMDMtNjczMy00NGEyLWJhZDctYjNhMTRkNDE0ZTI1XkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_SX1000.jpg',
            ))
      ])),
    );
  }
}
