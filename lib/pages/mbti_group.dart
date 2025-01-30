import 'package:app_base/model/getDeviceId.dart';
import 'package:app_base/model/result_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MBTIScreen extends StatefulWidget {
  @override
  _MBTIScreenState createState() => _MBTIScreenState();
}

class _MBTIScreenState extends State<MBTIScreen> {
  List<int> chartValue = [1, 5, 3, 4, 5, 4]; // サンプルデータ
  List<TextEditingController> _nameControllers = [];
  List<String> _selectedMBTI = [];
  bool _isChecked = false;

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

  Future<void> _saveToFirestore(List<Map<String, String>> members) async {
    try {
      print("Firestoreインスタンスを取得...");
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot snapshot = await firestore.collection('groups').get();
      QuerySnapshot snapshot_timeline =
          await firestore.collection('timeline_groups').get();
      print("既存のグループデータを取得: ${snapshot.docs.length}");

      int nextGroupNumber = snapshot.docs.length + 1;
      int nextGroupTimeline = snapshot_timeline.docs.length + 1;
      print("次のグループ番号: $nextGroupNumber");

      // グループデータを保存
      await firestore
          .collection('groups')
          .doc(nextGroupNumber.toString())
          .set({'members': members, "groupName": "defolt"});
      if (_isChecked) {
        await firestore
            .collection("timeline_groups")
            .doc(nextGroupTimeline.toString())
            .set({"groupName": "defolt", "members": members});
      }
      print("グループデータの保存に成功");

      var deviceId = await getDeviceIDweb();
      print(deviceId);

      final deviceRef = FirebaseFirestore.instance
          .collection('devices')
          .doc(deviceId.toString());

      final doc = await deviceRef.get();
      if (doc.exists) {
        final groups = List<String>.from(doc['groups'] ?? []);
        print("既存のグループリスト: $groups");

        if (!groups.contains(deviceId)) {
          groups.add(nextGroupNumber.toString());
          await deviceRef.update({'groups': groups});
          print("デバイスのグループリストを更新");
        }
      } else {
        await deviceRef.set({
          'groups': [nextGroupNumber.toString()]
        });
        print("新規デバイスデータを保存");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("保存エラーです")),
      );
    }
  }

  Future<void> _saveGroup() async {
    // メンバーリストを作成
    List<Map<String, String>> members = [];

    // 名前の入力が1人だけの場合はエラーを表示して終了
    if (_nameControllers.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('二人以上入力してください')),
      );
      return; // 1人の場合は処理を終了
    }
    for (int i = 0; i < _nameControllers.length; i++) {
      String name = _nameControllers[i].text.isNotEmpty
          ? _nameControllers[i].text
          : 'メンバー${i + 1}';
      String mbti = _selectedMBTI[i];

      members.add({
        'name': name,
        'mbti': mbti,
      });
    }
    // Firestoreに保存
    await _saveToFirestore(members);
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
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
                Text(_isChecked ? "タイムラインに投稿する" : "タイムラインに投稿しない"),
                IconButton(
                  onPressed: _addMember,
                  icon: Icon(Icons.add),
                  tooltip: "メンバーを追加",
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    List<String> names = _nameControllers
                        .map((controller) => controller.text)
                        .toList();
                    print(names);
                    await _saveGroup();
                    navigateResult(context, _selectedMBTI, names); // 結果画面へ遷移
                  },
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
