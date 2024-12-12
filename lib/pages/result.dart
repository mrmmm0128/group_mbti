import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final int totalrank;
  ResultScreen({required this.totalrank});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MBTI研究所"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 221, 123, 94),
      ),
      body: Center(
        child: Padding(
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
                widget.totalrank.toString(),
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              const SizedBox(height: 32),

              // レーダーチャート部分（仮）
              Container(
                height: 200,
                width: 200,
                color: const Color.fromARGB(255, 221, 123, 94),
                child: const Center(
                  child: Text(
                    "レーダーチャート",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // キャッチコピー部分
              const Text(
                "〜なグループ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // 説明文部分
              const Text(
                "このグループは〜な人が多い。\n〜な人が不足。\nINTJの方がプランを考えることが多いでしょう。",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
