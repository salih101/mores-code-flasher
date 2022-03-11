import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

Map timimg = {'-': 300, '.': 100, ' ': 0};
Map mapper = {
  'a': '.-',
  'b': '-...',
  'c': '-.-.',
  'd': '-..',
  'e': '.',
  'f': '..-.',
  'g': '--.',
  'h': '....',
  'i': '..',
  'j': '.---',
  'k': '-.-',
  'l': '.-..',
  'm': '--',
  'n': '-.',
  'o': '---',
  'p': '.--.',
  'q': '--.-',
  'r': '.-.',
  's': '...',
  't': '-',
  'u': '..-',
  'v': '...-',
  'w': '.--',
  'x': '-..-',
  'y': '-.--',
  'z': '--..',
  ' ': '     '
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController texty = new TextEditingController();

  String code = '';

  void encoder() {
    setState(() {
      String temp = texty.text.toLowerCase();
      code = '';
      for (int i = 0; i < temp.length; i++) {
        code += mapper[temp[i]] + ' ';
      }
    });
  }

  void torch() {
    for (int i = 0; i < code.length - 1; i++) {
      int time = timimg[code[i]];
      time > 0 ? TorchLight.enableTorch() : 1;
      sleep(Duration(milliseconds: time));
      TorchLight.disableTorch();
      sleep(Duration(milliseconds: 100));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Morse code Flasher'),
      ),
      body: Column(children: <Widget>[
        TextField(
          controller: texty,
        ),
        RaisedButton(
            onPressed: encoder,
            child: Text(
              "Convert To Morse Code",
            )),
        Text(
          code,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                onPressed: torch,
                child: Text(
                  "RUN",
                ))
          ],
        )
      ]),
    );
  }
}
