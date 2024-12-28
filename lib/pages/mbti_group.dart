import 'package:flutter/material.dart';
import '/model/evaluation_group.dart';
import '/pages/result.dart';

class MBTIScreen extends StatefulWidget {
  @override
  _MBTIScreenState createState() => _MBTIScreenState();
}

class _MBTIScreenState extends State<MBTIScreen> {
  List<int> chartValue = [1, 5, 3, 4, 5, 4]; // サンプルデータ

  List<TextEditingController> _nameControllers = [];
  List<String> _selectedMBTI = [];
  Map<String, Map<String, int>> checkList = {
    "INTJ": {
      "INTJ": 3,
      "INTP": 3,
      "INFJ": 2,
      "INFP": 3,
      "ENTP": 2,
      "ENFP": 4,
      "ENTJ": 4,
      "ENFJ": 2,
      "ISTJ": 4,
      "ISFJ": 4,
      "ISTP": 3,
      "ISFP": 2,
      "ESTJ": 2,
      "ESFJ": 1,
      "ESTP": 4,
      "ESFP": 5
    },
    "INTP": {
      "ESFP": 1,
      "ENTJ": 2,
      "ENFP": 2,
      "ISFJ": 2,
      "ISTP": 2,
      "ESTP": 2,
      "INTJ": 3,
      "INTP": 3,
      "INFJ": 3,
      "ISTJ": 3,
      "ENTP": 4,
      "INFP": 4,
      "ENFJ": 4,
      "ESTJ": 4,
      "ISFP": 4,
      "ESFJ": 5
    },
    "INFJ": {
      "ISFJ": 3,
      "INTP": 4,
      "INFJ": 3,
      "ENFJ": 4,
      "ISTJ": 3,
      "ESFP": 4,
      "ENTJ": 5,
      "ENTP": 1,
      "ENFP": 2,
      "ESTP": 2,
      "INTJ": 2,
      "INFP": 2,
      "ESTJ": 4,
      "ESFJ": 2,
      "ISTP": 4,
      "ISFP": 3
    },
    "INFP": {
      "ESTP": 1,
      "ENTP": 2,
      "ENFJ": 2,
      "ISTJ": 2,
      "ISFP": 2,
      "ESFP": 2,
      "INTJ": 3,
      "INFJ": 3,
      "INFP": 3,
      "ISFJ": 3,
      "INTP": 4,
      "ENTJ": 4,
      "ENFP": 4,
      "ESFJ": 4,
      "ISTP": 4,
      "ESTJ": 5
    },
    "ENTJ": {
      "ISFJ": 1,
      "INTP": 2,
      "INFJ": 2,
      "ENFJ": 2,
      "ISTJ": 2,
      "ESFP": 2,
      "ENTJ": 3,
      "ENTP": 3,
      "ENFP": 3,
      "ESTP": 3,
      "INTJ": 4,
      "INFP": 4,
      "ESTJ": 4,
      "ESFJ": 4,
      "ISTP": 4,
      "ISFP": 5
    },
    "ENTP": {
      "ISFP": 1,
      "INTJ": 2,
      "INFP": 2,
      "ESFJ": 2,
      "ISTP": 2,
      "ESTP": 2,
      "ENTJ": 3,
      "ENTP": 3,
      "ENFJ": 3,
      "ESTJ": 3,
      "INTP": 4,
      "INFJ": 4,
      "ENFP": 4,
      "ISTJ": 4,
      "ESFP": 4,
      "ISFJ": 5
    },
    "ENFP": {
      "ISTP": 1,
      "INTP": 2,
      "INFJ": 2,
      "ESTJ": 2,
      "ISFP": 2,
      "ESFP": 2,
      "ENTJ": 3,
      "ENFJ": 3,
      "ENFP": 3,
      "ESFJ": 3,
      "INTJ": 4,
      "ENTP": 4,
      "INFP": 4,
      "ISFJ": 4,
      "ESTP": 4,
      "ISTJ": 5
    },
    "ENFJ": {
      "ISTJ": 1,
      "INTJ": 2,
      "ENTJ": 2,
      "INFP": 2,
      "ISFJ": 2,
      "ESTP": 2,
      "ENTP": 3,
      "ENFJ": 3,
      "ENFP": 3,
      "ESFP": 3,
      "INTP": 4,
      "INFJ": 4,
      "ESTJ": 4,
      "ESFJ": 4,
      "ISFP": 4,
      "ISTP": 5
    },
    "ISTJ": {
      "ENFJ": 1,
      "ENTJ": 2,
      "INFP": 2,
      "ISFJ": 2,
      "ESFJ": 2,
      "ESTP": 2,
      "INTP": 3,
      "ISTJ": 3,
      "ISTP": 3,
      "ISFP": 3,
      "INTJ": 4,
      "ENTP": 4,
      "INFJ": 4,
      "ESTJ": 4,
      "ESFP": 4,
      "ENFP": 5
    },
    "ISTP": {
      "ENFP": 1,
      "INTP": 2,
      "ENTP": 2,
      "INFJ": 2,
      "ESTJ": 2,
      "ESFP": 2,
      "INTJ": 3,
      "ISTJ": 3,
      "ISFJ": 3,
      "ISTP": 3,
      "ENTJ": 4,
      "INFP": 4,
      "ESFJ": 4,
      "ISFP": 4,
      "ESTP": 4,
      "ENFJ": 5
    },
    "ISFJ": {
      "ENTJ": 1,
      "INTP": 2,
      "ENFJ": 2,
      "ISTJ": 2,
      "ESTJ": 2,
      "ESFP": 2,
      "INFP": 3,
      "ISFJ": 3,
      "ISTP": 3,
      "ISFP": 3,
      "INTJ": 4,
      "INFJ": 4,
      "ENFP": 4,
      "ESFJ": 4,
      "ESTP": 4,
      "ENTP": 5
    },
    "ISFP": {
      "ENTP": 1,
      "INTJ": 2,
      "INFP": 2,
      "ENFP": 2,
      "ESFJ": 2,
      "ESTP": 2,
      "INFJ": 3,
      "ISTJ": 3,
      "ISFJ": 3,
      "ISFP": 3,
      "INTP": 4,
      "ENFJ": 4,
      "ESTJ": 4,
      "ISTP": 4,
      "ESFP": 4,
      "ENTJ": 5
    },
    "ESTJ": {
      "INFJ": 1,
      "INTJ": 2,
      "ENFP": 2,
      "ISFJ": 2,
      "ESFJ": 2,
      "ISTP": 2,
      "ENTP": 3,
      "ESTJ": 3,
      "ESTP": 3,
      "ESFP": 3,
      "INTP": 4,
      "ENTJ": 4,
      "ENFJ": 4,
      "ISTJ": 4,
      "ISFP": 4,
      "INFP": 5
    },
    "ESTP": {
      "INFP": 1,
      "INTP": 2,
      "ENTP": 2,
      "ENFJ": 2,
      "ISTJ": 2,
      "ISFP": 2,
      "ENTJ": 3,
      "ESTJ": 3,
      "ESFJ": 3,
      "ESTP": 3,
      "INTJ": 4,
      "ENFP": 4,
      "ISFJ": 4,
      "ISTP": 4,
      "ESFP": 4,
      "INFJ": 5
    },
    "ESFJ": {
      "INTJ": 1,
      "ENTP": 2,
      "INFJ": 2,
      "ISTJ": 2,
      "ESTJ": 2,
      "ISFP": 2,
      "ENFP": 3,
      "ESFJ": 3,
      "ESTP": 3,
      "ESFP": 3,
      "ENTJ": 4,
      "INFP": 4,
      "ENFJ": 4,
      "ISFJ": 4,
      "ISTP": 4,
      "INTP": 5
    },
    "ESFP": {
      "INTP": 1,
      "ENTJ": 2,
      "INFP": 2,
      "ENFP": 2,
      "ISFJ": 2,
      "ISTP": 2,
      "ENFJ": 3,
      "ESFJ": 3,
      "ESTJ": 3,
      "ESFP": 3,
      "ENTP": 4,
      "INFJ": 4,
      "ISFP": 4,
      "ISTJ": 4,
      "ESTP": 4,
      "INTJ": 5
    },
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

  Color _getBackgroundColor2(String mbti) {
    // 背景色のパレット
    List<Color> colors = [
      Color(0xFFDCC7E1),
      Color(0xFFCFE8D5),
      Color(0xFFCFE4F6),
      Color(0xFFFFF4CC),
    ];

    // MBTIのカテゴリに応じて色を割り当て
    if (mbti.contains("NT")) {
      return colors[0]; // NT -> パープル
    } else if (mbti.contains("NF")) {
      return colors[1]; // NF -> イエロー
    } else if (mbti.contains("SFJ")) {
      return colors[2]; // SJ -> グリーン
    } else if (mbti.contains("STJ")) {
      return colors[2];
    } else if (mbti.contains("SFP")) {
      return colors[3]; // SP -> ブルー
    } else if (mbti.contains("STP")) {
      return colors[3];
    } else {
      // デフォルトの背景色
      return Color(0xFFFFFFFF); // 白
    }
  }

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
    int index = 1;
    chartValue[0] = calculateValue(MBTI, "E");
    chartValue[1] = calculateValue(MBTI, "T") + 1;
    chartValue[2] = calculateValue(MBTI, "S") + 1;
    chartValue[3] = calculateValue(MBTI, "SF") + 1;
    chartValue[4] = calculateValue(MBTI, "J");
    chartValue[5] = calculateValue(MBTI, "EF") + 1;

    Map<String, String> nameAndMBTIDict = {};

    for (int i = 0; i < _nameControllers.length; i++) {
      // 名前を取得
      String name = _nameControllers[i].text.isNotEmpty
          ? _nameControllers[i].text
          : '${i + 1}';

      // MBTIを取得
      String mbti = _selectedMBTI[i];

      // 辞書に追加（名前をキー、MBTIを値とする）
      if (name.isNotEmpty && mbti.isNotEmpty) {
        nameAndMBTIDict[name] = mbti;
      }
    }

    List<int> compatibilityScores = mbtiValue(nameAndMBTIDict, checkList);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResultScreen(
                totalrank: totalrank,
                chartValue: chartValue,
                index: index,
                NameAndMbti: nameAndMBTIDict,
                compatibilityScores: compatibilityScores,
              )),
    );
    print(nameAndMBTIDict);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4), // 各アイテムの上下の余白
                  decoration: BoxDecoration(
                    color: _getBackgroundColor2(_selectedMBTI[index]), // 背景色
                    borderRadius: BorderRadius.circular(16), // 角を丸くする
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // 影の色
                        spreadRadius: 1, // 影の広がり
                        blurRadius: 3, // ぼかしの強さ
                        offset: Offset(0, 1), // 影の位置
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          _getBackgroundColor2(_selectedMBTI[index]),
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
