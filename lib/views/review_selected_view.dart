// Pub
import 'package:flutter/material.dart';
// Project
import 'package:flutter_moviesliders/widgets/chart_widget.dart';
import 'package:flutter_moviesliders/models/models.dart';

/* Comparison from episode to episode
 * https://google.github.io/charts/flutter/example/scatter_plot_charts/comparison_points
*/

class ReviewSelectedView extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final Review review = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Review'),
        // actions: <Widget>[],
      ),
      body: ListView(children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            review.title,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
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
        FlatButton(
          // textColor: Colors.white,
          child: const Text(
            'View Full Graph',
            style: TextStyle(
                decoration: TextDecoration.underline, color: Colors.black),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/chart', arguments: review);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Received a rating of ' + review.avg.truncate().toString() + '/100',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Exact rating: ' + review.avg.toString(),
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        const Divider(
          color: Colors.grey,
          height: 40,
          thickness: 1,
          indent: 30,
          endIndent: 30,
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Review',
              style: Theme.of(context).textTheme.headline2,
            )),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Image.network(
            review.movie.posterUrl,
            loadingBuilder: (final BuildContext context, final Object child,
                final progress) {
              return progress == null
                  ? child
                  : const Center(child: const CircularProgressIndicator());
            },
            errorBuilder: (final BuildContext context, final Object exception,
                final StackTrace stackTrace) {
              return const Center(child: const Text('Image Not Found'));
            },
            // fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
