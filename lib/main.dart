import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:piano_game/piano_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterMidi = FlutterMidi();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PianoScreen(),
    );

  }

}