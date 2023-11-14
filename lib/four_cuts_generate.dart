import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:petudio/four_cuts_result.dart';

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

  late TextEditingController _controller; // Controller for the input field

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _generateInputField(),
              const SizedBox(
                  height:
                      10), // Add some space between the input field and button
              _generateButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _generateInputField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Bundle ID', // Change the label as needed
        ),
      ),
    );
  }

  Future<bool> generateImage() async {
    const String baseUrl = 'http://10.0.2.2:8080/api/four-cuts/generate';
    var bundleId = _controller.text;

    Map<String, String> params = {'bundleId': bundleId};

    // URL에 파라미터 추가
    Uri uri = Uri.parse(baseUrl).replace(queryParameters: params);

    final response = await http.get(uri);

    var data = jsonDecode(response.body);
    var bundle = data["data"];
    if (bundle == "Training is not yet complete") {
      return false;
    }
    var pictures = bundle["pictures"];

    var l = pictures.length - 1;

    for (var i = 0; i < 4; i++) {
      var pictureS3Url = pictures[l]["pictureS3Url"];
      var section = pictures[l]["section"];
      imageMap[section] = pictureS3Url;
      l -= 1;
    }
    print("imageMap" + imageMap.toString());
    return true;
  }

  // 화면 하단 버튼
  Widget _generateButtons() {
    bool status;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: ElevatedButton(
              onPressed: () async {
                status = await generateImage();
                print("status: " + status.toString());
                if (status) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FourCutsResult(),
                    ),
                  );
                } else {
                  print("not training yet");
                  //Toast message
                }
              },
              child: const Text('이미지 생성하기'),
            ),
          ),
        ],
      ),
    );
  }
}
