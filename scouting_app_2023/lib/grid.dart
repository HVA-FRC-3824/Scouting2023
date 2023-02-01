import 'package:flutter/material.dart';
import 'package:scouting_app_2023/variables.dart' as variables;
import 'package:scouting_app_2023/home.dart' as home;
import 'package:scouting_app_2023/main.dart' as dartmain;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void buttonPressed() {
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
        leading: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: const Text(
              'Back',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
        title: const Text('Grid Scout'),
        actions: [
          TextButton(
            child: const Text('Next Page',
                style: TextStyle(
                  color: Colors.white,
                )),
            onPressed: () {},
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return _buildWideContainers();
          } else {
            return _buildNormalContainer();
          }
        },
      ),
    );
  }

  Widget _buildWideContainers() {
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
              buttonIndexChanger(1, true);
              variables.buttonOneState = true;
            } else {
              buttonIndexChanger(1, false);
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
              buttonIndexChanger(2, true);
              variables.buttonTwoState = true;
            } else {
              buttonIndexChanger(2, false);
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
              buttonIndexChanger(3, true);
              variables.button3State = true;
            } else {
              buttonIndexChanger(3, false);
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
              buttonIndexChanger(4, true);
              variables.button4State = true;
            } else {
              buttonIndexChanger(4, false);
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
              buttonIndexChanger(5, true);
              variables.button5State = true;
            } else {
              buttonIndexChanger(5, false);
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
              buttonIndexChanger(6, true);
              variables.button6State = true;
            } else {
              buttonIndexChanger(6, false);
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
              buttonIndexChanger(7, true);
              variables.button7State = true;
            } else {
              buttonIndexChanger(7, false);
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
              buttonIndexChanger(8, true);
              variables.button8State = true;
            } else {
              buttonIndexChanger(8, false);
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
              buttonIndexChanger(9, true);
              variables.button9State = true;
            } else {
              buttonIndexChanger(9, false);
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
              buttonIndexChanger(10, true);
              variables.button10State = true;
            } else {
              buttonIndexChanger(10, false);
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
              buttonIndexChanger(11, true);
              variables.button11State = true;
            } else {
              buttonIndexChanger(11, false);
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
              buttonIndexChanger(12, true);
              variables.button12State = true;
            } else {
              buttonIndexChanger(12, false);
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
              buttonIndexChanger(13, true);
              variables.button13State = true;
            } else {
              buttonIndexChanger(13, false);
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
              buttonIndexChanger(14, true);
              variables.button14State = true;
            } else {
              buttonIndexChanger(14, false);
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
              buttonIndexChanger(15, true);
              variables.button15State = true;
            } else {
              buttonIndexChanger(15, false);
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
              buttonIndexChanger(16, true);
              variables.button16State = true;
            } else {
              buttonIndexChanger(16, false);
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
              buttonIndexChanger(17, true);
              variables.button17State = true;
            } else {
              buttonIndexChanger(17, false);
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
              buttonIndexChanger(18, true);
              variables.button18State = true;
            } else {
              buttonIndexChanger(18, false);
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
              buttonIndexChanger(19, true);
              variables.button19State = true;
            } else {
              buttonIndexChanger(19, false);
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
              buttonIndexChanger(20, true);
              variables.button20State = true;
            } else {
              buttonIndexChanger(20, false);
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
              buttonIndexChanger(21, true);
              variables.button21State = true;
            } else {
              buttonIndexChanger(21, false);
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
              buttonIndexChanger(22, true);
              variables.button22State = true;
            } else {
              buttonIndexChanger(22, false);
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
              buttonIndexChanger(23, true);
              variables.button23State = true;
            } else {
              buttonIndexChanger(23, false);
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
              buttonIndexChanger(24, true);
              variables.button24State = true;
            } else {
              buttonIndexChanger(24, false);
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
              buttonIndexChanger(25, true);
              variables.button25State = true;
            } else {
              buttonIndexChanger(25, false);
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
              buttonIndexChanger(26, true);
              variables.button26State = true;
            } else {
              buttonIndexChanger(26, false);
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
              buttonIndexChanger(27, true);
              variables.button27State = true;
            } else {
              buttonIndexChanger(27, false);
              variables.button27State = false;
            }
            buttonPressed();
          },
        ),
      ],
    ));
  }

  Widget _buildNormalContainer() {
    double screenWidth = MediaQuery.of(context).size.width;
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
    variables.pageData[buttonNumber] = true;
  } else {
    variables.pageData[buttonNumber] = false;
  }
}
