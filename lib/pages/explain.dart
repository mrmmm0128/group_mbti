import 'package:app_base/pages/mbti_pages/mbti_detail.dart';
import 'package:flutter/material.dart';

class Explain extends StatelessWidget {
  const Explain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 239, 239), // 背景色
        body: SingleChildScrollView(
            // ここでスクロールを有効にする
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 左寄せ
              children: [
                const SizedBox(height: 16),
                const Text(
                  'MBTI 一覧',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                const Text("MBTIをタップすると詳しい情報が見れるよ"),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 217, 189, 224),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // 影の色
                        spreadRadius: 2, // 影の広がり
                        blurRadius: 5, // ぼかしの強さ
                        offset: Offset(0, 2), // 影の位置
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '分析家',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                          "戦略的な思考と論理的なアプローチを得意とする人たち、物事の本質を見抜き、知識を深める深めることに生きがいを感じる。"),
                      Divider(
                        color: Color.fromARGB(255, 31, 29, 29),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'INTJ', '建築家'),
                          ),
                          const SizedBox(
                            width: 16, // 最小限のスペースを確保
                          ),
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'INTP', '論理学者'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'ENTJ', '指揮官'),
                          ),
                          const SizedBox(
                            width: 16, // 最小限のスペースを確保
                          ),
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'ENTP', '討論者'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Diplomats Group
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 187, 232, 197),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // 影の色
                        spreadRadius: 2, // 影の広がり
                        blurRadius: 5, // ぼかしの強さ
                        offset: Offset(0, 2), // 影の位置
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '外交官',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                          "人とのつながりや理想を大切にする人たち、他者の感情に敏感で、相手を深く理解しようとする姿勢が特徴。"),
                      Divider(
                        color: Color.fromARGB(255, 31, 29, 29),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'INFJ', '提唱者'),
                          ),
                          const SizedBox(
                            width: 16, // 最小限のスペースを確保
                          ),
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'INFP', '仲介者'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'ENFJ', '主人公'),
                          ),
                          const SizedBox(
                            width: 16, // 最小限のスペースを確保
                          ),
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'ENFP', '広報運動家'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Sentinels Group
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 191, 220, 245),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // 影の色
                        spreadRadius: 2, // 影の広がり
                        blurRadius: 5, // ぼかしの強さ
                        offset: Offset(0, 2), // 影の位置
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '番人',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                          "責任感が強く、秩序や組織を大切にする人たち、献身的に行動し、周りの人々が安心して頼れる存在。"),
                      Divider(
                        color: Color.fromARGB(255, 31, 29, 29),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'ISTJ', '管理者'),
                          ),
                          const SizedBox(
                            width: 16, // 最小限のスペースを確保
                          ),
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'ISFJ', '擁護者'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'ESTJ', '幹部'),
                          ),
                          const SizedBox(
                            width: 16, // 最小限のスペースを確保
                          ),
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'ESFJ', '領事官'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Explorers Group
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 248, 232, 175),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // 影の色
                        spreadRadius: 2, // 影の広がり
                        blurRadius: 5, // ぼかしの強さ
                        offset: Offset(0, 2), // 影の位置
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '探検家',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                          "自由で柔軟な発想を持つ人たち、予測不能な状況にも素早く対応でき、今を最大限楽しむことに情熱を注ぐ。"),
                      const Divider(
                        color: Color.fromARGB(255, 31, 29, 29),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'ISTP', '巨匠'),
                          ),
                          const SizedBox(
                            width: 16, // 最小限のスペースを確保
                          ),
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'ISFP', '冒険者'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'ESTP', '起業家'),
                          ),
                          const SizedBox(
                            width: 16, // 最小限のスペースを確保
                          ),
                          Expanded(
                            flex: 1,
                            child: buildMBTIItem(context, 'ESFP', 'エンターテイナー'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ]),
        )));
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
}

//buildMBTIItem(context, 'INTJ', '建築家'),
//buildMBTIItem(context, 'INTP', '論理学者'),
//buildMBTIItem(context, 'ENTJ', '指揮官'),
//buildMBTIItem(context, 'ENTP', '討論者'),
//buildMBTIItem(context, 'INFJ', '提唱者'),
//                      buildMBTIItem(context, 'INFP', '仲介者'),
//                      buildMBTIItem(context, 'ENFJ', '主人公'),
//                      buildMBTIItem(context, 'ENFP', '広報者'),
//buildMBTIItem(context, "ISTJ", "管理者"),
//                      buildMBTIItem(context, "ISFJ", "擁護者"),
//                      buildMBTIItem(context, "ESTJ", "幹部"),
//                      buildMBTIItem(context, "ESFJ", "領事官"),
