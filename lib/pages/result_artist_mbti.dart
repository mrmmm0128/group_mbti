import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_mbti/model/spotifyAPI.dart';

class ResultArtistScreen extends StatefulWidget {
  @override
  _ResultArtistScreenState createState() => _ResultArtistScreenState();
}

class _ResultArtistScreenState extends State<ResultArtistScreen> {
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

  Future<Map<String, dynamic>> _fetchRanking() async {
    final firestore = FirebaseFirestore.instance;
    try {
      final docSnapshot =
          await firestore.collection(_selectedMBTI).doc("アーティスト").get();
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print("データの取得中にエラーが発生しました: $e");
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("アーティストランキング"),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 221, 123, 94),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
            child: FutureBuilder<Map<String, dynamic>>(
              future: _fetchRanking(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("エラーが発生しました。再度お試しください。"),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("データがありません。"),
                  );
                }

                final ranking = snapshot.data!;
                final sortedRanking = ranking.entries.toList()
                  ..sort((a, b) => b.value.compareTo(a.value));

                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: sortedRanking.length,
                  itemBuilder: (context, index) {
                    final artist = sortedRanking[index];

                    return FutureBuilder<String?>(
                      future: SpotifyService.getArtistImage(artist.key),
                      builder: (context, imageSnapshot) {
                        if (imageSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final imageUrl = imageSnapshot.data;

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: [
                              if (imageUrl != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              else
                                const Icon(Icons.person, size: 120),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  artist.key,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text("${artist.value}票"),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
