import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_mbti/model/ArtistSearch.dart';

class inputMBTIScreen extends StatefulWidget {
  @override
  _inputMBTIScreenState createState() => _inputMBTIScreenState();
}

class _inputMBTIScreenState extends State<inputMBTIScreen> {
  final List<TextEditingController> _artistControllers = [];
  String _selectedMBTI = "INTJ";
  final List<String> MBTI_List = [
    "INTJ",
    "INTP",
    "ENTJ",
    "ENTP",
    "INFJ",
    "INFP",
    "ENFJ",
    "ENFP",
    "ISTJ",
    "ISFJ",
    "ESTJ",
    "ESFJ",
    "ISTP",
    "ISFP",
    "ESTP",
    "ESFP",
  ];

  @override
  void initState() {
    super.initState();
    _addNewInputField(); // 最初の入力フィールドを追加
  }

  void _addNewInputField() {
    setState(() {
      _artistControllers.add(TextEditingController());
    });
  }

  void _removeMember(int index) {
    setState(() {
      _artistControllers.removeAt(index);
    });
  }

  void _saveData() async {
    final firestore = FirebaseFirestore.instance;

    try {
      for (int i = 0; i < _artistControllers.length; i++) {
        String artistName = _artistControllers[i].text.trim();

        if (artistName.isNotEmpty) {
          // 選択されたMBTIコレクションに保存
          await firestore.collection(_selectedMBTI).doc("アーティスト").set(
              {artistName: FieldValue.increment(1)}, SetOptions(merge: true));
        } else {
          // 入力が空の場合のエラーメッセージ
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("アーティスト名が入力されていないフィールドがあります！ (行: ${i + 1})"),
              backgroundColor: Colors.red,
            ),
          );
          return; // 処理を中断
        }
      }

      // 保存成功時のフィードバック
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("ご回答ありがとうございました！"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // エラー発生時のフィードバック
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("データ保存中にエラーが発生しました: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MBTI調査"),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 221, 123, 94),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'MBTIと好きなアーティストを入力しましょう',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "これから調査項目を増やしていく予定です。",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          // MBTI選択欄
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              value: _selectedMBTI,
              items: MBTI_List.map((mbti) => DropdownMenuItem(
                    value: mbti,
                    child: Text(mbti),
                  )).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMBTI = value!;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _artistControllers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 221, 123, 94),
                    child: Text("${index + 1}"),
                  ),
                  title:
                      ArtistSearchField(controller: _artistControllers[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _removeMember(index);
                    },
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _addNewInputField,
                child: const Text(
                  "アーティスト追加",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _saveData,
                child: const Text(
                  "提出",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
