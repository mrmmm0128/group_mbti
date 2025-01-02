import 'package:app_base/model/getDeviceId.dart';
import 'package:app_base/model/result_group.dart';
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
      var deviceId = await getDeviceIDweb();
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
            // グループメンバーを取得
            for (var member in groupDoc['members']) {
              members.add({
                'name': member['name'].toString(),
                'mbti': member['mbti'].toString(),
              });
            }
            setState(() {
              // グループごとのデータ（グループIDとメンバー）をリストに追加
              _groupMembers.add({
                'groupId': index + 1, // groupIdを代わりに使用
                'members': members,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自分のグループ一覧'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // ローディング中はインジケーターを表示
          : _groupMembers.isEmpty
              ? Center(child: Text("まだ参加しているグループはありません"))
              : ListView.builder(
                  itemCount: _groupMembers.length,
                  itemBuilder: (context, index) {
                    var group = _groupMembers[index];
                    var groupId = group['groupId'];
                    List<Map<String, String>> members = group['members'];
                    // nameとmbtiをList<String>として分ける
                    // 名前のリストを作成
                    List<String> names =
                        members.map((member) => member['name']!).toList();

                    // MBTIのリストを作成
                    List<String> mbtis =
                        members.map((member) => member['mbti']!).toList();

                    return Card(
                      margin: EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          print(members);
                          // ボタンがタップされたときの処理をここで定義
                          navigateResult(context, mbtis, names);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'グループ $groupId', // グループIDを表示
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Column(
                              children: members.map<Widget>((member) {
                                return ListTile(
                                  title: Text(member['name']!),
                                  subtitle: Text('MBTI: ${member['mbti']}'),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
