import 'package:flutter/material.dart';

class FourCutsOptions extends StatefulWidget {
  const FourCutsOptions({Key? key}) : super(key: key);

  final String? initialBackground = '랜덤';

  @override
  _MyScreenStateState createState() => _MyScreenStateState(initialBackground);
}

class _MyScreenStateState extends State<FourCutsOptions> {
  String? selectedBackground;
  List<String> selectedItems = [];

  _MyScreenStateState(this.selectedBackground);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Petudio'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                _buildGridItem('모자'),
                _buildGridItem('선글라스'),
              ],
            ),
          ),
          _buildBackgroundSelector(),
          ElevatedButton(
            onPressed: () {
              // "적용" 버튼을 클릭할 때의 로직
              Navigator.pop(
                context,
                {'items': selectedItems, 'background': selectedBackground},
              );
            },
            child: Text('적용'),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(String item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(item),
        Switch(
          value: selectedItems.contains(item),
          onChanged: (value) {
            setState(() {
              if (value) {
                selectedItems.add(item);
              } else {
                selectedItems.remove(item);
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildBackgroundSelector() {
    return Column(
      children: [
        Text('배경 선택'),
        RadioListTile(
          title: Text('엄청 귀여운 랜덤 배경'),
          value: '랜덤',
          groupValue: selectedBackground,
          onChanged: (value) {
            setState(() {
              selectedBackground = value;
            });
          },
        ),
        RadioListTile(
          title: Text('샤랄라 꽃밭'),
          value: '꽃밭',
          groupValue: selectedBackground,
          onChanged: (value) {
            setState(() {
              selectedBackground = value;
            });
          },
        ),
        RadioListTile(
          title: Text('봄봄봄 벚꽃'),
          value: '벚꽃',
          groupValue: selectedBackground,
          onChanged: (value) {
            setState(() {
              selectedBackground = value;
            });
          },
        ),
        RadioListTile(
          title: Text('어푸어푸 수영'),
          value: '수영',
          groupValue: selectedBackground,
          onChanged: (value) {
            setState(() {
              selectedBackground = value;
            });
          },
        ),
        RadioListTile(
          title: Text('웅장한 피라미드'),
          value: '피라미드',
          groupValue: selectedBackground,
          onChanged: (value) {
            setState(() {
              selectedBackground = value;
            });
          },
        ),
        RadioListTile(
          title: Text('활기찬 경기장'),
          value: '경기장',
          groupValue: selectedBackground,
          onChanged: (value) {
            setState(() {
              selectedBackground = value;
            });
          },
        ),
        RadioListTile(
          title: Text('시원한 해변'),
          value: '해변',
          groupValue: selectedBackground,
          onChanged: (value) {
            setState(() {
              selectedBackground = value;
            });
          },
        ),
      ],
    );
  }
}
