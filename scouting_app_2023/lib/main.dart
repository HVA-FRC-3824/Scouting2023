import 'package:flutter/material.dart';
import 'package:scouting_app_2023/variables.dart' as variables;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scouting_app_2023/shared_prefs.dart' as prefs;
import 'package:scouting_app_2023/analytics.dart' as analytics;

bool authState = false;
String errorMessage = 'noError';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//  final counter = prefs.getStringList('pageData') ?? 0;
//  prefs.remove('pageData');
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/grid': (context) => const SecondScreen(),

        '/prep': (context) => const PrepScreen(),

        '/create': (context) => const CreateAccount(),

        '/signin': (context) => const GeneralSignin(),

        '/endgame': (context) => const Endgame(),

        '/auto': (context) => const Auto(),

        '/pitPrep': (context) => const PitPrep(),

        '/pit': (context) => const Pit(),

        '/SScout': (context) => const SScout(),

        '/analytics': (context) => const Analytics(),
      },
    ),
  );

  prefs.setFirebasePush();
  analytics.returnRobotJson(1313);
//AUTHENTICATION
  WidgetsFlutterBinding.ensureInitialized();
  if (3 != 3) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "",
          authDomain: "",
          databaseURL: "", // **DATABASEURL MUST BE GIVEN.**
          projectId: "",
          storageBucket: "",
          messagingSenderId: "",
          appId: ""),
    );
  } else {}
  // FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //   if (user == null) {
  //   } else {}
  // });
//This when not commented out sets the persistent storage to variables.pageData
//DO NOT UNDER ANY CIRCUMSTANCES LEAVE THIS COMMENTED INTO THE CODE
//await prefs.setStringList('pageData', variables.pageData);
}

class GeneralSignin extends StatefulWidget {
  const GeneralSignin({super.key});
  @override
  State<GeneralSignin> createState() => GeneralSigninState();
}

class GeneralSigninState extends State<GeneralSignin> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final loginText = "Login";
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    super.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        leading: Container(),
        title: const Text('login'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'USERNAME',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'PASSWORD',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.amber),
                ),
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 30),
                  child: const Text('Login'),
                ),
                onPressed: () {
                  variables.pageData[37] = usernameController.text;
                  variables.password = passwordController.text;
                  prefs.setStringSP('username', usernameController.text);
                  signIntoAccount(context, usernameController.text,
                      passwordController.text);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    if (errorMessage != 'noError') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    }
                  });
                  FirebaseAuth.instance.authStateChanges().listen((User? user) {
                    if (user == null) {
                      authState = false;
                    } else {
                      authState = true;

                      Navigator.pushNamed(context, '/');
                    }
                  });
                },
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 300),
              margin: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
              child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey),
                ),
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 50),
                  child: const Text('Create Acc?'),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/create');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic signIntoAccount(context, emailAddress, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        errorMessage = e.code;
      } else if (e.code == 'wrong-password') {
        errorMessage = e.code;
      } else {
        errorMessage = 'noError';
      }
    }
  }
}

Widget _buildPopupDialog(context) {
  return AlertDialog(
    title: const Text('Login Error'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(errorMessage),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});
  @override
  State<CreateAccount> createState() => CreateAccountState();
}

class CreateAccountState extends State<CreateAccount> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    super.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        leading: Container(),
        title: const Text('Account Creation'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 25),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'USERNAME',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 25),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'PASSWORD',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 25),
              child: TextButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.amber),
                ),
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 30),
                  child: const Text('Create'),
                ),
                onPressed: () async {
                  createAccount(
                    context,
                    usernameController.text,
                    passwordController.text,
                  );
                  signIntoAccount(context, usernameController.text,
                      passwordController.text);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    if (errorMessage != 'noError') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    }
                  });
                  //authState = true;
                  //Navigator.pushNamed(context, '/');
                  variables.pageData[37] = usernameController.text;
                  variables.password = passwordController.text;
                  prefs.setStringSP('username', usernameController.text);
                  FirebaseAuth.instance.authStateChanges().listen((User? user) {
                    if (user == null) {
                      authState = false;
                    } else {
                      authState = true;

                      Navigator.pushNamed(context, '/');
                    }
                  });
                },
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 300),
              margin: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
              child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey),
                ),
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 50),
                  child: const Text('Sign in?'),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/signin');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic createAccount(context, emailAddress, password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress.toString(),
        password: password.toString(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = e.code;
      } else if (e.code == 'email-already-in-use') {
        errorMessage = e.code;
      } else {
        errorMessage = "noError";
      }
    } catch (e) {}
  }

  dynamic signIntoAccount(context, emailAddress, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage = e.code;
      } else if (e.code == 'wrong-password') {
        errorMessage = e.code;
      } else {
        errorMessage = 'noError';
      }
    }
  }

  Widget _buildPopupDialog(context) {
    return AlertDialog(
      title: const Text('Login Error'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(errorMessage),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => FirstScreenState();
}

bool settings = false;

// dynamic signin() async {
//   if (FirebaseAuth.instance.currentUser != null) {
//     print(FirebaseAuth.instance.currentUser?.uid);
//   }
// }

class FirstScreenState extends State<FirstScreen> {
  bool tempSettings = false;
  void refresh(rhaaSettings) async {
    if (rhaaSettings == true) {
      tempSettings = true;
    } else if (rhaaSettings == false) {
      tempSettings = false;
    }
    setState(() {});
  }

  // dynamic signin() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     print(FirebaseAuth.instance.currentUser?.uid);
  //   }
  // }

  dynamic tempState;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        variables.pageData[37] = user.email.toString();
        tempState = true;
      } else {
        tempState = false;
      }
    });
    return Scaffold(
      appBar: appBar(context, tempSettings),
      body: layout(context, tempSettings),
    );
  }

  LayoutBuilder layout(context, tempSettings) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (tempSettings == true) {
        return settingsPage(context);
      } else if (tempState == true) {
        return buildNormalHome(context);
      } else if (tempState == false) {
        return loginScreen(context);
      }
      return buildNormalHome(context);
    });
  }

  AppBar appBar(context, tempSettings) {
    if (tempSettings == true) {
      return AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        leading: Container(),
        actions: [
          TextButton(
            child: const Text("BACK",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                )),
            onPressed: () {
              settings = false;
              refresh(settings);
            },
          ),
        ],
        title: const Text('Home'),
      );
    } else {
      return AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        leading: Container(),
        actions: [
          TextButton(
            child: const Text("SETTINGS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                )),
            onPressed: () {
              settings = true;
              refresh(settings);
            },
          ),
        ],
        title: const Text('Home'),
      );
    }
  }

  Widget loginScreen(context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height / 20),
            child: TextButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height / 20),
            child: TextButton(
              child: const Text('Create Account'),
              onPressed: () {
                Navigator.pushNamed(context, '/create');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNormalHome(context) {
    var textSize = ((MediaQuery.of(context).size.height / 2) *
            (MediaQuery.of(context).size.width) /
            5) /
        40;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(50),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/rohawktics_logo.png')),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * .05),
            color: Color.fromARGB(255, 187, 255, 241),
            child: TextButton(
              // Within the `FirstScreen` widget
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/SScout');
              },
              child: Text(
                'Super Scouting',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (textSize / 40),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * .1),
            color: Color.fromARGB(255, 147, 41, 41),
            child: TextButton(
              // Within the `FirstScreen` widget
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/pitPrep');
              },
              child: Text(
                'Pit Scouting',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (textSize / 40),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * .1),
            color: const Color.fromARGB(255, 123, 123, 123),
            child: TextButton(
              // Within the `FirstScreen` widget
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/prep');
              },
              child: Text(
                'Scouting',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (textSize / 40),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * .1),
            color: const Color.fromARGB(255, 75, 156, 211),
            child: TextButton(
              // Within the `FirstScreen` widget
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/analytics');
              },
              child: Text(
                'Analytics',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (textSize / 40),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * .1),
            color: const Color.fromARGB(255, 61, 61, 144),
            child: TextButton(
              // Within the `FirstScreen` widget
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => schedulePopup(context),
                );
              },
              child: Text(
                'Schedule',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (textSize / 40),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget schedulePopup(BuildContext context) {
    return AlertDialog(
        title: const Text('Sorry!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text("The Schedule Page is a feature still amidst development."),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Close"),
          ),
        ]);
  }

  Widget settingsPage(context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(50),
          ),
          TextButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => logOut(context),
                );
              },
              child: const Text("Sign Out")),
          Container(
            margin: const EdgeInsets.all(50),
          ),
          TextButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) => resetPrefs(context),
              );
            },
            child: const Text('Reset ALL Device Storage'),
          )
        ],
      ),
    );
  }

  Widget logOut(BuildContext context) {
    return AlertDialog(
      title: const Text('Popup example'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Are you sure?"),
          Text('(Clicking yes logs you out)'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        TextButton(
          child: const Text("Yes"),
          onPressed: () async {
            settings = false;
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Widget resetPrefs(BuildContext context) {
    return AlertDialog(
      title: const Text('Popup example'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Are you sure?"),
          Text('(Clicking yes deletes ALL your data)'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        TextButton(
          child: const Text("Yes"),
          onPressed: () async {
            settings = false;
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.clear();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}

class PrepScreen extends StatefulWidget {
  const PrepScreen({super.key});

  @override
  State<PrepScreen> createState() => PrepScreenState();
}

class PrepScreenState extends State<PrepScreen> {
  @override
  Widget build(BuildContext context) {
    var matchNumberController = TextEditingController();
    var robotNumberController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        title: const Text('MatchPrep'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 25),
              child: TextField(
                controller: matchNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'MATCH NUMBER',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 25),
              child: TextField(
                controller: robotNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'ROBOT NUMBER',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 25),
              child: TextButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.amber),
                ),
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 30),
                  child: const Text('Start Scouting'),
                ),
                onPressed: () {
                  variables.pageData[35] = matchNumberController.text;
                  variables.pageData[36] = robotNumberController.text;
                  Navigator.pushNamed(context, '/auto');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const List<Widget> startingToggle = <Widget>[
  Text('Left'),
  Text('Center'),
  Text('Right'),
];

const List<Widget> communityToggle = <Widget>[
  Text("Didn't leave Community"),
  Text('Did Leave Community'),
];

const List<Widget> dockingAuto = <Widget>[
  Text('Docked'),
  Text('Engaged'),
];

const List<Widget> scoringAuto = <Widget>[
  Text('Neither'),
  Text('Started W/ Cargo'),
  Text('Scored Cargo'),
];

class Auto extends StatefulWidget {
  const Auto({super.key});
  @override
  State<Auto> createState() => AutoState();
}

class AutoState extends State<Auto> {
  final List<bool> selectedStart = <bool>[false, false, false];
  final List<bool> selectedCommunity = <bool>[true, false];
  final List<bool> selectedCharging = <bool>[false, false];

  final List<bool> selectedScoring = <bool>[true, false, false];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (MediaQuery.of(context).size.width < 600) {
        return narrowScreen(context);
      } else {
        return wideScreen(context);
      }
    });
  }

  Scaffold narrowScreen(context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        title: const Text('Auto'),
        actions: [
          Container(),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text('PLEASE TURN SCREEN HORIZONTAL'),
      ),
    );
  }

  Scaffold wideScreen(context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        title: const Text('Auto'),
        actions: [
          TextButton(
            child: const Text(
              'Next',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              if (selectedStart[0]) {
                variables.pageData[27] = 'left';
              } else if (selectedStart[1]) {
                variables.pageData[27] = 'middle';
              } else if (selectedStart[2]) {
                variables.pageData[27] = 'right';
              }
              if (selectedCharging[1]) {
                variables.pageData[28] = "Engaged";
              } else if (selectedCharging[0]) {
                variables.pageData[28] = "Docked";
              } else {
                variables.pageData[28] = "None";
              }
              if (selectedCommunity[0]) {
                variables.pageData[29] = "Inside";
              } else if (selectedCommunity[1]) {
                variables.pageData[29] = "Left";
              }
              if (selectedScoring[2]) {
                variables.pageData[30] = "Scored";
              } else if (selectedScoring[1]) {
                variables.pageData[30] = "Cargo";
              } else if (selectedScoring[0]) {
                variables.pageData[30] = "None";
              }
              Navigator.pushNamed(context, '/grid');
            },
          ),
        ],
      ),
      body: Center(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          mainAxisSpacing: (MediaQuery.of(context).size.height / 40),
          crossAxisCount: 2,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(children: <Widget>[
                const Text(
                  'Starting Position',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < selectedStart.length; i++) {
                        selectedStart[i] = i == index;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.purple[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.purple[200],
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: selectedStart,
                  children: startingToggle,
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                const Text(
                  'Bot Leaving Community During Auto',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < selectedCommunity.length; i++) {
                        selectedCommunity[i] = i == index;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.purple[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.purple[200],
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 200.0,
                  ),
                  isSelected: selectedCommunity,
                  children: communityToggle,
                ),
              ]),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Charging Station Auto',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                  ),
                  ToggleButtons(
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.

                        selectedCharging[index] = !selectedCharging[index];
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.purple[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.purple[200],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 100.0,
                    ),
                    isSelected: selectedCharging,
                    children: dockingAuto,
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                  ),
                  const Text(
                    'Auto Scoring',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                  ),
                  ToggleButtons(
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < selectedScoring.length; i++) {
                          selectedScoring[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.purple[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.purple[200],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 130.0,
                    ),
                    isSelected: selectedScoring,
                    children: scoringAuto,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  void buttonPressed() async {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        leading: TextButton(
          child: const Text(
            'Back',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Second Screen'),
        actions: [
          TextButton(
            child: const Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            // Within the `FirstScreen` widget
            onPressed: () {
              // prefs.setFirebasePush();
              // Future.delayed(const Duration(milliseconds: 300), () {
              //   pushToFirebase();
              // }); //THIS IS A PUSH TO FIREBASE THAT WORKS YOU JUST HAVE TO DO IT ON LIVE SERVERS
              // Future.delayed(const Duration(milliseconds: 400), () {
              //   resetAllData();
              // });
              buttonPressed();
              Navigator.pushNamed(context, '/endgame');
            },
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return wideContainer(context);
          } else {
            return _buildNormalContainer();
          }
        },
      ),
    );
  }

  Widget _buildNormalContainer() {
    return Container(
      alignment: Alignment.center,
      child: const Text('PLEASE TURN SCREEN HORIZONTAL'),
    );
  }

  Widget wideContainer(context) {
    return Center(
        child: GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: (MediaQuery.of(context).size.height / 40),
      crossAxisCount: 9,
      children: <Widget>[
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.buttonOneImage)),
          ),
          onPressed: () {
            buttonOneImage();
            if (variables.buttonOneState == false) {
              buttonIndexChanger(0, true);
              variables.buttonOneState = true;
            } else {
              buttonIndexChanger(0, false);
              variables.buttonOneState = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.buttonTwoImage)),
          ),
          onPressed: () {
            buttonTwoImage();
            if (variables.buttonTwoState == false) {
              buttonIndexChanger(1, true);
              variables.buttonTwoState = true;
            } else {
              buttonIndexChanger(1, false);
              variables.buttonTwoState = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button3Image)),
          ),
          onPressed: () {
            button3Image();
            if (variables.button3State == false) {
              buttonIndexChanger(2, true);
              variables.button3State = true;
            } else {
              buttonIndexChanger(2, false);
              variables.button3State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button4Image)),
          ),
          onPressed: () {
            button4Image();
            if (variables.button4State == false) {
              buttonIndexChanger(3, true);
              variables.button4State = true;
            } else {
              buttonIndexChanger(3, false);
              variables.button4State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button5Image)),
          ),
          onPressed: () {
            button5Image();
            if (variables.button5State == false) {
              buttonIndexChanger(4, true);
              variables.button5State = true;
            } else {
              buttonIndexChanger(4, false);
              variables.button5State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button6Image)),
          ),
          onPressed: () {
            button6Image();
            if (variables.button6State == false) {
              buttonIndexChanger(5, true);
              variables.button6State = true;
            } else {
              buttonIndexChanger(5, false);
              variables.button6State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button7Image)),
          ),
          onPressed: () {
            button7Image();
            if (variables.button7State == false) {
              buttonIndexChanger(6, true);
              variables.button7State = true;
            } else {
              buttonIndexChanger(6, false);
              variables.button7State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button8Image)),
          ),
          onPressed: () {
            button8Image();
            if (variables.button8State == false) {
              buttonIndexChanger(7, true);
              variables.button8State = true;
            } else {
              buttonIndexChanger(7, false);
              variables.button8State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button9Image)),
          ),
          onPressed: () {
            button9Image();
            if (variables.button9State == false) {
              buttonIndexChanger(8, true);
              variables.button9State = true;
            } else {
              buttonIndexChanger(8, false);
              variables.button9State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button10Image)),
          ),
          onPressed: () {
            button10Image();
            if (variables.button10State == false) {
              buttonIndexChanger(9, true);
              variables.button10State = true;
            } else {
              buttonIndexChanger(9, false);
              variables.button10State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button11Image)),
          ),
          onPressed: () {
            button11Image();
            if (variables.button11State == false) {
              buttonIndexChanger(10, true);
              variables.button11State = true;
            } else {
              buttonIndexChanger(10, false);
              variables.button11State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button12Image)),
          ),
          onPressed: () {
            button12Image();
            if (variables.button12State == false) {
              buttonIndexChanger(11, true);
              variables.button12State = true;
            } else {
              buttonIndexChanger(11, false);
              variables.button12State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button13Image)),
          ),
          onPressed: () {
            button13Image();
            if (variables.button13State == false) {
              buttonIndexChanger(12, true);
              variables.button13State = true;
            } else {
              buttonIndexChanger(12, false);
              variables.button13State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button14Image)),
          ),
          onPressed: () {
            button14Image();
            if (variables.button14State == false) {
              buttonIndexChanger(13, true);
              variables.button14State = true;
            } else {
              buttonIndexChanger(13, false);
              variables.button14State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button15Image)),
          ),
          onPressed: () {
            button15Image();
            if (variables.button15State == false) {
              buttonIndexChanger(14, true);
              variables.button15State = true;
            } else {
              buttonIndexChanger(14, false);
              variables.button15State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button16Image)),
          ),
          onPressed: () {
            button16Image();
            if (variables.button16State == false) {
              buttonIndexChanger(15, true);
              variables.button16State = true;
            } else {
              buttonIndexChanger(15, false);
              variables.button16State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button17Image)),
          ),
          onPressed: () {
            button17Image();
            if (variables.button17State == false) {
              buttonIndexChanger(16, true);
              variables.button17State = true;
            } else {
              buttonIndexChanger(16, false);
              variables.button17State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button18Image)),
          ),
          onPressed: () {
            button18Image();
            if (variables.button18State == false) {
              buttonIndexChanger(17, true);
              variables.button18State = true;
            } else {
              buttonIndexChanger(17, false);
              variables.button18State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button19Image)),
          ),
          onPressed: () {
            button19Image();
            if (variables.button19State == false) {
              buttonIndexChanger(18, true);
              variables.button19State = true;
            } else {
              buttonIndexChanger(18, false);
              variables.button19State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button20Image)),
          ),
          onPressed: () {
            button20Image();
            if (variables.button20State == false) {
              buttonIndexChanger(19, true);
              variables.button20State = true;
            } else {
              buttonIndexChanger(19, false);
              variables.button20State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button21Image)),
          ),
          onPressed: () {
            button21Image();
            if (variables.button21State == false) {
              buttonIndexChanger(20, true);
              variables.button21State = true;
            } else {
              buttonIndexChanger(20, false);
              variables.button21State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button22Image)),
          ),
          onPressed: () {
            button22Image();
            if (variables.button22State == false) {
              buttonIndexChanger(21, true);
              variables.button22State = true;
            } else {
              buttonIndexChanger(21, false);
              variables.button22State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button23Image)),
          ),
          onPressed: () {
            button23Image();
            if (variables.button23State == false) {
              buttonIndexChanger(22, true);
              variables.button23State = true;
            } else {
              buttonIndexChanger(22, false);
              variables.button23State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button24Image)),
          ),
          onPressed: () {
            button24Image();
            if (variables.button24State == false) {
              buttonIndexChanger(23, true);
              variables.button24State = true;
            } else {
              buttonIndexChanger(23, false);
              variables.button24State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button25Image)),
          ),
          onPressed: () {
            button25Image();
            if (variables.button25State == false) {
              buttonIndexChanger(24, true);
              variables.button25State = true;
            } else {
              buttonIndexChanger(24, false);
              variables.button25State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button26Image)),
          ),
          onPressed: () {
            button26Image();
            if (variables.button26State == false) {
              buttonIndexChanger(25, true);
              variables.button26State = true;
            } else {
              buttonIndexChanger(25, false);
              variables.button26State = false;
            }
            buttonPressed();
          },
        ),
        TextButton(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: variables.button27Image)),
          ),
          onPressed: () {
            button27Image();
            if (variables.button27State == false) {
              buttonIndexChanger(26, true);
              variables.button27State = true;
            } else {
              buttonIndexChanger(26, false);
              variables.button27State = false;
            }
            buttonPressed();
          },
        ),
      ],
    ));
  }
}

const List<Widget> chargeToggle = <Widget>[
  Text('Enter Left'),
  Text('Docked'),
  Text('Engaged'),
  Text('Enter Right'),
];

const List<Widget> endgameToggle = <Widget>[
  Text('Outside Community'),
  Text('Inside Community'),
];

const List<Widget> chargingNumber = <Widget>[
  Text('0'),
  Text('1'),
  Text('2'),
  Text('3'),
];

class Endgame extends StatefulWidget {
  const Endgame({super.key});
  @override
  State<Endgame> createState() => EndgameState();
}

class EndgameState extends State<Endgame> {
  final List<bool> selectedCharge = <bool>[false, false, false, false];
  final List<bool> selectedEndgame = <bool>[true, false];
  final List<bool> selectedChargeNum = <bool>[true, false, false, false];

  final notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 600) {
      return narrowScreen(context);
    } else {
      return wideScreen(context);
    }
  }

  Scaffold narrowScreen(context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        title: const Text('Endgame'),
        actions: [
          Container(),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text('PLEASE TURN SCREEN HORIZONTAL'),
      ),
    );
  }

  Scaffold wideScreen(context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        title: const Text('Endgame'),
        actions: [
          TextButton(
            child: const Text(
              'Done',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              if (selectedCharge[0] && selectedCharge[2]) {
                variables.pageData[31] = 'left+engaged';
                //entered from left and docked
              } else if (selectedCharge[0] && selectedCharge[1]) {
                variables.pageData[31] = 'left+docked';
                //entered from left and engaged
              } else if (selectedCharge[0]) {
                variables.pageData[31] = 'left+failed';
                //entered from left and failed
              } else if (selectedCharge[3] && selectedCharge[2]) {
                variables.pageData[31] = 'right+engaged';
                //entered from right and docked
              } else if (selectedCharge[3] && selectedCharge[1]) {
                variables.pageData[31] = 'right+docked';
                //entered from right and docked
              } else if (selectedCharge[3]) {
                variables.pageData[31] = 'right+failed';
                //entered from right and failed
              } else if (selectedCharge[0] ||
                  selectedCharge[1] ||
                  selectedCharge[2] ||
                  selectedCharge[3]) {
                variables.pageData[31] = 'scouterError';
                //error on the scouters end
              } else {
                variables.pageData[31] = 'noCharging';
                //did not interact with charging station
              }

              if (selectedChargeNum[0]) {
                variables.pageData[32] = '0';
              } else if (selectedChargeNum[1]) {
                variables.pageData[32] = '1';
              } else if (selectedChargeNum[2]) {
                variables.pageData[32] = '2';
              } else if (selectedChargeNum[3]) {
                variables.pageData[32] = '3';
              }

              if (selectedEndgame[1]) {
                variables.pageData[33] = 'inside';
              } else {
                variables.pageData[33] = 'outside';
              }
              variables.pageData[34] = notesController.text;
              prefs.setPageDataSP(
                  variables.pageData[35], variables.pageData[36]);
              prefs.setFirebasePush();
              Future.delayed(const Duration(milliseconds: 250), () {
                try {
                  pushToFirebase();
                } on Error {
                  print("No Network");
                }
              }); //THIS IS A PUSH TO FIREBASE THAT WORKS YOU JUST HAVE TO DO IT ON LIVE SERVERS
              Future.delayed(const Duration(milliseconds: 500), () {
                resetAllData();
              });
              Navigator.popAndPushNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          mainAxisSpacing: (MediaQuery.of(context).size.height / 40),
          crossAxisCount: 2,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(children: <Widget>[
                const Text(
                  'ChargingStation',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      selectedCharge[index] = !selectedCharge[index];
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.purple[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.purple[200],
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: selectedCharge,
                  children: chargeToggle,
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                const Text(
                  'Bots on Charging Station',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < selectedChargeNum.length; i++) {
                        selectedChargeNum[i] = i == index;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.purple[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.purple[200],
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: selectedChargeNum,
                  children: chargingNumber,
                ),
              ]),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Finishing the Match',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                  ),
                  ToggleButtons(
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < selectedEndgame.length; i++) {
                          selectedEndgame[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.purple[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.purple[200],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 180.0,
                    ),
                    isSelected: selectedEndgame,
                    children: endgameToggle,
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                  ),
                  const Text(
                    'Match Notes',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(75, 0, 75, 0),
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextField(
                      minLines: 2,
                      maxLines: 4,
                      controller: notesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'NOTES',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PitPrep extends StatefulWidget {
  const PitPrep({super.key});
  @override
  State<PitPrep> createState() => PitPrepState();
}

class PitPrepState extends State<PitPrep> {
  final secretController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        title: const Text('Pit Prep'),
        actions: [
          Container(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Pit Scouting Code',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(75, 0, 75, 0),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: TextField(
              minLines: 1,
              maxLines: 1,
              controller: secretController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Secret Code!!',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
          ),
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 75, 156, 211)),
            child: TextButton(
              child: const Text(
                'Move on to Pit Scouting',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                prefs.setCodeToSP(secretController.text);
                Navigator.pushNamed(context, '/pit');
              },
            ),
          )
        ],
      ),
    );
  }
}

const List<Widget> driveTrainToggle = <Widget>[
  Text('West Coast'),
  Text('Swerve'),
  Text('Tank'),
  Text('Mecanum'),
];

const List<Widget> cargoToggle = <Widget>[
  Text('None'),
  Text('Cube'),
  Text('Cone'),
  Text('Both'),
];

const List<Widget> heightToggle = <Widget>[
  Text('None'),
  Text('Bottom'),
  Text('Middle'),
  Text('Top'),
];

const List<Widget> balanceToggle = <Widget>[
  Text('No'),
  Text('Yes'),
];

class Pit extends StatefulWidget {
  const Pit({super.key});
  @override
  State<Pit> createState() => PitState();
}

const List<String> widthPit = <String>[
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31',
  '32',
  '33',
  '34',
  '35',
  '36',
  '37',
  '38',
  '39',
  '40',
];

const List<String> heightPit = <String>[
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31',
  '32',
  '33',
  '34',
  '35',
  '36',
  '37',
  '38',
  '39',
  '40',
  '41',
  '42',
  '43',
  '44',
  '45',
  '46',
  '47',
  '48',
  '49',
  '50',
  '51',
  '52',
  '53',
  '54',
  '55',
  '56',
  '57',
  '58',
  '59',
  '60',
];

const List<String> weightPit = <String>[
  '80',
  '81',
  '82',
  '83',
  '84',
  '85',
  '86',
  '87',
  '88',
  '89',
  '90',
  '91',
  '92',
  '93',
  '94',
  '95',
  '96',
  '97',
  '98',
  '99',
  '100',
  '101',
  '102',
  '103',
  '104',
  '105',
  '106',
  '107',
  '108',
  '109',
  '110',
  '111',
  '112',
  '113',
  '114',
  '115',
  '116',
  '117',
  '118',
  '119',
  '120',
  '121',
  '122',
  '123',
  '124',
  '125',
];

class PitState extends State<Pit> {
  final List<bool> selectedDT = <bool>[true, false, false, false];
  final List<bool> selectedCargo = <bool>[true, false, false, false];
  final List<bool> selectedNodeHeight = <bool>[true, false, false, false];
  final List<bool> selectedBalance = <bool>[true, false];
  final numberController = TextEditingController();
  final notesController = TextEditingController();
  String dropdownValue = widthPit.first;
  String dropdown2Value = heightPit.first;
  String dropdown3Value = weightPit.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        title: const Text('Pit Scouting'),
        actions: [
          Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
            ),
            const Text(
              'Robot Number',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(75, 0, 75, 0),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: TextField(
                minLines: 1,
                maxLines: 1,
                controller: numberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Robot Number',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            const Text(
              'Drive Train',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < selectedDT.length; i++) {
                    selectedDT[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.purple[700],
              selectedColor: Colors.white,
              fillColor: Colors.purple[200],
              color: Colors.black,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: selectedDT,
              children: driveTrainToggle,
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            const Text(
              'Robot Dimensions',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('Width'),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: widthPit
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                Column(
                  children: [
                    Text('Height'),
                    DropdownButton<String>(
                      value: dropdown2Value,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdown2Value = value!;
                        });
                      },
                      items: heightPit
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                Column(
                  children: [
                    Text('Weight'),
                    DropdownButton<String>(
                      value: dropdown3Value,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdown3Value = value!;
                        });
                      },
                      items: weightPit
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            const Text(
              'Cones, Cubes, or something in between',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < selectedCargo.length; i++) {
                    selectedCargo[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.purple[700],
              selectedColor: Colors.white,
              fillColor: Colors.purple[200],
              color: Colors.black,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: selectedCargo,
              children: cargoToggle,
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            const Text(
              'How HIGH can you go?',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < selectedNodeHeight.length; i++) {
                    selectedNodeHeight[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.purple[700],
              selectedColor: Colors.white,
              fillColor: Colors.purple[200],
              color: Colors.black,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: selectedNodeHeight,
              children: heightToggle,
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            const Text(
              'Auto Balance?(Auto)',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < selectedBalance.length; i++) {
                    selectedBalance[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.purple[700],
              selectedColor: Colors.white,
              fillColor: Colors.purple[200],
              color: Colors.black,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: selectedBalance,
              children: balanceToggle,
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            const Text(
              'Team Freindliness and/or Notes',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(75, 0, 75, 0),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: TextField(
                minLines: 1,
                maxLines: 5,
                controller: notesController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Anything Extra Here',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Container(
              constraints: const BoxConstraints(
                minWidth: 100,
              ),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 75, 156, 211),
              ),
              child: TextButton(
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (selectedDT[0]) {
                    variables.pitData[0] = 'West Coast';
                  } else if (selectedDT[1]) {
                    variables.pitData[0] = 'Swerve';
                  } else if (selectedDT[2]) {
                    variables.pitData[0] = 'Tank';
                  } else if (selectedDT[3]) {
                    variables.pitData[0] = 'Mecanum';
                  }
                  variables.pitData[1] = dropdownValue;
                  variables.pitData[2] = dropdown2Value;
                  variables.pitData[3] = dropdown3Value;
                  if (selectedCargo[0]) {
                    variables.pitData[4] = 'None';
                  } else if (selectedCargo[1]) {
                    variables.pitData[4] = 'Cubes';
                  } else if (selectedCargo[2]) {
                    variables.pitData[4] = 'Cones';
                  } else if (selectedCargo[3]) {
                    variables.pitData[4] = 'Both';
                  }
                  if (selectedNodeHeight[0]) {
                    variables.pitData[5] = 'None';
                  } else if (selectedNodeHeight[1]) {
                    variables.pitData[5] = 'Bottom';
                  } else if (selectedNodeHeight[2]) {
                    variables.pitData[5] = 'Middle';
                  } else if (selectedNodeHeight[3]) {
                    variables.pitData[5] = 'Top';
                  }
                  if (selectedBalance[0]) {
                    variables.pitData[6] = 'No';
                  } else if (selectedBalance[1]) {
                    variables.pitData[6] = 'Yes';
                  }
                  variables.pitData[7] = notesController.text;
                  prefs.setPitScoutSP(numberController.text);
                  prefs.setPitScoutFB();
                  Future.delayed(const Duration(milliseconds: 500), () {
                    pitToFirebase();
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
          ],
        ),
      ),
    );
  }
}

class SScout extends StatefulWidget {
  const SScout({super.key});
  @override
  State<SScout> createState() => SScoutState();
}

const List<Widget> grip = <Widget>[
  Text('0'),
  Text('1'),
  Text('2'),
  Text('3'),
  Text('4'),
  Text('5'),
  Text('6'),
];

const List<Widget> mindset = <Widget>[
  Text('defense'),
  Text('offense'),
  Text('switch'),
];

class SScoutState extends State<SScout> {
  void buttonPressed() async {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  final List<bool> selectedGrip = <bool>[
    true,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  final List<bool> botMindset = <bool>[
    true,
    false,
    false,
  ];
  final numberController = TextEditingController();
  final notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        title: const Text('Super Scouting'),
        actions: [
          Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
            ),
            const Text(
              'Robot Number',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: TextField(
                minLines: 1,
                maxLines: 1,
                controller: numberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'ex.3824',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            const Text(
              'Grip Review',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < selectedGrip.length; i++) {
                    selectedGrip[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.purple[700],
              selectedColor: Colors.white,
              fillColor: Colors.purple[200],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 30.0,
              ),
              isSelected: selectedGrip,
              children: grip,
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Container(
              child: Text(
                'Bot Mindset',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < botMindset.length; i++) {
                    botMindset[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.purple[700],
              selectedColor: Colors.white,
              fillColor: Colors.purple[200],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 70.0,
              ),
              isSelected: botMindset,
              children: mindset,
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            const Text(
              'Notes',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: TextField(
                minLines: 1,
                maxLines: 6,
                controller: notesController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Notes',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 75, 156, 211)),
              child: TextButton(
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  for (var i = 0; i < 7; i++) {
                    if (selectedGrip[i] == true) {
                      variables.ssData[0] = i.toString();
                    }
                  }
                  if (botMindset[0] == true) {
                    variables.ssData[1] = 'defense';
                  } else if (botMindset[1] == true) {
                    variables.ssData[1] = 'offense';
                  } else {
                    variables.ssData[1] = 'switch';
                  }
                  variables.ssData[2] = notesController.text;
                  prefs.setSuperScoutSP(numberController.text);
                  prefs.setSSFB();
                  print(variables.firebaseSSPush);
                  Future.delayed(const Duration(milliseconds: 500), () {
                    ssToFirebase();
                    Navigator.pop(context);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Analytics extends StatefulWidget {
  const Analytics({super.key});
  @override
  State<Analytics> createState() => AnalyticsState();
}

class AnalyticsState extends State<Analytics> {
  void buttonPressed() async {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: const Color.fromARGB(255, 75, 156, 211),
        title: const Text('Analytics'),
        actions: [
          Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Robot Number',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: TextField(
                    minLines: 1,
                    maxLines: 1,
                    controller: numberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'ex.3824',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 75, 156, 211)),
                  child: TextButton(
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      variables.temprobotJson = await analytics
                          .returnRobotJson(numberController.text);
                      print(variables.temprobotJson);
                      buttonPressed();
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Drive Train -',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                Container(
                  width: 100,
                  child: Text(
                    variables.temprobotJson['driveTrain'].toString(),
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Average Cargo Pts -',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                Container(
                  width: 100,
                  child: Text(
                    variables.temprobotJson['pointsAverage'].toString(),
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Average Charge Pts -',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                Container(
                  width: 100,
                  child: Text(
                    variables.temprobotJson['chargingPoints'].toString(),
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Grip? -',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                Container(
                  width: 100,
                  child: Text(
                    variables.temprobotJson['gripper'].toString(),
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Offense/Defense -',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                Container(
                  width: 100,
                  child: Text(
                    variables.temprobotJson['mindset'].toString(),
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Cones/Cubes/Both -',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                Container(
                  width: 100,
                  child: Text(
                    variables.temprobotJson['cargoTypes'].toString(),
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

dynamic pageDataIndexToRobotNum(robotNum) async {
  variables.pageData[28] = robotNum.toString();
}

dynamic pageDataIndexToMatchNum(matchNum) async {
  variables.pageData[27] = matchNum.toString();
}

dynamic pitToFirebase() {
  print('firebasePitPush' + variables.firebasePitPush.runtimeType.toString());
  for (var j = 0; j < 9999; j++) {
    if (variables.firebasePitPush.containsKey('1492' + j.toString())) {
      print('firebasePitPush' +
          variables.firebasePitPush['1492' + j.toString()].runtimeType
              .toString());
      for (var i = 0;
          i < variables.firebasePitPush['1492' + j.toString()].length;
          i++) {
        DatabaseReference ref = FirebaseDatabase.instance
            .ref('SMR2023/' + j.toString() + '/pitData/' + i.toString() + '/');
        ref.set((variables.firebasePitPush['1492' + j.toString()][i]));
      }
    }
  }
}

dynamic ssToFirebase() {
  for (var j = 0; j < 9999; j++) {
    if (variables.firebaseSSPush.containsKey(j.toString())) {
      for (var i = 0; i < variables.firebaseSSPush[j.toString()].length; i++) {
        DatabaseReference ref = FirebaseDatabase.instance.ref(
            'SMR2023/' + j.toString() + '/superData/' + i.toString() + '/');
        ref.set((variables.firebaseSSPush[j.toString()][i]));
      }
    }
  }
}

dynamic pushToFirebase() {
  var index = 0;
  var jndex = 0;
  for (var i = index; i < 150; i++) {
    if (variables.firebasePush.containsKey(i.toString())) {
      for (var j = jndex; j < 9999; j++) {
        if (variables.firebasePush[i.toString()].containsKey(j.toString())) {
          DatabaseReference ref = FirebaseDatabase.instance
              .ref('SMR2023/' + j.toString() + '/' + i.toString() + '/');
          ref.set({
            'pageData': variables.firebasePush[i.toString()][j.toString()]
                ['pageData']
          });
        }
      }
    }
  }
  // try {
  //   final prefs = await SharedPreferences.getInstance();
  //   FirebaseDatabase database = FirebaseDatabase.instance;
  //   DatabaseReference ref = database.ref("2023/${variables.username}");
  // } on Error {
  //   print('something before this await happens wrong');
  // }
  // try {
  //   await ref.set({
  //     'information': (variables.pageData).toString(),
  //   });
  // } on Error {
  //   print('something happened somewhere else instead');
  // }

//   await ref.update({
//   "age": 19,
// });
// DatabaseReference ref = FirebaseDatabase.instance.ref("users");

// await ref.update({
//   "123/age": 19,
//   "123/address/line1": "1 Mountain View",
// });
}

dynamic resetAllData() async {
  final prefs = await SharedPreferences.getInstance();

  variables.buttonOneImage = variables.rodAlone;
  variables.buttonOneState = false;

  variables.buttonTwoImage = variables.platAlone;
  variables.buttonTwoState = false;

  variables.button3Image = variables.rodAlone;
  variables.button3State = false;

  variables.button4Image = variables.rodAlone;
  variables.button4State = false;

  variables.button5Image = variables.platAlone;
  variables.button5State = false;

  variables.button6Image = variables.rodAlone;
  variables.button6State = false;

  variables.button7Image = variables.rodAlone;
  variables.button7State = false;

  variables.button8Image = variables.platAlone;
  variables.button8State = false;

  variables.button9Image = variables.rodAlone;
  variables.button9State = false;

  variables.button10Image = variables.rodAlone;
  variables.button10State = false;

  variables.button11Image = variables.platAlone;
  variables.button11State = false;

  variables.button12Image = variables.rodAlone;
  variables.button12State = false;

  variables.button13Image = variables.rodAlone;
  variables.button13State = false;

  variables.button14Image = variables.platAlone;
  variables.button14State = false;

  variables.button15Image = variables.rodAlone;
  variables.button15State = false;

  variables.button16Image = variables.rodAlone;
  variables.button16State = false;

  variables.button17Image = variables.platAlone;
  variables.button17State = false;

  variables.button18Image = variables.rodAlone;
  variables.button18State = false;

  variables.button19Image = variables.floorAlone;
  variables.button19State = false;

  variables.button20Image = variables.floorAlone;
  variables.button20State = false;

  variables.button21Image = variables.floorAlone;
  variables.button21State = false;

  variables.button22Image = variables.floorAlone;
  variables.button22State = false;

  variables.button23Image = variables.floorAlone;
  variables.button23State = false;

  variables.button24Image = variables.floorAlone;
  variables.button24State = false;

  variables.button25Image = variables.floorAlone;
  variables.button25State = false;

  variables.button26Image = variables.floorAlone;
  variables.button26State = false;

  variables.button27Image = variables.floorAlone;
  variables.button27State = false;

  variables.pageData = [
    '0', //[0]
    '0', //[1]
    '0', //[2]
    '0', //[3]
    '0', //[4]
    '0', //[5]
    '0', //[6]
    '0', //[7]
    '0', //[8]
    '0', //[9]
    '0', //[10]
    '0', //[11]
    '0', //[12]
    '0', //[13]
    '0', //[14]
    '0', //[15]
    '0', //[16]
    '0', //[17]
    '0', //[18]
    '0', //[19]
    '0', //[20]
    '0', //[21]
    '0', //[22]
    '0', //[23]
    '0', //[24]
    '0', //[25]
    '0', //[26]
    'StartingPosition', //[27]
    'ChargingStationAuto', //[28]
    'Community', //[29]
    'AutoScoring', //[30]
    'ChargingStationEndgame', //[31]
    'BotsOnChargingStation', //[32]
    'InsideOrOutsideCommunity', //[33]
    'Notes', //[34]
    'MatchNum', //[35]
    'RobotNum', //[36]
    prefs.getString('username').toString(), //[37]
  ];
}

dynamic buttonOneImage() {
  if (variables.buttonOneState == false) {
    variables.buttonOneImage =
        const AssetImage('assets/images/thumbnail_rodcone.png');
  } else {
    variables.buttonOneImage =
        const AssetImage('assets/images/thumbnail_rod.png');
  }
}

dynamic buttonTwoImage() {
  if (variables.buttonTwoState == false) {
    variables.buttonTwoImage =
        const AssetImage('assets/images/thumbnail_platblock.png');
  } else {
    variables.buttonTwoImage =
        const AssetImage('assets/images/thumbnail_plat.png');
  }
}

dynamic button3Image() {
  if (variables.button3State == false) {
    variables.button3Image =
        const AssetImage('assets/images/thumbnail_rodcone.png');
  } else {
    variables.button3Image =
        const AssetImage('assets/images/thumbnail_rod.png');
  }
}

dynamic button4Image() {
  if (variables.button4State == false) {
    variables.button4Image =
        const AssetImage('assets/images/thumbnail_rodcone.png');
  } else {
    variables.button4Image =
        const AssetImage('assets/images/thumbnail_rod.png');
  }
}

dynamic button5Image() {
  if (variables.button5State == false) {
    variables.button5Image =
        const AssetImage('assets/images/thumbnail_platblock.png');
  } else {
    variables.button5Image =
        const AssetImage('assets/images/thumbnail_plat.png');
  }
}

dynamic button6Image() {
  if (variables.button6State == false) {
    variables.button6Image =
        const AssetImage('assets/images/thumbnail_rodcone.png');
  } else {
    variables.button6Image =
        const AssetImage('assets/images/thumbnail_rod.png');
  }
}

dynamic button7Image() {
  if (variables.button7State == false) {
    variables.button7Image =
        const AssetImage('assets/images/thumbnail_rodcone.png');
  } else {
    variables.button7Image =
        const AssetImage('assets/images/thumbnail_rod.png');
  }
}

dynamic button8Image() {
  if (variables.button8State == false) {
    variables.button8Image =
        const AssetImage('assets/images/thumbnail_platblock.png');
  } else {
    variables.button8Image =
        const AssetImage('assets/images/thumbnail_plat.png');
  }
}

dynamic button9Image() {
  if (variables.button9State == false) {
    variables.button9Image =
        const AssetImage('assets/images/thumbnail_rodcone.png');
  } else {
    variables.button9Image =
        const AssetImage('assets/images/thumbnail_rod.png');
  }
}

dynamic button10Image() {
  if (variables.button10State == false) {
    variables.button10Image =
        const AssetImage('assets/images/thumbnail_rodcone.png');
  } else {
    variables.button10Image =
        const AssetImage('assets/images/thumbnail_rod.png');
  }
}

dynamic button11Image() {
  if (variables.button11State == false) {
    variables.button11Image =
        const AssetImage('assets/images/thumbnail_platblock.png');
  } else {
    variables.button11Image =
        const AssetImage('assets/images/thumbnail_plat.png');
  }
}

dynamic button12Image() {
  if (variables.button12State == false) {
    variables.button12Image =
        const AssetImage('assets/images/thumbnail_rodcone.png');
  } else {
    variables.button12Image =
        const AssetImage('assets/images/thumbnail_rod.png');
  }
}

dynamic button13Image() {
  if (variables.button13State == false) {
    variables.button13Image =
        const AssetImage('assets/images/thumbnail_rodcone.png');
  } else {
    variables.button13Image =
        const AssetImage('assets/images/thumbnail_rod.png');
  }
}

dynamic button14Image() {
  if (variables.button14State == false) {
    variables.button14Image =
        const AssetImage('assets/images/thumbnail_platblock.png');
  } else {
    variables.button14Image =
        const AssetImage('assets/images/thumbnail_plat.png');
  }
}

dynamic button15Image() {
  if (variables.button15State == false) {
    variables.button15Image =
        const AssetImage('assets/images/thumbnail_rodcone.png');
  } else {
    variables.button15Image =
        const AssetImage('assets/images/thumbnail_rod.png');
  }
}

dynamic button16Image() {
  if (variables.button16State == false) {
    variables.button16Image =
        const AssetImage('assets/images/thumbnail_rodcone.png');
  } else {
    variables.button16Image =
        const AssetImage('assets/images/thumbnail_rod.png');
  }
}

dynamic button17Image() {
  if (variables.button17State == false) {
    variables.button17Image =
        const AssetImage('assets/images/thumbnail_platblock.png');
  } else {
    variables.button17Image =
        const AssetImage('assets/images/thumbnail_plat.png');
  }
}

dynamic button18Image() {
  if (variables.button18State == false) {
    variables.button18Image =
        const AssetImage('assets/images/thumbnail_rodcone.png');
  } else {
    variables.button18Image =
        const AssetImage('assets/images/thumbnail_rod.png');
  }
}

dynamic button19Image() {
  if (variables.button19State == false) {
    variables.button19Image =
        const AssetImage('assets/images/thumbnail_floor.png');
  } else {
    variables.button19Image =
        const AssetImage('assets/images/thumbnail_empty.png');
  }
}

dynamic button20Image() {
  if (variables.button20State == false) {
    variables.button20Image =
        const AssetImage('assets/images/thumbnail_floor.png');
  } else {
    variables.button20Image =
        const AssetImage('assets/images/thumbnail_empty.png');
  }
}

dynamic button21Image() {
  if (variables.button21State == false) {
    variables.button21Image =
        const AssetImage('assets/images/thumbnail_floor.png');
  } else {
    variables.button21Image =
        const AssetImage('assets/images/thumbnail_empty.png');
  }
}

dynamic button22Image() {
  if (variables.button22State == false) {
    variables.button22Image =
        const AssetImage('assets/images/thumbnail_floor.png');
  } else {
    variables.button22Image =
        const AssetImage('assets/images/thumbnail_empty.png');
  }
}

dynamic button23Image() {
  if (variables.button23State == false) {
    variables.button23Image =
        const AssetImage('assets/images/thumbnail_floor.png');
  } else {
    variables.button23Image =
        const AssetImage('assets/images/thumbnail_empty.png');
  }
}

dynamic button24Image() {
  if (variables.button24State == false) {
    variables.button24Image =
        const AssetImage('assets/images/thumbnail_floor.png');
  } else {
    variables.button24Image =
        const AssetImage('assets/images/thumbnail_empty.png');
  }
}

dynamic button25Image() {
  if (variables.button25State == false) {
    variables.button25Image =
        const AssetImage('assets/images/thumbnail_floor.png');
  } else {
    variables.button25Image =
        const AssetImage('assets/images/thumbnail_empty.png');
  }
}

dynamic button26Image() {
  if (variables.button26State == false) {
    variables.button26Image =
        const AssetImage('assets/images/thumbnail_floor.png');
  } else {
    variables.button26Image =
        const AssetImage('assets/images/thumbnail_empty.png');
  }
}

dynamic button27Image() {
  if (variables.button27State == false) {
    variables.button27Image =
        const AssetImage('assets/images/thumbnail_floor.png');
  } else {
    variables.button27Image =
        const AssetImage('assets/images/thumbnail_empty.png');
  }
}

dynamic buttonIndexChanger(buttonNumber, buttonstate) {
  if (buttonstate) {
    variables.pageData[buttonNumber] = '1';
  } else {
    variables.pageData[buttonNumber] = '0';
  }
}
