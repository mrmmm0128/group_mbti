import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import '/model/evaluation_group.dart';
import 'package:share_plus/share_plus.dart';

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
    "P": "予測不可能 思いつきで進む冒険者", // P
    "N": "先見の明あり 発明家集団", // N
    // 重複がある場合、ランダムで返す場合の処理は別途実装する。
  };

  //このグループは〜な人が多い
  final Map<String, String> valueComment2 = const {
    "T": "論理的で現実的な思考を持ち、効率を重視する",
    "I": "内向的で深く考えるのが得意な集団",
    "J": "計画的で秩序を重んじる紳士な集団",
    "E": "社交的で常にエネルギッシュに振る舞う",
    "S": "現実的で実務に強く、具体的な行動を好む",
    "F": "感情豊かで他者への配慮に優れたグループ",
    "P": "柔軟で臨機応変に行動する冒険心あふれる集団",
    "N": "想像力豊かで新しいアイデアを考えるのが得意",
  };

  //このグループは〜な人が足りない
  final Map<String, String> valueComment3 = const {
    "T": "論理的で効率的な思考を持つ人が不足",
    "I": "内向的で深く考えるタイプの人が不足",
    "J": "計画的で秩序を重んじる人が不足",
    "E": "社交的でエネルギッシュな人が不足",
    "S": "現実的で実務に強い人が不足",
    "F": "感情豊かで他者への配慮ができる人が不足",
    "P": "柔軟に対応する冒険心あふれる人が不足",
    "N": "新しいアイデアを考える創造的な人が不足",
  };

  final List<String> pairsValue = const [
    "実は不仲",
    "ヨッ友レベル",
    "仲良し！",
    "親友レベル",
    "最高の理解者"
  ];

  final Map<String, String> roleComment = const {
    "INTJ": "論理的で現実的な思考を持ち、効率を重視する人が多い。計画を立て、長期的な視点で物事を進めるリーダータイプ。",
    "ENTJ": "ビジョンを描き、チームを牽引するリーダー。目標達成のための戦略を考え、実行力が高い。",
    "INFJ": "洞察力があり、他者を深く理解することが得意。理想を追求し、周囲を感化する指導者。",
    "ENFJ": "共感力が高く、周囲の人々を支えるカリスマ的リーダー。人間関係を重視し、調和を作り出す。",
    "INTP": "探求心旺盛で、新しいアイデアや概念を追求する知識人。問題解決に独自の視点を提供する。",
    "ENTP": "創造力が豊かで、常に新しい可能性を探るアイデアマン。議論や挑戦を楽しむ。",
    "INFP": "価値観を大切にし、内面的な調和を求める理想主義者。他者に寄り添い、思いやりを示す。",
    "ENFP": "自由奔放で、創造的なエネルギーを持つムードメーカー。人々を励まし、楽しい雰囲気を作り出す。",
    "ISTJ": "責任感が強く、規律を重んじる実直な実務家。着実にタスクを遂行し、信頼される存在。",
    "ESTJ": "組織をまとめ、効率的に物事を進める管理者。ルールを重視し、計画を実行するリーダー。",
    "ISFJ": "思いやりがあり、他者を支えることに喜びを感じる献身的な支援者。安定を提供する。",
    "ESFJ": "他者を気遣い、調和を重視するサポーター。チーム内の雰囲気を明るくし、人間関係を強化する役割を果たす。",
    "ISTP": "現実的で問題解決能力に優れる実践派。冷静な判断力で、状況に応じて柔軟に対応する。",
    "ESTP": "行動力があり、即座に状況に対応できるアクション派。周囲を巻き込むエネルギッシュな存在。",
    "ISFP": "感受性が豊かで、美的感覚に優れるアーティストタイプ。静かに他者を支え、柔軟に対応する。",
    "ESFP": "エネルギッシュで楽しい雰囲気を作り出すムードメーカー。即興力があり、臨機応変に動ける柔軟性を持つ。"
  };

  Widget displayRoles(Map<String, String> personMBTIs) {
    return Column(
      children: personMBTIs.entries.map((entry) {
        final name = entry.key;
        final mbti = entry.value;
        final roleDescription = roleComment[mbti] ?? "役割情報が見つかりません。";

        return Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10), // 外側の余白
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10), // 内側の余白
          decoration: BoxDecoration(
            color: _getBackgroundColor2(mbti), // 背景色
            borderRadius: BorderRadius.circular(16), // 角を丸く
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15), // 優しい影
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(color: Colors.grey.shade300), // ボーダー
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$name : $mbti",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(
                height: 5,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
              Text(
                roleDescription,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

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
    final String shareLink =
        "https://apps.apple.com/jp/app/mbti%E3%81%AB%E3%82%88%E3%82%8B%E3%82%B0%E3%83%AB%E3%83%BC%E3%83%97%E7%9B%B8%E6%80%A7%E8%A8%BA%E6%96%AD/id6739538706";
    List<String> names = widget.NameAndMbti.keys.toList();
    String rank = widget.totalrank.toString();
    String formatMembers(Map<String, String> members) {
      // 各キーと値を "キー：値" の形式に変換してリストにする
      List<String> formattedMembers = members.entries.map((entry) {
        return "${entry.key}：${entry.value}";
      }).toList();

      // 改行で結合して1つの文字列にする
      return formattedMembers.join("\n");
    }

    String sharemenbers = formatMembers(widget.NameAndMbti);
    // indexに基づいてコメントを選択

    return Scaffold(
      appBar: AppBar(
        title: const Text("MBTIグループ診断"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 214, 214, 214),
        elevation: 4,
        shadowColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // 共有する内容
              String shareText =
                  "あなたたちのグループ相性を診断しました！\n\n診断したメンバー \n $sharemenbers\n診断結果 $rank 点\n\nさらに詳しい情報が知りたい方はアプリをインストール！ \n$shareLink";
              const subject = "結果を共有しましょう";

              // 共有機能を呼び出し
              Share.share(shareText, subject: subject);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // スコア部分
              const SizedBox(
                height: 20,
              ),
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
              SizedBox(
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
                valueComment2[countAndSortMBTILetters(widget.NameAndMbti)[1]] ??
                    "良いグループですね",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                valueComment3[
                        countAndSortMBTILetters(widget.NameAndMbti).last] ??
                    "良いグループですね",
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
              ..._generatePairs(names).asMap().map((index, pair) {
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
                      border: Border.all(color: Colors.grey.shade300), // ボーダー
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
                            pairsValue[
                                5 - widget.compatibilityScores[index]], // スコアの値
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
              }).values,
              SizedBox(
                height: 10,
              ),
              const Divider(
                height: 20,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
              const Text(
                "グループでの役割",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              displayRoles(
                widget.NameAndMbti,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
