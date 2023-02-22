import 'package:flutter/material.dart';
import 'package:scouting_app_2023/variables.dart' as variables;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scouting_app_2023/sharedPrefs.dart' as prefs;

bool authState = false;

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
      },
    ),
  );

  prefs.setFirebasePush();
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
  //     print('User is currently signed out!');
  //     authState = false;
  //   } else {
  //     authState = true;
  //     print('User is signed in!');
  //   }
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
                  variables.pageData[29] = usernameController.text;
                  variables.password = passwordController.text;
                  prefs.setStringSP('username', usernameController.text);
                  signIntoAccount(
                      usernameController.text, passwordController.text);
                  FirebaseAuth.instance.authStateChanges().listen((User? user) {
                    if (user == null) {
                      print('User is currently signed out!');
                      authState = false;
                    } else {
                      authState = true;

                      Navigator.pushNamed(context, '/');
                      print('User is signed in!');
                    }
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
                child: TextButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.grey),
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
            ),
          ],
        ),
      ),
    );
  }
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
                    usernameController.text,
                    passwordController.text,
                  );
                  signIntoAccount(
                      usernameController.text, passwordController.text);
                  //authState = true;
                  //Navigator.pushNamed(context, '/');
                  variables.pageData[29] = usernameController.text;
                  variables.password = passwordController.text;
                  prefs.setStringSP('username', usernameController.text);
                  FirebaseAuth.instance.authStateChanges().listen((User? user) {
                    if (user == null) {
                      print('User is currently signed out!');
                      authState = false;
                    } else {
                      authState = true;

                      Navigator.pushNamed(context, '/');
                      print('User is signed in!');
                    }
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: TextButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.grey),
                  ),
                  child: Container(
                    margin:
                        EdgeInsets.all(MediaQuery.of(context).size.height / 50),
                    child: const Text('Sign In?'),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var tempState;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (authState == false) {
        print("user got signed out");
        tempState = false;
      } else if (authState == true) {
        print("user got signed in");
        tempState = true;
      }
    });
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .10,
        backgroundColor: Colors.purple,
        leading: Container(),
        title: const Text('Home'),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (tempState == true) {
          return buildNormalHome(context);
        } else if (tempState == false) {
          return loginScreen(context);
        }
        return buildNormalHome(context);
      }),
    );
  }

  Widget loginScreen(context) {
    var textSize = ((MediaQuery.of(context).size.height / 2) *
            (MediaQuery.of(context).size.width) /
            5) /
        40;
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
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Colors.black,
                    Colors.purple,
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * .2),
            color: Colors.black,
            child: TextButton(
              // Within the `FirstScreen` widget
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/prep');
              },
              child: Text(
                'Scouting Page',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (textSize / 40),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * .2),
            color: Colors.red,
            child: TextButton(
              // Within the `FirstScreen` widget
              onPressed: () {},
              child: Text(
                'Schedule Page',
                style: TextStyle(
                  fontSize: (textSize / 40),
                ),
              ),
            ),
          ),
        ],
      ),
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
                  variables.pageData[27] = matchNumberController.text;
                  variables.pageData[28] = robotNumberController.text;
                  Navigator.pushNamed(context, '/grid');
                },
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
        backgroundColor: Colors.purple,
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
              prefs.setPageDataSP(
                  variables.pageData[27], variables.pageData[28]);
              prefs.setFirebasePush();
              Future.delayed(const Duration(milliseconds: 300), () {
                pushToFirebase();
              }); //THIS IS A PUSH TO FIREBASE THAT WORKS YOU JUST HAVE TO DO IT ON LIVE SERVERS
              var times = 0;
              while (times < 10) {
                print("looping while loop");
                Future.delayed(const Duration(milliseconds: 1000), () {
                  print("this is not running");
                  if (firebasePushVar == 1) {
                    resetAllData();
                    times = 11;
                  }
                });

                times = times + 1;
              }
              buttonPressed();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return wideContainer();
          } else {
            return _buildNormalContainer();
          }
        },
      ),
    );
  }

  Widget _buildNormalContainer() {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.red),
        child: const Text("Please Turn Horizontal"),
      ),

      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Invoke "debug painting" (press "p" in the console, choose the
      //     // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //     // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //     // to see the wireframe for each widget.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have clicked the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add), // Ths trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget wideContainer() {
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

dynamic pageDataIndexToRobotNum(robotNum) async {
  variables.pageData[28] = robotNum.toString();
}

dynamic pageDataIndexToMatchNum(matchNum) async {
  variables.pageData[27] = matchNum.toString();
}

var firebasePushVar = 0;
dynamic pushToFirebase() {
  var index = 0;
  var jndex = 0;
  for (var i = index; i < 150; i++) {
    if (variables.firebasePush.containsKey(i.toString())) {
      for (var j = jndex; j < 9999; j++) {
        if (variables.firebasePush[i.toString()].containsKey(j.toString())) {
          print('this function ran');
          DatabaseReference ref = FirebaseDatabase.instance
              .ref('2023/' + i.toString() + '/' + j.toString() + '/');
          ref.set({
            'pageData': variables.firebasePush[i.toString()][j.toString()]
                ['pageData']
          });
        }
      }
    }
  }
  firebasePushVar = 1;
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

dynamic signIntoAccount(emailAddress, password) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    print(credential);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

dynamic createAccount(emailAddress, password) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress.toString(),
      password: password.toString(),
    );
    print(credential);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

//AUTHENTICATION

//HOW TO DO THIS BELOW https://firebase.google.com/docs/database/flutter/read-and-write

// void getPageDataSP() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
// }

dynamic resetAllData() async {
  firebasePushVar = 0;

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
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    '0',
    'MatchNum',
    'RobotNum',
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
