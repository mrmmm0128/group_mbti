import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import '/model/evaluation_group.dart';

class ResultScreen extends StatefulWidget {
  final int totalrank;
  final List<int> chartValue;
  final int index;
  final Map<String, String> NameAndMbti;
  final List<int> compatibilityScores;

  ResultScreen({
    required this.totalrank,
    required this.chartValue,
    required this.index,
    required this.NameAndMbti,
    required this.compatibilityScores,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // constリストの定義
  //一番多かった型で算出
  final Map<String, String> valueComment = const {
    "T": "超理論派の完璧主義者たち", // T が一番多い
    "I": "心の中でだけ喋る集団", // I
    "J": "計画性の鬼集団", // J
    "E": "休む暇なく動き続ける集団", // E
    "S": "現実を見据えたリアリスト集団", // S
    "F": "配慮が溢れる思いやり集団", // F
    "P": "予測不可能 思いつきで進む冒険者たち", // P
    "N": "先見の明あり 発明家集団", // N
    // 重複がある場合、ランダムで返す場合の処理は別途実装する。
  };

  //このグループは〜な人が多い
  final List<String> valueComment2 = const [
    "", //
    "",
    "",
    "",
    "",
    "",
  ];

  //このグループは〜な人が足りない
  final List<String> valueComment3 = const [
    "", //
    "",
    "",
    "",
    "",
    "",
  ];

  final List<String> pairsValue = const [
    "実は不仲",
    "ヨッ友レベル",
    "仲良し！",
    "親友レベル",
    "最高の理解者"
  ];

  Color _getBackgroundColor(int index) {
    // 背景色のパレット
    List<Color> colors = [
      Colors.red[100]!,
      Colors.orange[100]!,
      Colors.yellow[100]!,
      Colors.green[100]!,
      Colors.blue[100]!
    ];

    // インデックスによって色を切り替える
    return colors[index % colors.length];
  }

  @override
  void initState() {
    super.initState();
  }

  List<List<String>> _generatePairs(List<String> names) {
    List<List<String>> pairs = [];

    for (int i = 0; i < names.length; i++) {
      for (int j = i + 1; j < names.length; j++) {
        pairs.add([names[i], names[j]]);
      }
    }

    return pairs;
  }

  @override
  Widget build(BuildContext context) {
    List<String> names = widget.NameAndMbti.keys.toList();
    // indexに基づいてコメントを選択

    return Scaffold(
      appBar: AppBar(
        title: const Text("MBTI研究所"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 221, 123, 94),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // スコア部分
              const Text(
                "あなたたちのグループは...",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                widget.totalrank.toString() + "点 !",
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              const SizedBox(height: 32),

              // レーダーチャート部分（仮）
              Container(
                height: 300,
                width: 300,
                child: RadarChart.light(
                  ticks: const [1, 2, 3, 4, 5], // レーダーチャートの段階（最小〜最大値）
                  features: const [
                    "社交性",
                    "問題解決力",
                    "創造性",
                    "仲の良さ",
                    "協調性",
                    "責任感"
                  ], // 項目名

                  data: [
                    widget.chartValue, // chartValue リストを直接渡す
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // キャッチコピー部分
              Text(
                valueComment[countAndSortMBTILetters(widget.NameAndMbti)[0]] ??
                    "特に特徴のないグループ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24, // 文字サイズを少し大きく
                  fontWeight: FontWeight.w600, // ボールドすぎないが目を引く
                  color: Colors.red, // 落ち着いた色調の紫を使用
                  letterSpacing: 1.3, // 文字間隔を少し広げて読みやすく
                ),
              ),
              const SizedBox(height: 16),

              // 説明文部分
              Text(
                //valueComment2[0],
                "valueComment２から引用してくる",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
              const Divider(
                height: 20,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
              const Text(
                "個人間の相性",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              ..._generatePairs(names)
                  .asMap()
                  .map((index, pair) {
                    return MapEntry(
                      index,
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10), // 外側の余白
                        padding: EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10), // 内側の余白
                        decoration: BoxDecoration(
                          color: Colors.white, // 背景色
                          borderRadius: BorderRadius.circular(16), // 角を丸く
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15), // 優しい影
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                          border:
                              Border.all(color: Colors.grey.shade300), // ボーダー
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween, // 左右に要素を配置
                          children: [
                            // 左側のテキスト
                            Expanded(
                              child: Text(
                                '${pair[0]} と ${pair[1]}', // ペアの名前
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade800, // 落ち着いた色
                                ),
                                textAlign: TextAlign.center, // 左揃え
                              ),
                            ),
                            // スコア
                            Container(
                              width: 130,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: _getBackgroundColor(
                                    widget.compatibilityScores[index] -
                                        1), // 動的な背景色
                                borderRadius:
                                    BorderRadius.circular(10), // スコア部分の角を丸く
                              ),
                              child: Text(
                                pairsValue[5 -
                                    widget.compatibilityScores[index]], // スコアの値
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                  .values
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
