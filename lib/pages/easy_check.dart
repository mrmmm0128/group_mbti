import 'package:flutter/material.dart';
import '/model/evaluation_group.dart';

class EasyCheck extends StatefulWidget {
  @override
  _EasyCheckPageState createState() => _EasyCheckPageState();
}

class _EasyCheckPageState extends State<EasyCheck> {
  // 質問リスト
  final List<String> questions = [
    "新しい環境でもすぐに馴染めますか？",
    "計画を立てて行動することが多いですか？",
    "一人よりも友達と過ごすことが好きですか？",
    "自分の考えを掘り下げることが多いですか？",
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

  // 回答の保存用マップ
  final Map<int, String> answers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: AppBar(
        title: const Text("簡単にMBTIを診断しましょう"),
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "4つの質問に答えましょう",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(questions.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Q${index + 1}: ${questions[index]}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: answers[index] == "はい"
                                    ? const Color.fromARGB(255, 89, 178, 250)
                                    : const Color.fromARGB(
                                        255, 235, 235, 235), // 選択状態に応じて色を変更
                              ),
                              onPressed: () {
                                setState(() {
                                  answers[index] = "はい";
                                });
                              },
                              child: const Text(
                                "はい",
                                style: TextStyle(
                                  color: Colors.black, // 文字色を変更
                                  fontWeight: FontWeight.bold, // 文字の強調表示（オプション）
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: answers[index] == "いいえ"
                                    ? const Color.fromARGB(255, 89, 178, 250)
                                    : const Color.fromARGB(
                                        255, 235, 235, 235), // 選択状態に応じて色を変更
                              ),
                              onPressed: () {
                                setState(() {
                                  answers[index] = "いいえ";
                                });
                              },
                              child: const Text(
                                "いいえ",
                                style: TextStyle(
                                  color: Colors.black, // 文字色を変更
                                  fontWeight: FontWeight.bold, // 文字の強調表示（オプション）
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 完了ボタン
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 239, 239, 239),
              ),
              onPressed: () {
                // 結果を計算して表示
                String result = calculateMBTI(answers);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("診断結果"),
                    content: Text("あなたのMBTIは $result です！"),
                    backgroundColor: _getBackgroundColor2(result),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("閉じる"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                "診断",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
