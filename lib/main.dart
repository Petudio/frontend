import 'dart:async';
import 'package:flutter/material.dart';
import 'package:petudio/four_cuts.dart';
import 'package:petudio/four_cuts_settings.dart';

void main() {
  runApp(const MainApp(bundleId: ''));
}

class MainApp extends StatelessWidget {
  final String bundleId;
  const MainApp({Key? key, required this.bundleId}) : super(key: key);

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

  const MyHomePage({Key? key, required this.bundleId}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController =
      PageController(viewportFraction: 0.85); // Added viewportFraction

  @override
  void initState() {
    super.initState();
    // Set up an automatic timer to slide images every 2 seconds
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentIndex < 31) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 50),
        curve: Curves.easeInOut,
      );
    });
  }

  Widget _buildRoundedImage(int index) {
    String imagePath = "assets/result${index + 1}.jpg";

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
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
              child: PageView.builder(
                controller: _pageController,
                itemCount: 32,
                itemBuilder: (context, index) {
                  return Transform.scale(
                    scale: 1.0 - (index - _currentIndex).abs() * 0.1,
                    child: _buildRoundedImage(index),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FourCuts()),
                  );
                },
                child: Text('만들러 가기'),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
