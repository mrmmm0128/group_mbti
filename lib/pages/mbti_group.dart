import 'package:flutter/material.dart';
import 'package:group_mbti/model/evaluation_group.dart';
import 'package:group_mbti/pages/input_mbti.dart';
import 'package:group_mbti/pages/result.dart';
import 'package:group_mbti/pages/result_artist_mbti.dart';

class MBTIScreen extends StatefulWidget {
  @override
  _MBTIScreenState createState() => _MBTIScreenState();
}

class _MBTIScreenState extends State<MBTIScreen> {
  List<TextEditingController> _nameControllers = [];
  List<String> _selectedMBTI = [];
  Map<String, Map<String, int>> checkList = {
    "INTJ": {"INTJ": 3, "ENTJ": 4, "ISFP": 2},
    "ENTJ": {"INTJ": 4, "ENTJ": 3, "ISFP": 5},
    "ISFP": {"INTJ": 2, "ENTJ": 5, "ISFP": 3},
  };
  List<String> MBTI_List = [
    "ENFJ",
    "ENFP",
    "ENTJ",
    "ENTP",
    "INFJ",
    "INFP",
    "INTJ",
    "INTP",
    "ISFJ",
    "ISFP",
    "ISTJ",
    "ISTP",
    "ESFJ",
    "ESFP",
    "ESTJ",
    "ESTP"
  ];

  @override
  void initState() {
    super.initState();
    _addMember();
  }

  void _addMember() {
    setState(() {
      _nameControllers.add(TextEditingController());
      _selectedMBTI.add("INTJ"); // 初期値としてINTJを設定
    });
  }

  void _removeMember(int index) {
    setState(() {
      _nameControllers.removeAt(index);
      _selectedMBTI.removeAt(index);
    });
  }

  void _navigateResult(MBTI) {
    int totalrank = mbtiCheck(MBTI, checkList);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResultScreen(
                totalrank: totalrank,
              )),
    );
  }

  void _navigateinputMBTI() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => inputMBTIScreen()),
    );
  }

  void _navigateResultMBTI() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultArtistScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MBTI調査"),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 221, 123, 94),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'input') {
                _navigateinputMBTI();
              } else if (value == 'watchtrend') {
                _navigateResultMBTI();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'input',
                child: Text("自分の情報を入力"),
              ),
              const PopupMenuItem(
                value: 'watchtrend',
                child: Text("MBTIの傾向を見る"),
              ),
            ],
            icon: const Icon(Icons.more_vert),
            tooltip: "ページ選択",
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'MBTIを活用してグループの評価をしましょう',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _nameControllers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 221, 123, 94),
                    child: Text("${index + 1}"),
                  ),
                  title: TextField(
                    controller: _nameControllers[index],
                    decoration: InputDecoration(
                      labelText: "名前を入力",
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<String>(
                        value: _selectedMBTI[index],
                        items: MBTI_List.map((mbti) => DropdownMenuItem(
                              value: mbti,
                              child: Text(mbti),
                            )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedMBTI[index] = value!;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () => _removeMember(index),
                        tooltip: '削除',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _addMember,
                  icon: Icon(Icons.add),
                  tooltip: "メンバーを追加",
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _navigateResult(_selectedMBTI),
                  child: Text(
                    "診断",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
