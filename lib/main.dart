import 'package:flutter/material.dart';
import 'package:petudio/four_cuts.dart';
import 'package:petudio/four_cuts_generate.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "petudio",
      theme: ThemeData(primarySwatch: Colors.yellow),
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
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: <Widget>[
            InkWell(
              child: Image.asset("assets/fourcuts_word.jpg"),
            ),
            SizedBox(
                height: 20), // Add some space between the image and buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FourCuts()));
              },
              child: Text('만들러 가기'),
            ),
            SizedBox(height: 10), // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FourCutsGenerate()));
              },
              child: Text('만든 이미지 받기'),
            ),
          ],
        ),
      ),
    );
  }
}
