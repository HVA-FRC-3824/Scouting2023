import 'package:flutter/material.dart';
import 'package:scouting_app_2023/variables.dart' as variables;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setPageDataSP(matchNumber, robotNumber) async {
  print("loopinghere1");
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(
    matchNumber.toString() + '/' + robotNumber.toString() + '/pageData',
    variables.pageData,
  );
}

void setStringSP(stringNameinSP, stringValue) async {
  print('loopinghere2');
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(stringNameinSP, stringValue);
}

var run = 0;

void setFirebasePush() async {
  print('this is running');
  final prefs = await SharedPreferences.getInstance();
  var match = 0; //matchNumber
  var bot = 0; //robotNumber
  var username;
  print(prefs);
  print('this is running2222');
  try {
    if (prefs.containsKey('username')) {
      username = prefs.getString('username');
      variables.firebasePush['username'] = username;
    }
  } on Error {
    print('usernameToFBerror');
  }
  for (var i = match; i < 150; i++) {
    for (var j = bot; j < 9999; j++) {
      if (prefs.containsKey(i.toString() + '/' + j.toString() + '/pageData')) {
        print("weran");
        var temp = {
          'pageData': (prefs
              .getStringList(i.toString() + '/' + j.toString() + '/pageData'))
        };
        var temp2 = {j.toString(): temp};
        variables.firebasePush[i.toString()] = temp2;
      } else {}
    }
  }
}

// void setUserFromSP() async {
//   final prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey('username')) {
//     final String? action = prefs.getString('username');

//     variables.pageData[29] = action;
//   }
// }
