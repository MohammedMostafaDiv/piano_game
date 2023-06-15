import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:piano/piano.dart';
import 'package:url_launcher/url_launcher.dart';

class PianoScreen extends StatefulWidget {
  const PianoScreen({Key? key}) : super(key: key);

  @override
  State<PianoScreen> createState() => _PianoScreenState();
}

class _PianoScreenState extends State<PianoScreen> {
  FlutterMidi flutterMidi = FlutterMidi();

  String? newValue;

  @override
  void initState() {
    load('assets/Guitars.sf2');
    super.initState();
  }

  void load(String asset) async {
    flutterMidi.unmute(); // Optionally Unmute
    ByteData _byte = await rootBundle.load(asset);
    flutterMidi.prepare(sf2: _byte);
  }

  @override
  Widget build(BuildContext context) {
     Uri? uri;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Music",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.black12,
          centerTitle: true,
          leadingWidth: 100,
          leading: Padding(
            padding:  EdgeInsets.only(left: 8),
            child: DropdownButton(
                value: newValue ?? "Guitars",
                items: const [
                  DropdownMenuItem<String?>(
                    child: Text("Guitars"),
                    value: "Guitars",
                  ),
                  DropdownMenuItem<String?>(
                    child: Text("Strings"),
                    value: "Strings",
                  ),
                  DropdownMenuItem<String?>(
                    child: Text("Piano"),
                    value: "Yamaha-Grand",
                  )
                ],
                onChanged: (value) {
                  setState(() {
                    newValue = value;
                  },);
                  load("assets/$newValue.sf2");
                }),
          ),
          actions: [
            IconButton(
              onPressed: () {
                uri = Uri.parse("tel: +972592678413");
                launchUrl(uri!);
              },
              icon: Icon(Icons.call),
            ),
            IconButton(
              onPressed: () {
                uri = Uri.parse("sms: +972592678413");
                launchUrl(uri!);
              },
              icon: Icon(Icons.sms),
            ),
            IconButton(
              onPressed: () {
                uri = Uri.parse("mailto: mohmos12300852@gmail.com");
                launchUrl(uri!);
              },
              icon: Icon(Icons.email),
            ),
            IconButton(
              onPressed: () {
                uri = Uri.parse("https://www.google.com");
                launchUrl(uri! , mode: LaunchMode.externalNonBrowserApplication);
              },
              icon: Icon(Icons.info),
            ),
          ],
        ),
        body: Center(
          child: InteractivePiano(
            highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
            naturalColor: Colors.white,
            accidentalColor: Colors.black,
            keyWidth: 60,
            noteRange: NoteRange.forClefs(
              [
                Clef.Treble,
              ],
            ),
            onNotePositionTapped: (position) {
              // Use an audio library like flutter_midi to play the sound
              flutterMidi.playMidiNote(midi: position.pitch);
            },
          ),
        ));
  }
}
