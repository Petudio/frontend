import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(FourCuts());
}

class FourCuts extends StatefulWidget {
  const FourCuts({Key? key}) : super(key: key);

  @override
  State<FourCuts> createState() => _FourCutsState();
}

class _FourCutsState extends State<FourCuts> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile?> _pickedImages = [];
  // Replace with your S3 bucket URL
  final String s3BucketUrl = 'http://54.180.57.146:8080/api/fourcuts/upload';

  // 이미지 여러개 불러오기
  void getMultiImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
      setState(() {
        _pickedImages.addAll(images);
      });
    }
  }

  bool isSendButtonEnabled() {
    return _pickedImages.length >= 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              _gridPhoto(),
              const SizedBox(height: 20),
              _imageLoadButtons(),
            ],
          ),
        ),
      ),
    );
  }

  void uploadimages() async {
    final url = Uri.parse('http://54.180.57.146:8080/api/fourcuts/upload');
    var request = http.MultipartRequest('POST', url);
    for (var image in _pickedImages) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'beforePictures',
          image!.path,
        ),
      );
    }
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    print(responseData.split(":")[1]);

    //upload button
  }

  // 화면 하단 버튼
  Widget _imageLoadButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: ElevatedButton(
              onPressed: () => getMultiImage(),
              child: const Text('Multi Image'),
            ),
          ),
          SizedBox(
            child: ElevatedButton(
              onPressed: isSendButtonEnabled()
                  ? () {
                      uploadimages();
                    }
                  : null,
              child: const Text('Send'),
            ),
          ),
        ],
      ),
    );
  }

  // 불러온 이미지 gridView
  Widget _gridPhoto() {
    return Expanded(
      child: _pickedImages.isNotEmpty
          ? GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              children: _pickedImages
                  .where((element) => element != null)
                  .map((e) => _gridPhotoItem(e!))
                  .toList(),
            )
          : const SizedBox(),
    );
  }

  Widget _gridPhotoItem(XFile e) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(e.path),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _pickedImages.remove(e);
                });
              },
              child: const Icon(
                Icons.cancel_rounded,
                color: Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }
}
