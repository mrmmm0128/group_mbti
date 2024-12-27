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
    "他人と関わるのが楽しいと感じますか？",
    "自分の考えをよく深く掘り下げますか？",
  ];

  // 回答の保存用マップ
  final Map<int, String> answers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("簡単MBTI診断"),
        backgroundColor: const Color.fromARGB(255, 221, 221, 221),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
              onPressed: () {
                // 結果を計算して表示
                String result = calculateMBTI(answers);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("診断結果"),
                    content: Text("あなたのMBTIは $result です！"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("閉じる"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("診断"),
            ),
          ],
        ),
      ),
    );
  }
}
