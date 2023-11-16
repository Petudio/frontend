import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petudio/four_cuts_result.dart';
import 'package:petudio/main.dart';
import 'package:http/http.dart' as http;

class FourCutsGet extends StatefulWidget {
  const FourCutsGet({Key? key}) : super(key: key);

  @override
  State<FourCutsGet> createState() => FourCutsGetState();
}

class FourCutsGetState extends State<FourCutsGet> {
  TextEditingController _textEditingController = TextEditingController();
  Map<int, String> imageMap = {};

  Future<void> getGeneratedImage(String tempBundleId) async {
    // const String baseUrl = 'http://10.0.2.2:8080/api/four-cuts/generate'; //로컬
    const String baseUrl = 'http://54.180.57.146:8080/api/four-cuts/generate';
    Map<String, String> params = {'bundleId': tempBundleId};
    // URL에 파라미터 추가
    print(tempBundleId);
    Uri uri = Uri.parse(baseUrl).replace(queryParameters: params);
    print(uri);
    var response = await http.get(uri);
    print(response.body);
    setImageMap(response.body);
  }

  bool setImageMap(String responseData) {
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
      imageMap[section] = pictureS3Url;
      l -= 1;
    }
    print("imageMap" + imageMap.toString());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Petudio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(labelText: '발급받은 Id를 입력해 주세요'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var bundleId = _textEditingController.text;
                print(bundleId);
                await getGeneratedImage(bundleId);
                print(imageMap);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FourCutsResult(imageMap: imageMap),
                  ),
                );
              },
              child: Text('생성 이미지 조회'),
            ),
          ],
        ),
      ),
    );
  }
}






//   String bundleId = '';
//   final Map<int, String> imageMap = {};

//   bool isGetButtonEnabled() {
//     return true;
//   }

//   Future<bool> getGeneratedImage(String tempBundleId) async {
//     const String baseUrl = 'http://10.0.2.2:8080/api/four-cuts/generate'; //로컬
//     // const String baseUrl = 'http://54.180.57.146:8080/api/four-cuts/generate';
//     Map<String, String> params = {'bundleId': tempBundleId};
//     // URL에 파라미터 추가
//     Uri uri = Uri.parse(baseUrl).replace(queryParameters: params);

//     var response = await http.get(uri);
//     print(response.body);
//     bool state = setImageMap(response.body);
//     return state;
//   }

//   bool setImageMap(String responseData) {
//     var jsonData = jsonDecode(responseData);
//     var bundle = jsonData["data"];

//     if (bundle == "Training is not yet complete") {
//       return false;
//     }

//     var pictures = bundle["pictures"];

//     var l = pictures.length - 1;

//     for (var i = 0; i < 4; i++) {
//       var pictureS3Url = pictures[l]["pictureS3Url"];
//       var section = pictures[l]["section"];
//       imageMap[section] = pictureS3Url;
//       l -= 1;
//     }
//     print("imageMap" + imageMap.toString());
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Petudio'),
//         centerTitle: true,
//         elevation: 0.0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(8.0, 150, 8.0, 8.0),
//         child: TextField(
//           controller: bundleIdController,
//           decoration: InputDecoration(
//             labelText: 'Enter bundle Id',
//             border: OutlineInputBorder(),
//           ),
//         ),
//       ),
//       floatingActionButton: ElevatedButton(
//         onPressed: (isGetButtonEnabled())
//             ? () async {
//                 bundleId = bundleIdController.text;
//                 await getGeneratedImage(bundleId);
//                 print(imageMap);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => FourCutsResult(imageMap: imageMap),
//                   ),
//                 );
//               }
//             : null,
//         child: Text('생성 이미지 조회'),
//       ),
//     );
//   }
// }
