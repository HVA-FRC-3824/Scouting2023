import 'package:flutter/material.dart';
import 'package:scouting_app_2023/variables.dart' as variables;
import 'package:scouting_app_2023/main.dart' as dartmain;
import 'package:scouting_app_2023/grid.dart' as grid;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
    );
  }
}
