// Pub
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// Project
import 'package:flutter_moviesliders/constants/globals.dart';

class PrivacyView extends StatefulWidget {
  PrivacyView({Key key}) : super(key: key);

  @override
  _PrivacyView createState() => _PrivacyView();
}

class _PrivacyView extends State<PrivacyView> {
  bool _deleting = false;

  @override
  Widget build(final BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    final FirebaseUser userProvider = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Sliders'),
        actions: <Widget>[],
      ),
      body: SafeArea(
          child: _deleting
              ? Column(children: <Widget>[
                  const SizedBox(
                    height: 60,
                  ),
                  const Text('Deleting in progress...'),
                  const SizedBox(
                    height: 35,
                  ),
                  const Center(
                    child: const CircularProgressIndicator(),
                  )
                ])
              : Column(children: <Widget>[
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                          // scrollDirection: Axis.horizontal,
                          child: Container(
                        // padding: EdgeInsets.only(left: 3, bottom: 9),
                        child: Center(
                          child: Text(
                            'Privacy View',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ))),
                  MaterialButton(
                      height: 45.0,
                      minWidth: 320.0,
                      color: Colors.red,
                      child: const Text('Delete Account & All Data'),
                      onPressed: () => showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: const Text('Are you Sure?'),
                              content: const Text(
                                'Deleting your account is irreversible.',
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  textColor: Colors.red,
                                  child: const Text('DELETE EVEYTHING'),
                                  onPressed: () async {
                                    setState(() {
                                      _deleting = true;
                                      Navigator.pop(context);
                                    });

                                    // reference to reviews database
                                    final DatabaseReference _dbRef =
                                        dbRef.child('reviews');

                                    // REMOVE ALL FROM 'done'
                                    await _dbRef
                                        .child('done')
                                        .orderByChild('user_id')
                                        .equalTo(userProvider.uid)
                                        .once()
                                        .then((final DataSnapshot snapshot) {
                                      snapshot.value?.forEach((key, value) {
                                        _dbRef
                                            .child('done')
                                            .child(key)
                                            .remove();
                                      });
                                    });

                                    //// --- Can't run because access to /reviews/not_done is denied
                                    // REMOVE ALL FROM 'not_done'
                                    // await _dbRef
                                    //     .child('not_done')
                                    //     .orderByChild('user_id')
                                    //     .equalTo(userProvider.uid)
                                    //     .once()
                                    //     .then((final DataSnapshot snapshot) {
                                    //   snapshot.value?.forEach((key, value) {
                                    //     _dbRef
                                    //         .child('not_done')
                                    //         .child(key)
                                    //         .remove();
                                    //   });
                                    // });

                                    // DELETE USER
                                    try {
                                      await userProvider.delete();
                                      return 0;
                                    } on PlatformException catch (error) {
                                      print(error);
                                      await FirebaseAuth.instance.signOut();
                                      return error;
                                    }
                                  },
                                ),
                                FlatButton(
                                  child: const Text('Cancel'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          )),
                  const SizedBox(
                    height: 8,
                  )
                ])),
    );
  }
}
