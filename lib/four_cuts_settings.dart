import 'package:flutter/material.dart';
import 'package:petudio/four_cuts_options.dart';

class FourCutsSettings extends StatefulWidget {
  const FourCutsSettings({Key? key}) : super(key: key);

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
            color: Colors.green,
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
                              selectedBackgroundMap['구역 1'] = result['background'];
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
                              selectedBackgroundMap['구역 2'] = result['background'];
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
                              selectedBackgroundMap['구역 3'] = result['background'];
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
                              selectedBackgroundMap['구역 4'] = result['background'];
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
                Image.asset(
                  'assets/Logo_of_Petudio_removebg.png'), // 이미지 파일 경로를 적절히 수정하세요// 나머지 코드는 동일
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          // "만들기" 버튼을 클릭할 때의 로직
          // 각 구역의 선택된 항목들에 대한 처리를 추가
          for (var entry in selectedItemsMap.entries) {
            print('${entry.key}: ${entry.value}');
          }
          // 각 구역의 선택된 배경에 대한 처리를 추가
          for (var entry in selectedBackgroundMap.entries) {
            print('${entry.key} 배경: ${entry.value}');
          }
        },
        child: Text('만들기'),
      ),
    );
  }
}