import 'package:flutter/material.dart';
import 'package:story_flakes/data/branch.dart';

class ConnectionEditingPage extends StatefulWidget {
  final Branch branch;
  final int index;

  const ConnectionEditingPage({super.key, required this.branch, required this.index});

  @override
  State<ConnectionEditingPage> createState() => _ConnectionEditingPageState();
}

class _ConnectionEditingPageState extends State<ConnectionEditingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Connections")),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
