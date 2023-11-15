import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/rendering.dart';

class FourCutsResult extends StatefulWidget {
  final Map<int, String>
      imageMap; //{4:image4Url, 3:image3Url, 2:image2Url, 1:image1Url}

  const FourCutsResult({Key? key, required this.imageMap}) : super(key: key);

  @override
  State<FourCutsResult> createState() => _FourCutsResultState();
}

class _FourCutsResultState extends State<FourCutsResult> {
  GlobalKey _globalKey = GlobalKey();

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
      body: Container(
        margin: const EdgeInsets.all(10.0), // Add margin here
        child: RepaintBoundary(
          key: _globalKey,
          child: Container(
            height: 490,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Image.network(
                            widget.imageMap[1]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Image.network(
                            widget.imageMap[2]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Image.network(
                            widget.imageMap[3]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Image.network(
                            widget.imageMap[4]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Image.asset('assets/Logo_of_Petudio_removebg.png'),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(100, 10, 100, 40),
        child: ElevatedButton(
          onPressed: () async {
            await _captureAndSave();
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(100, 70)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(100.0), // Adjust the value as needed
              ),
            ),
          ),
          child: Text('다운로드'),
        ),
      ),
    );
  }

  Future<void> _captureAndSave() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        final result = await ImageGallerySaver.saveImage(pngBytes);

        if (result != null) {
          print("이미지 저장 성공: $result");
        } else {
          print("이미지 저장 실패");
        }
      } else {
        print("이미지를 ByteData로 변환할 수 없습니다.");
      }
    } catch (e) {
      print("이미지 저장 중 오류 발생: $e");
    }
  }
}
