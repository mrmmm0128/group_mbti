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
      appBar: AppBar(title: Text('タイムライン')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _groups.length,
              itemBuilder: (context, index) {
                var group = _groups[index].data() as Map<String, dynamic>;
                String groupName = group['groupName'] ?? '未設定';
                List<dynamic> members = group['members'] ?? [];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(groupName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Column(
                          children: members.map((member) {
                            return Text(
                                '${member['name']} (MBTI: ${member['mbti']})');
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_hasMore)
            TextButton(
              onPressed: _fetchGroups,
              child: _isLoading ? CircularProgressIndicator() : Text("もっと見る"),
            ),
        ],
      ),
    );
  }
}
