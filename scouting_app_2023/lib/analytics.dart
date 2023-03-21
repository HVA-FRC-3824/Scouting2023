import 'package:flutter/material.dart';
import 'package:scouting_app_2023/main.dart';
import 'package:scouting_app_2023/variables.dart' as variables;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scouting_app_2023/shared_prefs.dart' as prefs;

dynamic returnRobotJson(robotNumber) async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('2023/').get();
  var robotJson = {};
  var iterations = 0;
  print(snapshot.value);
  if (snapshot.exists) {
    dynamic snap = snapshot.value;
    for (var i = 0; i < snap.length; i++) {
      if (snap[i] != null) {
        if (snap[i]['118'] != null) {
          var pageData = snap[i]['118']['pageData'];
          var top = 0;
          var mid = 0;
          var bot = 0;
          var auto = 0;
          var linkTracker = 0;
          var linkAmount = 0;
          var charging = 404;
          var startingPos;
          for (var k = 0; k < 27; k++) {
            if (k < 9) {
              if (pageData[k] == '1') {
                top = top + 1;
                linkTracker = linkTracker + 1;
                if (linkTracker == 3) {
                  linkTracker = 0;
                  linkAmount = linkAmount + 1;
                }
              } else {
                linkTracker = 0;
              }
            } else if (k < 18) {
              if (k == 9) {
                linkTracker = 0;
              }
              if (pageData[k] == '1') {
                mid = mid + 1;
                linkTracker = linkTracker + 1;
                if (linkTracker == 3) {
                  linkTracker = 0;
                  linkAmount = linkAmount + 1;
                }
              } else {
                linkTracker = 0;
              }
            } else if (k < 27) {
              if (k == 18) {
                linkTracker = 0;
              }
              if (pageData[k] == '1') {
                bot = bot + 1;
                linkTracker = linkTracker + 1;
                if (linkTracker == 3) {
                  linkTracker = 0;
                  linkAmount = linkAmount + 1;
                }
              } else {
                linkTracker = 0;
              }
            }
            if (pageData[31] == 'noCharging') {
              charging = 0;
            } else if ((pageData[31] == 'left+docked') ||
                (pageData[31] == 'right+docked')) {
              charging = 6;
            } else if ((pageData[31] == 'left+engaged') ||
                (pageData[31] == 'right+engaged')) {
              charging = 10;
            } else if (pageData[31] == 'scouterError') {
              charging = 10;
            } else {
              charging = 404;
            }
            if (pageData[27] == 'left') {
              startingPos = 0;
            } else if (pageData[27] == 'middle') {
              startingPos = 1;
            } else if (pageData[27] == 'right') {
              startingPos = 2;
            }
          }

          print(linkAmount);
          print(pageData[27]);
          print(pageData[31]);
          if (robotJson['startingPos'] != null) {
            robotJson['startingPos'] = ((robotJson['startingPos']!.toDouble() *
                        iterations.toDouble()) +
                    startingPos) /
                (iterations.toDouble() + 1).toDouble();
          } else {
            robotJson['startingPos'] = startingPos;
          }
          if (robotJson['pointsAverage'] != null) {
            robotJson['pointsAverage'] = (((top * 5) + (mid * 3) + (bot * 2)) +
                    (robotJson['pointsAverage'] * iterations)) /
                (iterations + 1);
          } else {
            robotJson['pointsAverage'] = (top * 5) + (mid * 3) + (bot * 2);
          }
          if (charging != 404) {
            if (robotJson['chargingPoints'] != null) {
              robotJson['chargingPoints'] =
                  ((robotJson['chargingPoints'] * iterations) + charging) /
                      (iterations + 1);
            } else {
              robotJson['chargingPoints'] = charging;
            }
          }
          iterations = iterations + 1;
        }
      }
    }
  } else {
    print('No data available.');
  }
  print('iterations' + iterations.toString());
  print(robotJson);
}
