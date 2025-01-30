import 'package:app_base/model/evaluation_group.dart';
import 'package:app_base/pages/mbti_pages/explain_mbti.dart';
import 'package:flutter/material.dart';

class MBTIDetailPage extends StatelessWidget {
  final String type;
  final String description;

  MBTIDetailPage({
    required this.type,
    required this.description,
    Key? key,
  }) : super(key: key);

  late Map<String, int>? Scores = checkList[type];
  late String bestMBTI = getKeysWithValue(Scores!, 1);
  late String worstMBTI = getKeysWithValue(Scores!, 5);

  Color _getBackgroundColor2(String mbti) {
    // 背景色のパレット
    List<Color> colors = [
      Color.fromARGB(255, 217, 189, 224),
      Color.fromARGB(255, 187, 232, 197),
      Color.fromARGB(255, 191, 220, 245),
      Color.fromARGB(255, 248, 232, 175),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239), // 背景色
      appBar: AppBar(
        title: const Text('MBTIグループ診断'),
        backgroundColor: _getBackgroundColor2(type),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$type（$description）',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              decoration: BoxDecoration(
                color: _getBackgroundColor2(type),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4), // 影の位置
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$typeの特徴",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 49, 45, 45),
                  ),
                  Text(explainMbti(type)),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              decoration: BoxDecoration(
                color: _getBackgroundColor2(type),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4), // 影の位置
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "得意なこと",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(goodMbti(type)),
                  const Divider(
                    color: Color.fromARGB(255, 49, 45, 45),
                  ),
                  Text(
                    "苦手なこと",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(badMbti(type)),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 249, 249, 249), // 背景色,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4), // 影の位置
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '相性が',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '最高',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'なMBTI  :   ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: _getBackgroundColor2(bestMBTI),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: buildMBTIItem2(context, bestMBTI)),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '相性が',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '最悪',
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      const Color.fromARGB(255, 36, 131, 209),
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'なMBTI   :   ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: _getBackgroundColor2(worstMBTI),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: buildMBTIItem2(context, worstMBTI)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              decoration: BoxDecoration(
                color: _getBackgroundColor2(type),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4), // 影の位置
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$typeの有名人",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 49, 45, 45),
                  ),
                  Text(
                    famousMBTI(type),
                  ),
                ],
              ),
            ),
//            Image.asset(
//              "assets/image1.png",
//              height: 100,
//              width: 100,
//            )
          ],
        ),
      ),
    );
  }

  Widget buildMBTIItem(BuildContext context, String type, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MBTIDetailPage(type: type, description: description),
          ),
        );
      },
      child: Text(
        '$type（$description）',
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget buildMBTIItem2(BuildContext context, String type) {
    Map<String, String> typeToDescription = {
      "INTJ": "建築家",
      "INTP": "論理学者",
      "ENTJ": "指揮官",
      "ENTP": "討論者",
      "INFJ": "提唱者",
      "INFP": "仲介者",
      "ENFJ": "主人公",
      "ENFP": "広報運動家",
      "ISTJ": "管理者",
      "ISFJ": "擁護者",
      "ESTJ": "幹部",
      "ESFJ": "領事官",
      "ISTP": "巨匠",
      "ISFP": "冒険者",
      "ESTP": "起業家",
      "ESFP": "エンターテイナー",
    };
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MBTIDetailPage(
                  type: type, description: typeToDescription[type] ?? ""),
            ),
          );
        },
        child: Text(
          type,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ));
  }
}
