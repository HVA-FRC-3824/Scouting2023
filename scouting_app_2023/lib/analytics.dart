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
  final snapshot = await ref.child('SMR2023/').get();
  var iterations = 0;
  var robotJson = {
    // 'startingPos'
    // 'pointsAverage'
    // 'chargingPoints'
    //
  };

  print('snapshot is a ' + (snapshot.value.runtimeType).toString());
  if (snapshot.exists) {
    dynamic snap = snapshot.value;
    if (snap[robotNumber.toString()] != null) {
      print(snap['13']);
      for (var i = 0; i < 60; i++) {
        dynamic data = snap[robotNumber.toString()][i.toString()];
        if (data != null) {
          print('THE DATA READS' + data.toString());
          var pageData = snap[robotNumber.toString()][i.toString()]['pageData'];
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
          if (robotJson['startingPos'] != null && startingPos != null) {
            print(robotJson['startingPos']);
            print(iterations);
            print(startingPos);
            print(pageData[27]);
            robotJson['startingPos'] =
                (((double.parse(robotJson['startingPos']) *
                                iterations.toDouble()) +
                            startingPos) /
                        (iterations.toDouble() + 1).toDouble())
                    .toString();
          } else if (startingPos != null) {
            robotJson['startingPos'] = startingPos.toString();
          }
          if (robotJson['pointsAverage'] != null) {
            robotJson['pointsAverage'] = ((((top * 5) + (mid * 3) + (bot * 2)) +
                        (double.parse(robotJson['pointsAverage']) *
                            iterations)) /
                    (iterations + 1))
                .toString();
          } else {
            robotJson['pointsAverage'] =
                ((top * 5) + (mid * 3) + (bot * 2)).toString();
          }
          if (charging != 404) {
            if (robotJson['chargingPoints'] != null) {
              robotJson['chargingPoints'] =
                  (((double.parse(robotJson['chargingPoints']) * iterations) +
                              charging) /
                          (iterations + 1))
                      .toString();
            } else {
              robotJson['chargingPoints'] = charging.toString();
            }
          }
          iterations = iterations + 1;
        }
      }
      if (snap[robotNumber.toString()]['pitData'] != null) {
        print(snap[robotNumber.toString()]['pitData'].runtimeType);
        robotJson['driveTrain'] = snap[robotNumber.toString()]['pitData'][0];
        robotJson['cargoTypes'] = snap[robotNumber.toString()]['pitData'][4];
      }
      if (snap[robotNumber.toString()]['superData'] != null) {
        robotJson['mindset'] = snap[robotNumber.toString()]['superData'][1];
        robotJson['gripper'] = snap[robotNumber.toString()]['superData'][0];
        robotJson['ssnotes'] = snap[robotNumber.toString()]['superData'][2];
      }
    }
  } else {
    print('No data available.');
  }
  print(robotJson.runtimeType);
  return (robotJson);
}
