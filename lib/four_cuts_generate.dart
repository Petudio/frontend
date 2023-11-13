import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:petudio/four_cuts_result2.dart';
import 'package:petudio/four_cuts_settings.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(FourCutsGenerate());
}

class FourCutsGenerate extends StatefulWidget {
  const FourCutsGenerate({Key? key}) : super(key: key);

  @override
  State<FourCutsGenerate> createState() => _FourCutsGenerateState();
}

class _FourCutsGenerateState extends State<FourCutsGenerate> {
  final Map<int, String> imageMap = {};

  var bundleId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _generateButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> generateImage() async {
    const String baseUrl = 'http://10.0.2.2:8080/api/four-cuts/generate';
    bundleId = '1'; //TODO:input 받는걸로 변경해야함
    Map<String, String> params = {'bundleId': bundleId};

    // URL에 파라미터 추가
    Uri uri = Uri.parse(baseUrl).replace(queryParameters: params);

    final response = await http.get(uri);

    var data = jsonDecode(response.body);
    var bundle = data["data"];
    var pictures = bundle["pictures"];

    var l = pictures.length - 1;

    for (var i = 0; i < 4; i++) {
      var pictureS3Url = pictures[l]["pictureS3Url"];
      var section = pictures[l]["section"];
      imageMap[section] = pictureS3Url;
      l -= 1;
    }
    print("imageMap" + imageMap.toString());
  }

  // 화면 하단 버튼
  Widget _generateButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: ElevatedButton(
              onPressed: () async => {
                await generateImage(),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FourCutsResult2(imageMap: imageMap),
                  ),
                )
              },
              child: const Text('이미지 생성하기'),
            ),
          ),
        ],
      ),
    );
  }
}
