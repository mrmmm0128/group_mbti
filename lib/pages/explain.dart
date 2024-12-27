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
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 左寄せ
            children: [
              const SizedBox(height: 16),
              const Text(
                'MBTIで複数人のグループの相性を診断しましょう！',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              const Text(
                '1. グループ名を入力しよう',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'みんなで割り勘を利用するメンバーのグループ名を入力しましょう！\n',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'さあ、お金の不安をなくして友達、家族と楽しい時間を過ごそう！',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
