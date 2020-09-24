import 'dart:io';
// Pub
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
// Project
import 'package:flutter_moviesliders/services/connectivity_service.dart';

bool iNet = true;

final SnackBar snackBar = SnackBar(
  content: Text('No Connection'),
  duration: Duration(days: 365),
  // action: SnackBarAction(
  //     label: 'Recheck',
  //     onPressed: () {
  //       print(iNet);
  //       if (iNet) scaffoldKey.currentState.removeCurrentSnackBar();
  //     }),
);

Future<bool> testConnection() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      iNet = true;
    }
  } on SocketException catch (_) {
    iNet = false;
  }
  return iNet;
}

int called = 0;

// display Offline
void displayInet(connectionStatus, final ScaffoldState scaffoldKeyState) {
  if (scaffoldKeyState == null) return null;

  // CHECK CONNECTION
  Future.delayed(const Duration(seconds: 1)).then((value) {
    testConnection().then((value) {
      if (!iNet) {
        called++;
        scaffoldKeyState.showSnackBar(snackBar);
      } else {
        for (; called > 0; called--) {
          scaffoldKeyState.removeCurrentSnackBar();
        }
      }
    });
  });
}

final DatabaseReference dbRef = FirebaseDatabase.instance.reference();

String interpretMonthInt(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
  }
  return 'Good job, you broke it';
}

int interpretMonthString(String month) {
  switch (month) {
    case 'Jan':
      return 1;
    case 'Feb':
      return 2;
    case 'Mar':
      return 3;
    case 'Apr':
      return 4;
    case 'May':
      return 5;
    case 'Jun':
      return 6;
    case 'Jul':
      return 7;
    case 'Aug':
      return 8;
    case 'Sep':
      return 9;
    case 'Oct':
      return 10;
    case 'Nov':
      return 11;
    case 'Dec':
      return 12;
  }
  return 1;
}
