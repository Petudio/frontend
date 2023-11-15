import 'package:flutter/material.dart';
import 'package:petudio/four_cuts_options.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petudio/four_cuts_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FourCutsSettings extends StatefulWidget {
  final String bundleId;
  final Map<int, String> imageMap = {};

  FourCutsSettings({Key? key, required this.bundleId}) : super(key: key);

  @override
  State<FourCutsSettings> createState() => _FourCutsSettingsState();
}

class _FourCutsSettingsState extends State<FourCutsSettings> {
  String animalType = '';

  Map<String, List<String>> selectedItemsMap = {
    '구역 1': [],
    '구역 2': [],
    '구역 3': [],
    '구역 4': [],
  };
  Map<String, String?> selectedBackgroundMap = {
    '구역 1': null,
    '구역 2': null,
    '구역 3': null,
    '구역 4': null,
  };

  String selectedPet = ''; // Default selection
  TextEditingController bundleIdController = TextEditingController();

  Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 50, height: 100),
              Text("기다려주세요\n만드는 중입니다\n(최대 4분)"),
            ],
          ),
        );
      },
    );
  }

  Future<bool> generateImage(var tempBundleId) async {
    const String baseUrl = 'http://54.180.57.146:8080/api/four-cuts/generate';

    Map<String, String> params = {'bundleId': tempBundleId};

    // URL에 파라미터 추가
    Uri uri = Uri.parse(baseUrl).replace(queryParameters: params);
    var request = http.MultipartRequest('Post', uri);
    request.fields['selectedItems'] = jsonEncode(selectedItemsMap);
    request.fields['selectedBackground'] = jsonEncode(selectedBackgroundMap);
    request.fields['animalType'] = animalType;

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonData = jsonDecode(responseData);
    var bundle = jsonData["data"];

    if (bundle == "Training is not yet complete") {
      return false;
    }

    var pictures = bundle["pictures"];

    var l = pictures.length - 1;

    for (var i = 0; i < 4; i++) {
      var pictureS3Url = pictures[l]["pictureS3Url"];
      var section = pictures[l]["section"];
      widget.imageMap[section] = pictureS3Url;
      l -= 1;
    }
    print("imageMap" + widget.imageMap.toString());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Petudio'),
      ),
      body: Column(
        children: [
          // Radio buttons for selecting pet type
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'dog',
                  groupValue: selectedPet,
                  onChanged: (value) {
                    setState(() {
                      selectedPet = value.toString();
                    });
                  },
                ),
                Text('강아지'),
                Radio(
                  value: 'cat',
                  groupValue: selectedPet,
                  onChanged: (value) {
                    setState(() {
                      selectedPet = value.toString();
                    });
                  },
                ),
                Text('고양이'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FourCutsOptions(),
                                  ),
                                );
                                if (result != null) {
                                  setState(() {
                                    selectedItemsMap['구역 1'] = result['items'];
                                    selectedBackgroundMap['구역 1'] =
                                        result['background'];
                                  });
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10.0),
                                color: Colors.white,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('구역 1\n${selectedItemsMap['구역 1']}'),
                                      if (selectedBackgroundMap['구역 1'] != null)
                                        Text(
                                            '배경: ${selectedBackgroundMap['구역 1']}'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FourCutsOptions(),
                                  ),
                                );
                                if (result != null) {
                                  setState(() {
                                    selectedItemsMap['구역 2'] = result['items'];
                                    selectedBackgroundMap['구역 2'] =
                                        result['background'];
                                  });
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10.0),
                                color: Colors.white,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('구역 2\n${selectedItemsMap['구역 2']}'),
                                      if (selectedBackgroundMap['구역 2'] != null)
                                        Text(
                                            '배경: ${selectedBackgroundMap['구역 2']}'),
                                    ],
                                  ),
                                ),
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
                            child: GestureDetector(
                              onTap: () async {
                                var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FourCutsOptions(),
                                  ),
                                );
                                if (result != null) {
                                  setState(() {
                                    selectedItemsMap['구역 3'] = result['items'];
                                    selectedBackgroundMap['구역 3'] =
                                        result['background'];
                                  });
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10.0),
                                color: Colors.white,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('구역 3\n${selectedItemsMap['구역 3']}'),
                                      if (selectedBackgroundMap['구역 3'] != null)
                                        Text(
                                            '배경: ${selectedBackgroundMap['구역 3']}'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FourCutsOptions(),
                                  ),
                                );
                                if (result != null) {
                                  setState(() {
                                    selectedItemsMap['구역 4'] = result['items'];
                                    selectedBackgroundMap['구역 4'] =
                                        result['background'];
                                  });
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10.0),
                                color: Colors.white,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('구역 4\n${selectedItemsMap['구역 4']}'),
                                      if (selectedBackgroundMap['구역 4'] != null)
                                        Text(
                                            '배경: ${selectedBackgroundMap['구역 4']}'),
                                    ],
                                  ),
                                ),
                              ),
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
          ),
          // TextField for entering bundleId
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: bundleIdController,
              decoration: InputDecoration(
                labelText: 'Enter bundle Id',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: (selectedPet != null &&
                selectedBackgroundMap.values
                    .every((background) => background != null))
            ? () async {
                _showLoadingDialog(context);

                print("Upload button pressed...");
                for (var entry in selectedItemsMap.entries) {
                  print('${entry.key}: ${entry.value}');
                }
                for (var entry in selectedBackgroundMap.entries) {
                  print('${entry.key} 배경: ${entry.value}');
                }
                var tempBundleId = '1'; // 입력 값으로 바꿔야함
                bool status = await generateImage(tempBundleId);
                print("Send complete");
                Navigator.of(context, rootNavigator: true).pop();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FourCutsResult(imageMap: widget.imageMap),
                  ),
                );
              }
            : null, // Set onPressed to null when conditions are not met//화면 테스트용
        // onPressed: () {
        //   print("생성하기 버튼");
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => FourCutsResult(imageMap: widget.imageMap),
        //     ),
        //   );
        // },
        child: Text('생성하기'),
      ),
    );
  }
}
