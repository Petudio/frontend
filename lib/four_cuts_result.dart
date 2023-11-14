import 'package:flutter/material.dart';

class FourCutsResult extends StatefulWidget {
  final Map<int, String>
      imageMap; //{4:image4Url, 3:image3Url, 2:image2Url, 1:image1Url}

  const FourCutsResult({Key? key, required this.imageMap}) : super(key: key);

  @override
  State<FourCutsResult> createState() => _FourCutsResultState();
}

class _FourCutsResultState extends State<FourCutsResult> {
  // Define your image URLs in the map
  // 테스트용
  // final Map<int, String> imageMap1 = {
  //   4: "https://petudio-bucket.s3.ap-northeast-2.amazonaws.com/ca6e6119-fa37-4518-b854-f91e1afcc48d.PNG",
  //   3: "https://petudio-bucket.s3.ap-northeast-2.amazonaws.com/1729cd65-ed0b-4428-af89-997cd05c4139.PNG",
  //   2: "https://petudio-bucket.s3.ap-northeast-2.amazonaws.com/1729cd65-ed0b-4428-af89-997cd05c4139.PNG",
  //   1: "https://petudio-bucket.s3.ap-northeast-2.amazonaws.com/1729cd65-ed0b-4428-af89-997cd05c4139.PNG",
  // };

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
                        widget.imageMap[4]!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Image.network(
                        widget.imageMap[3]!,
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
                        widget.imageMap[2]!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Image.network(
                        widget.imageMap[1]!,
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
