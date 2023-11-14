import 'package:flutter/material.dart';
import 'package:petudio/four_cuts_options.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petudio/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FourCutsSettings extends StatefulWidget {
  final List<XFile?> pickedImages;

  const FourCutsSettings({Key? key, required this.pickedImages})
      : super(key: key);

  @override
  State<FourCutsSettings> createState() => _FourCutsSettingsState();
}

class _FourCutsSettingsState extends State<FourCutsSettings> {
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

  String selectedPet = '강아지'; // Default selection

  Future<void> sendDataToServer() async {
    final url = Uri.parse('http://10.0.2.2:8080/api/four-cuts/upload');
    var request = http.MultipartRequest('POST', url);
    var _pickedImages = widget.pickedImages;
    for (var image in _pickedImages) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'beforePictures',
          image!.path,
        ),
      );
    }
    request.fields['selectedItems'] = jsonEncode(selectedItemsMap);
    request.fields['selectedBackground'] = jsonEncode(selectedBackgroundMap);
    request.fields['selectedPet'] = selectedPet; // Add selectedPet field

    print("fields: " + request.fields.toString());

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    print(responseData.split(":")[1]);
  }

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
                  value: '강아지',
                  groupValue: selectedPet,
                  onChanged: (value) {
                    setState(() {
                      selectedPet = value.toString();
                    });
                  },
                ),
                Text('강아지'),
                Radio(
                  value: '고양이',
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
                                    builder: (context) => MainApp(),
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
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          await _showLoadingDialog(context);

          print("Upload button pressed...");
          for (var entry in selectedItemsMap.entries) {
            print('${entry.key}: ${entry.value}');
          }
          for (var entry in selectedBackgroundMap.entries) {
            print('${entry.key} 배경: ${entry.value}');
          }

          await sendDataToServer();
          print("Send complete");

          Navigator.of(context, rootNavigator: true).pop();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainApp(),
            ),
          );
        },
        child: Text('Upload'),
      ),
    );
  }
}
