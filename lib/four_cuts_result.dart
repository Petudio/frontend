import 'package:flutter/material.dart';

class FourCutsResult extends StatefulWidget {
  const FourCutsResult({Key? key}) : super(key: key);

  @override
  State<FourCutsResult> createState() => _FourCutsResultState();
}

class _FourCutsResultState extends State<FourCutsResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Petudio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          // Replace this GestureDetector with an Image
                          // Example: Image.asset('assets/11.png'),
                          // Adjust the asset path accordingly
                          print('Image 11 tapped');
                        },
                        child: Image.asset('assets/11.png'),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          // Replace this GestureDetector with an Image
                          // Example: Image.asset('assets/22.png'),
                          // Adjust the asset path accordingly
                          print('Image 22 tapped');
                        },
                        child: Image.asset('assets/22.png'),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          // Replace this GestureDetector with an Image
                          // Example: Image.asset('assets/33.png'),
                          // Adjust the asset path accordingly
                          print('Image 33 tapped');
                        },
                        child: Image.asset('assets/33.png'),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          // Replace this GestureDetector with an Image
                          // Example: Image.asset('assets/44.png'),
                          // Adjust the asset path accordingly
                          print('Image 44 tapped');
                        },
                        child: Image.asset('assets/44.png'),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset('assets/Logo_of_Petudio_removebg.png'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          // Replace this onPressed logic if needed
          print("다운로드드 버튼이 눌렸습니다.....");
        },
        child: Text('다운로드'),
      ),
    );
  }
}
