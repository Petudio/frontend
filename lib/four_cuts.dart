import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petudio/four_cuts_settings.dart';

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
  final XFile? pickedImages = null;

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
              child: const Text('이미지 선택하기'),
            ),
          ),
          SizedBox(
            child: ElevatedButton(
              onPressed: isSendButtonEnabled()
                  ? () {
                      // 이미지가 2개 이상 선택된 경우에만 옵션 선택 페이지로 이동
                      if (isSendButtonEnabled()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FourCutsSettings(pickedImages: _pickedImages),
                          ),
                        );
                      }
                    }
                  : null,
              child: const Text('옵션 선택하기'),
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
