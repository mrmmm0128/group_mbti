import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_mbti/pages/result.dart';

class MBTIScreen extends StatefulWidget {
  @override
  _MBTIScreenState createState() => _MBTIScreenState();
}

class _MBTIScreenState extends State<MBTIScreen> {
  List<TextEditingController> _nameControllers = [];
  List<String> _selectedMBTI = [];
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
  List<TextEditingController> _artistControllers = [];

  @override
  void initState() {
    super.initState();
  }

  void _removeMember(int index) {
    setState(() {
      _nameControllers.removeAt(index);
      _selectedMBTI.removeAt(index);
    });
  }

  void _navigateResult() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultScreen()),
    );
  }

  void _saveData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    for (int i = 0; i < _nameControllers.length; i++) {
      String mbti = _selectedMBTI[i];
      String artist = _artistControllers[i].text;

      if (artist.isEmpty) continue; // アーティスト名が空の場合はスキップ

      // 該当するMBTIコレクションのドキュメントを取得
      final docRef = firestore.collection(mbti).doc(artist);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // ドキュメントが存在する場合、既存のカウントを増加
        int currentCount = docSnapshot.data()?['カウント'] ?? 0;
        await docRef.update({'カウント': currentCount + 1});
      } else {
        // ドキュメントが存在しない場合、新規作成
        await docRef.set({'カウント': 1});
      }
    }

    // 保存完了時の通知
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("データを保存しました！")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MBTI研究所"),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 221, 123, 94),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '自分のMBTIと好きなアーティストを入力しましょう！',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _nameControllers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 221, 123, 94),
                    child: Text("${index + 1}"),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _nameControllers[index],
                        decoration: const InputDecoration(
                          labelText: "名前を入力",
                        ),
                      ),
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
                      TextField(
                        controller: _artistControllers[index],
                        decoration: const InputDecoration(
                          labelText: "好きなアーティストを入力",
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _saveData,
              child: const Text(
                "決定",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
