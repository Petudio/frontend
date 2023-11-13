import 'package:flutter/material.dart';
import 'package:petudio/four_cuts_options.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class FourCutsSettings extends StatefulWidget {
  final List<XFile?> pickedImages;

  // Add the pickedImages parameter to the constructor
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

  // void uploadimages() async {
  //   final url = Uri.parse('http://54.180.57.146:8080/api/fourcuts/upload');
  //   var request = http.MultipartRequest('POST', url);
  //   var _pickedImages = widget.pickedImages;
  //   for (var image in _pickedImages) {
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'beforePictures',
  //         image!.path,
  //       ),
  //     );
  //   }

  //   print(request);

  //   var response = await request.send();
  //   var responseData = await response.stream.bytesToString();
  //   print(responseData.split(":")[1]);

  //   //upload button
  // }

  Future<void> sendDataToServer() async {
    final url = Uri.parse(
        'http://10.0.2.2:8080/api/four-cuts/upload'); // 서버의 엔드포인트 주소로 변경해야 합니다.

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

    print("fields: " + request.fields.toString());

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    print(responseData.split(":")[1]);
    // 필요한 데이터를 Map에 담습니다.
    // Map<String, dynamic> requestData = {
    //   'pickedImages': widget.pickedImages.map((image) => image?.path).toList(),
    //   'selectedItemsMap': selectedItemsMap,
    //   'selectedBackgroundMap': selectedBackgroundMap,
    // };

    // try {
    //   final response = await http.post(
    //     url,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json',
    //     },
    //     body: jsonEncode(requestData),
    //   );

    //   if (response.statusCode == 200) {
    //     // 성공적으로 서버에 데이터를 보냈을 때의 로직
    //     print('Data sent successfully!');
    //   } else {
    //     // 서버로부터 오류 응답을 받았을 때의 처리
    //     print(
    //         'Failed to send data. Server responded with ${response.statusCode}');
    //   }
    // } catch (error) {
    //   // 오류가 발생했을 때의 처리
    //   print('Error: $error');
    // }
  }

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
                          // 구역 1을 선택한 경우, FourCutsOptions 화면으로 이동
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
                                  Text('배경: ${selectedBackgroundMap['구역 1']}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          // 구역 2를 선택한 경우, FourCutsOptions 화면으로 이동
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
                                  Text('배경: ${selectedBackgroundMap['구역 2']}'),
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
                          // 구역 3을 선택한 경우, FourCutsOptions 화면으로 이동
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
                                  Text('배경: ${selectedBackgroundMap['구역 3']}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          // 구역 4를 선택한 경우, FourCutsOptions 화면으로 이동
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
                                  Text('배경: ${selectedBackgroundMap['구역 4']}'),
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
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          print("만들기 버튼이 눌렸습니다.....");
          // "만들기" 버튼을 클릭할 때의 로직
          // 각 구역의 선택된 항목들에 대한 처리를 추가
          for (var entry in selectedItemsMap.entries) {
            print('${entry.key}: ${entry.value}');
          }
          // 각 구역의 선택된 배경에 대한 처리를 추가
          for (var entry in selectedBackgroundMap.entries) {
            print('${entry.key} 배경: ${entry.value}');
          }

          sendDataToServer();
          print("send complete");
        },
        child: Text('만들기'),
      ),
    );
  }
}
