import 'dart:async';
import 'package:flutter/material.dart';
import 'package:petudio/four_cuts.dart';
import 'package:petudio/four_cuts_settings.dart';

void main() {
  runApp(const MainApp(bundleId: ''));
}

class MainApp extends StatelessWidget {
  final String bundleId;

  const MainApp({super.key, required this.bundleId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "petudio",
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: MyHomePage(bundleId: bundleId),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String bundleId;

  const MyHomePage({super.key, required this.bundleId});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Set up an automatic timer to slide images every 2 seconds
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentIndex < 3) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petudio'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: PageView(
                controller: _pageController,
                children: [
                  _buildRoundedImage("assets/result1.jpg"),
                  _buildRoundedImage("assets/result2.jpg"),
                  _buildRoundedImage("assets/result3.jpg"),
                  _buildRoundedImage("assets/result4.jpg"),
                ],
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            SizedBox(
                height: 20), // Add some space between the image and buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FourCuts()),
                );
              },
              child: Text('만들러 가기'),
            ),
            SizedBox(height: 10), // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FourCutsSettings(bundleId: widget.bundleId),
                  ),
                );
              },
              child: Text('만든 이미지 받기'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }
}
