// Pub
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// Project
import 'package:flutter_moviesliders/constants/globals.dart';

class PrivacyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    final FirebaseUser userProvider = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: Column(children: <Widget>[
          const SizedBox(
            height: 8,
          ),
          // Center(
          //     child: Text(
          //   'Privacy Privacy View',
          //   style: Theme.of(context).textTheme.headline5,
          // )),
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                  // scrollDirection: Axis.horizontal,
                  child: Container(
                // padding: EdgeInsets.only(left: 3, bottom: 9),
                child: Center(
                  child: Text(
                    'Privacy Privacy View',
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
                        'Deleting your asdf asdf asdf',
                      ),
                      actions: <Widget>[
                        FlatButton(
                          textColor: Colors.red,
                          child: const Text('DELETE EVEYTHING'),
                          onPressed: () async {
                            final DatabaseReference _dbRef =
                                dbRef.child('reviews');

                            // REMOVE ALL FROM 'done'
                            await _dbRef
                                .child('done')
                                .orderByChild('user_id')
                                .equalTo(userProvider.uid)
                                .once()
                                .then((final DataSnapshot snapshot) {
                              print(userProvider.uid);
                              snapshot.value?.forEach((key, value) {
                                _dbRef.child('done').child(key).remove();
                              });
                            });

                            // REMOVE ALL FROM 'not_done'
                            await _dbRef
                                .child('not_done')
                                .orderByChild('user_id')
                                .equalTo(userProvider.uid)
                                .once()
                                .then((final DataSnapshot snapshot) {
                              print(userProvider.uid);
                              snapshot.value?.forEach((key, value) {
                                _dbRef.child('not_done').child(key).remove();
                              });
                            });

                            // DELETE USER
                            userProvider.delete();
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
        ]),
      ),
    );
  }
}
