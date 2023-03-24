import 'package:scouting_app_2023/variables.dart' as variables;

import 'package:shared_preferences/shared_preferences.dart';

void setPageDataSP(matchNumber, robotNumber) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(
    matchNumber.toString() + '/' + robotNumber.toString() + '/pageData',
    variables.pageData,
  );
}

void setSuperScoutSP(robotNumber) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(robotNumber.toString() + 'ssData', variables.ssData);
}

void setPitScoutSP(robotNumber) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(robotNumber.toString() + 'pitData', variables.pitData);
}

void setCodeToSP(secretCode) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('Secret_Code', secretCode);
}

void setSSFB() async {
  final prefs = await SharedPreferences.getInstance();
  var bot = 0;
  for (var j = bot; j < 9999; j++) {
    if (prefs.containsKey(j.toString() + 'ssData')) {
      print('This idea ran');
      variables.firebaseSSPush[j.toString()] =
          prefs.getStringList(j.toString() + 'ssData');
    }
  }
}

void setPitScoutFB() async {
  print('Pit Scout saved to sp initially');
  final prefs = await SharedPreferences.getInstance();
  var bot = 0;
  for (var j = bot; j < 9999; j++) {
    if (prefs.containsKey(j.toString() + 'pitData')) {
      print('This idea ran');
      variables.firebasePitPush[(prefs.getString('Secret_Code'))! +
          j.toString()] = prefs.getStringList(j.toString() + 'pitData');
    }
  }
}

void setStringSP(stringNameinSP, stringValue) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(stringNameinSP, stringValue);
}

var run = 0;

void setFirebasePush() async {
  final prefs = await SharedPreferences.getInstance();
  var match = 0; //matchNumber
  var bot = 0; //robotNumber
  String username;
  try {
    if (prefs.containsKey('username')) {
      username = prefs.getString('username').toString();
      variables.firebasePush['username'] = username;
    }
  } on Error {}
  for (var i = match; i < 150; i++) {
    for (var j = bot; j < 9999; j++) {
      if (prefs.containsKey(i.toString() + '/' + j.toString() + '/pageData')) {
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
