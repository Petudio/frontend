import 'package:flutter/material.dart';
import 'package:petudio/four_cuts.dart';
import 'package:petudio/making_juniors.dart';
import 'package:petudio/pet_to_human.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "petudio",
      theme: ThemeData(
        primarySwatch : Colors.yellow
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petudio'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding : const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: <Widget>[
           
             InkWell(
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>const FourCuts())
                );
              },
              child : 
            Image.asset("assets/fourcuts_word.jpg"),
            ),
          ],
        )),
    );
  }
}