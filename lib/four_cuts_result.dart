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
  Color _backgroundColor = Colors.blue; // Initial background color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Petudio'),
      ),
      body: Column(
        children: [
          RepaintBoundary(
            key: _globalKey,
            child: Container(
              height: 490,
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: _backgroundColor, // Use _backgroundColor here
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
                  Image.asset(
                    'assets/Logo_of_Petudio_removebg.png',
                    width: 200, // Adjust the width as needed
                    height: 90,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularButton(
                color: Colors.red,
                onPressed: (Color color) {
                  setState(() {
                    _backgroundColor = color; // Update the background color
                  });
                },
              ),
              CircularButton(
                color: Colors.orange,
                onPressed: (Color color) {
                  setState(() {
                    _backgroundColor = color; // Update the background color
                  });
                },
              ),
              CircularButton(
                color: Colors.yellow,
                onPressed: (Color color) {
                  setState(() {
                    _backgroundColor = color; // Update the background color
                  });
                },
              ),
              CircularButton(
                color: Colors.green,
                onPressed: (Color color) {
                  setState(() {
                    _backgroundColor = color; // Update the background color
                  });
                },
              ),
              CircularButton(
                color: Colors.blue,
                onPressed: (Color color) {
                  setState(() {
                    _backgroundColor = color; // Update the background color
                  });
                },
              ),
              CircularButton(
                color: Colors.indigo,
                onPressed: (Color color) {
                  setState(() {
                    _backgroundColor = color; // Update the background color
                  });
                },
              ),
              CircularButton(
                color: Colors.purple,
                onPressed: (Color color) {
                  setState(() {
                    _backgroundColor = color; // Update the background color
                  });
                },
              ),
            ],
          ),
        ],
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
                borderRadius: BorderRadius.circular(100.0),
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

class CircularButton extends StatelessWidget {
  final Color color;
  final Function(Color) onPressed; // Add onPressed callback

  CircularButton({required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(color); // Call the onPressed callback
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
