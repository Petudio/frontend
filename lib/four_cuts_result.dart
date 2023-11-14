import 'package:flutter/material.dart';

class FourCutsResult extends StatefulWidget {
  final Map<int, String>
      imageMap; //{4:image4Url, 3:image3Url, 2:image2Url, 1:image1Url}

  const FourCutsResult({Key? key, required this.imageMap}) : super(key: key);

  @override
  State<FourCutsResult> createState() => _FourCutsResultState();
}

class _FourCutsResultState extends State<FourCutsResult> {
  // Define your image URLs in the map
  final Map<int, String> imageMap = {
    4: 'https://petudio-bucket.s3.ap-northeast-2.amazonaws.com/ca6e6119-fa37-4518-b854-f91e1afcc48d.PNG',
    3: 'https://petudio-bucket.s3.ap-northeast-2.amazonaws.com/4e7f5f09-37d8-4251-95dd-973e0ff250c3.PNG',
    2: 'https://petudio-bucket.s3.ap-northeast-2.amazonaws.com/507262e4-4de3-4cc8-8efc-568ff291e5fa.PNG',
    1: 'https://petudio-bucket.s3.ap-northeast-2.amazonaws.com/9c971ed9-d07d-415f-b7f6-e2f299bbfa38.PNG',
  };

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
            color: Colors.blue,
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildImage(imageMap[4]),
                    ),
                    Expanded(
                      child: _buildImage(imageMap[3]),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildImage(imageMap[2]),
                    ),
                    Expanded(
                      child: _buildImage(imageMap[1]),
                    ),
                  ],
                ),
              ),
              _buildImage(
                  'https://petudio-bucket.s3.ap-northeast-2.amazonaws.com/Logo_of_Petudio_removebg.png'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          // Replace this onPressed logic if needed
          print("다운로드 버튼이 눌렸습니다.....");
        },
        child: Text('다운로드'),
      ),
    );
  }

  Widget _buildImage(String? imageUrl) {
    return imageUrl != null
        ? Image.network(
            imageUrl,
            fit: BoxFit.cover, // Adjust the fit property as needed
            errorBuilder: (context, error, stackTrace) {
              print('Error loading image: $error');
              return Icon(
                  Icons.error); // You can customize the error placeholder
            },
          )
        : Container(); // You can also use a placeholder image here
  }
}
