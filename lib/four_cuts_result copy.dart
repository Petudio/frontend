import 'package:flutter/material.dart';

class FourCutsResult extends StatelessWidget {
  const FourCutsResult({Key? key, required this.imageMap1}) : super(key: key);

  final Map<int, String> imageMap1;

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
            color: Colors.blue,
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Image.network(
                        imageMap1[1]!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Image.network(
                        imageMap1[2]!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Image.network(
                        imageMap1[3]!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Image.network(
                        imageMap1[4]!,
                        fit: BoxFit.cover,
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
          print("다운로드 버튼이 눌렸습니다.....");
        },
        child: Text('다운로드'),
      ),
    );
  }
}
