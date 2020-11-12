// Pub
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                            // height: 35,
                            ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              const BoxShadow(
                                color: Colors.black54,
                                blurRadius:
                                    16, // has the effect of softening the shadow
                                spreadRadius:
                                    0, // has the effect of extending the shadow
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset('Logo/Icon-App-40x40@3x.png',
                                width: 54),
                          ),
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        Text(
                          'MovieSliders',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        const Divider(
                          color: Colors.grey,
                          height: 50,
                          thickness: 0.5,
                          indent: 60,
                          endIndent: 60,
                        ),
                        const Text(
                          'People judge an experience largely based on how they felt at its peak and at its end, rather than the total sum or average of every moment of the experience.\n\nThis phenomenon is refered to as the Peak-End Rule.',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Rating movies is a puerly subjective art form. While this app can not make rating movies objective, it can solve the Peak-End Rule, and at a minimum, give you a way to compaire a feature film to any other on a one-to-one basis.',
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 40,
                          thickness: 0.5,
                          indent: 60,
                          endIndent: 60,
                        ),
                        const Text(
                          'There are 5 trends that are tracked. Each trened represents an aspect that can have high impact on a feature films enjoyment. The five trends are tracked in real time to create a perennial heart beat that you can use to know exactly how one felt durring the entertainment. While currently there are only five trends that are tracked, this may change in the future to allow custom trends.',
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 40,
                          thickness: 0.5,
                          indent: 60,
                          endIndent: 60,
                        ),
                        const Text(
                          'When a movie is finished a final rating is given. A rating is formed by taking the average of every data point from the Interest trend.',
                        ),
                        const SizedBox(
                          height: 34,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
