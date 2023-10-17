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



  // 카메라, 갤러리에서 이미지 1개 불러오기
  // ImageSource.galley , ImageSource.camera 
  void getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    setState(() {
      _pickedImages.add(image);
    });
  }
  
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

Future<void> uploadToS3(XFile file) async {
    final url = await getPresignedUrl();
    final response = await http.put(Uri.parse(url!), body: await file.readAsBytes());
    
    if (response.statusCode == 200) {
      // File uploaded successfully
      print('File uploaded successfully');


    } else {
      // Handle error
      print('Error uploading file: ${response.statusCode}');
    }
  }

  Future<String?> getPresignedUrl() async {
    // Replace with your server logic to get a presigned URL
    // You need to implement a server endpoint that generates presigned URLs
    // Check your S3 SDK documentation for how to generate presigned URLs on your server
    final response = await http.post(Uri.parse('http://54.180.57.146:8080/api/fourcuts/upload'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      // Handle error
      print('Error getting presigned URL: ${response.statusCode}');
      return null;
    }
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
                  ? () async {
                      for (var image in _pickedImages) {
                        if (image != null) {
                          await uploadToS3(image);
                        }
                      }
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