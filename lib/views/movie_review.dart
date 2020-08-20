import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// charts
import 'package:flutter_moviesliders/widgets/chart_widget.dart';
import 'package:flutter_moviesliders/models/models.dart';

/* Comparison from episode to episode
 * https://google.github.io/charts/flutter/example/scatter_plot_charts/comparison_points
*/

class MovieReviewView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Review review = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Review'),
        actions: <Widget>[],
      ),
      body: ListView(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 15, right: 15),
          child: Text(
            review.title,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15, right: 15),
          child: Text(
            (review.type == 'movie'
                    ? review.movie.dateReleased.year.toString()
                    : '9999') +
                ' - Rating: ' +
                review.avg10.toString(),
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Container(
            height: 200,
            // decoration: BoxDecoration(
            //   // color: Colors.white,
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.grey.withOpacity(0.4),
            //       spreadRadius: 0,
            //       blurRadius: 7,
            //       offset: Offset(0, 0), // changes position of shadow
            //     ),
            //   ],
            // ),
            child: NumericComboLinePointChart.withRatings(
              trendsList: review.trends,
              // animate: false
            )),
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
                Navigator.pushNamed(context, '/chart', arguments: review);
              },
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0, left: 15, right: 15),
          child: Text(
            'Received a rating of ' + review.avg.truncate().toString() + '/100',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 6.0, bottom: 10.0, left: 15, right: 15),
          child: Text(
            'Exact rating: ' + review.avg.toString(),
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
            review.movie.posterUrl,
            height: 260,
            loadingBuilder: (BuildContext context, Object child, progress) {
              return progress == null
                  ? child
                  : const CircularProgressIndicator();
            },
            errorBuilder: (BuildContext context, Object exception,
                StackTrace stackTrace) {
              return const Center(child: Text('Image Not Found'));
            },
            fit: BoxFit.fill,
          ),
        )
      ]),
    );
  }
}
