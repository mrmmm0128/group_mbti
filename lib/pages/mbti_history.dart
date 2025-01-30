import 'package:app_base/model/getDeviceId.dart';
import 'package:app_base/model/result_group.dart';
import 'package:app_base/pages/timeline_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupListPage extends StatefulWidget {
  @override
  _GroupListPageState createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  List<Map<String, dynamic>> _groupMembers = []; // グループごとのメンバー情報をリストに格納
  bool _isLoading = true; // ローディング状態

  @override
  void initState() {
    super.initState();
    _loadGroupData(); // 初期データの読み込み
  }

  // デバイスIDを基にFirestoreからデータを取得
  Future<void> _loadGroupData() async {
    try {
      // デバイスIDを取得する関数（仮定）
      var deviceId = await getDeviceUUID();
      // デバイスIDに基づくFirestoreのドキュメント参照
      var deviceRef =
          FirebaseFirestore.instance.collection('devices').doc(deviceId);

      // デバイスデータを取得
      var doc = await deviceRef.get();
      if (doc.exists) {
        // デバイスに紐づくグループIDのリストを取得
        List<String> groupIds = List<String>.from(doc['groups'] ?? []);

        // それぞれのグループIDに対応するグループ情報を取得
        for (int index = 0; index < groupIds.length; index++) {
          var groupId = groupIds[index]; // インデックスを使用して groupId を取得
          var groupDoc = await FirebaseFirestore.instance
              .collection('groups')
              .doc(groupId)
              .get();
          if (groupDoc.exists) {
            List<Map<String, String>> members = [];
            String _groupName = "";
            // グループメンバーを取得
            for (var member in groupDoc['members']) {
              members.add({
                'name': member['name'].toString(),
                'mbti': member['mbti'].toString(),
              });
            }

            if (groupDoc["groupName"] != "defolt") {
              _groupName = groupDoc["groupName"];
            } else {
              _groupName = _groupName = (index + 1).toString();
            }
            setState(() {
              // グループごとのデータ（グループIDとメンバー）をリストに追加
              _groupMembers.add({
                'groupName': _groupName, // groupIdを代わりに使用
                'members': members,
                "groupId": groupId,
              });
              _isLoading = false; // ローディング状態を解除
            });
          }
        }
      } else {
        // デバイスに対応するデータがない場合
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("エラーが発生しました: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _changeGroupName(int index) async {
    var group = _groupMembers[index];
    String groupId = group['groupId'];
    TextEditingController controller =
        TextEditingController(text: group['groupName']);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("グループ名を変更"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: "新しいグループ名"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("キャンセル"),
            ),
            TextButton(
              onPressed: () async {
                String newName = controller.text.trim();
                if (newName.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('groups')
                      .doc(groupId)
                      .update({'groupName': newName});
                  setState(() {
                    _groupMembers[index]['groupName'] = newName;
                  });
                }
                Navigator.pop(context);
              },
              child: Text("保存"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteGroup(int index) async {
    var group = _groupMembers[index];
    var groupId = group['groupId'];
    var deviceId = await getDeviceUUID();
    try {
      await FirebaseFirestore.instance
          .collection('devices')
          .doc(deviceId)
          .update({
        'groups': FieldValue.arrayRemove([groupId])
      });
      setState(() {
        _groupMembers.removeAt(index);
      });
      print('グループが削除されました');
    } catch (e) {
      print("エラーが発生しました: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自分のグループ一覧'),
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      ),
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _groupMembers.isEmpty
              ? Center(child: Text("まだ参加しているグループはありません"))
              : Column(
                  children: [
                    Expanded(
                      // 🔹 ListViewの高さを制限
                      child: ListView.builder(
                        itemCount: _groupMembers.length,
                        itemBuilder: (context, index) {
                          var group = _groupMembers[index];
                          List<Map<String, String>> members = group['members'];
                          return Card(
                            margin: EdgeInsets.all(20),
                            child: InkWell(
                              onTap: () {
                                List<String> names = members
                                    .map((member) => member['name']!)
                                    .toList();
                                List<String> mbtis = members
                                    .map((member) => member['mbti']!)
                                    .toList();
                                navigateResult(context, mbtis, names);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 上部: グループ名と編集・削除ボタン
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: const Color.fromARGB(
                                          255, 251, 187, 187), // 上部の背景色
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () => _changeGroupName(index),
                                          child: Row(
                                            children: [
                                              Text(
                                                group['groupName'],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(width: 6),
                                              Icon(Icons.edit, size: 18),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () => _deleteGroup(index),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // 下部: メンバーリスト
                                  Container(
                                    color: Colors.grey[200], // 下部の背景色
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: members.map<Widget>((member) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(member['name']!),
                                              Text('MBTI: ${member['mbti']}'),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TimelineGroupsPage()), // 遷移先のページ
                          );
                        },
                        child: Text("みんなの診断を見る"))
                  ],
                ),
    );
  }
}
