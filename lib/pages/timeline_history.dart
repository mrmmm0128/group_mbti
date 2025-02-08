import 'package:app_base/model/result_group.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimelineGroupsPage extends StatefulWidget {
  @override
  _TimelineGroupsPageState createState() => _TimelineGroupsPageState();
}

class _TimelineGroupsPageState extends State<TimelineGroupsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _groups = [];
  bool _isLoading = false;
  bool _hasMore = true;
  DocumentSnapshot? _lastDocument;
  String? isSelectedItem = '相性が良い順'; // 初期値を設定

  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  Future<void> _fetchGroups() async {
    if (_isLoading || !_hasMore) return;
    setState(() => _isLoading = true);

    Query query = _firestore.collection('timeline_groups').limit(10);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    QuerySnapshot snapshot = await query.get();
    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
      _groups.addAll(snapshot.docs);
    } else {
      _hasMore = false; // これ以上データがない場合
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('みんなの診断'),
        actions: [
          DropdownButton<String>(
            items: const [
              DropdownMenuItem(
                value: '相性が良い順',
                child: Text('相性が良い順'),
              ),
              DropdownMenuItem(
                value: '相性が悪い順',
                child: Text('相性が悪い順'),
              ),
            ],
            onChanged: (String? value) {
              setState(() {
                isSelectedItem = value;

                // 並べ替えのロジック
                if (value == '相性が良い順') {
                  _groups.sort((a, b) {
                    var rankA = a['totalrank'] ?? 0;
                    var rankB = b['totalrank'] ?? 0;
                    return rankB.compareTo(rankA); // 大きい順に並べ替え
                  });
                } else if (value == '相性が悪い順') {
                  _groups.sort((a, b) {
                    var rankA = a['totalrank'] ?? 0;
                    var rankB = b['totalrank'] ?? 0;
                    return rankA.compareTo(rankB); // 小さい順に並べ替え
                  });
                }
              });
            },
            value: isSelectedItem,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _groups.length,
              itemBuilder: (context, index) {
                var group = _groups[index].data() as Map<String, dynamic>;

                List<dynamic> members = group['members'] ?? [];
                String rank = group["totalrank"].toString();

                return Card(
                  margin: EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      List names =
                          members.map((member) => member['name']!).toList();
                      List mbtis =
                          members.map((member) => member['mbti']!).toList();
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
                        ),

                        // 下部: メンバーリスト
                        Container(
                          color: Colors.grey[200], // 下部の背景色
                          padding: const EdgeInsets.all(8),
                          constraints: BoxConstraints(
                            maxHeight: 200, // 高さ制限（適宜調整）
                          ),
                          child: Row(
                            // ← ここを `Row` に変更
                            crossAxisAlignment:
                                CrossAxisAlignment.center, // 縦方向の中央揃え
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // メンバーリスト
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start, // 横方向の中央揃え
                                  children: members.map<Widget>((member) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Text(member['mbti']!));
                                  }).toList(),
                                ),
                              ),
                              SizedBox(width: 16), // 🔹 ランクとの間隔を適度に設定
                              Text("$rank 点",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_hasMore)
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: _fetchGroups,
                child: _isLoading ? CircularProgressIndicator() : Text("もっと見る"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromARGB(255, 207, 207, 207),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
