import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FourCutsResult2 extends StatefulWidget {
  final Map<int, String>
      imageMap; //{4:image4Url, 3:image3Url, 2:image2Url, 1:image1Url}

  const FourCutsResult2({Key? key, required this.imageMap}) : super(key: key);

  @override
  State<FourCutsResult2> createState() => _FourCutsResultState();
}

class _FourCutsResultState extends State<FourCutsResult2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Grid Example'),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 그리드 열의 개수
            crossAxisSpacing: 8.0, // 그리드 열 간의 간격
            mainAxisSpacing: 8.0, // 그리드 행 간의 간격
          ),
          itemCount: widget.imageMap.length,
          itemBuilder: (BuildContext context, int index) {
            // Map에서 데이터를 가져오기
            int key = widget.imageMap.keys.elementAt(index);
            String? imageUrl = widget.imageMap[key];

            // 이미지를 띄우는 코드
            return InkWell(
              child: Card(
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
