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
                '1. 名前とMBTIを入力しましょう',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '診断ページから、グループ全員の名前とMBTIを入力してください。\nもしMBTIがわからない方がいれば、MBTIページからたった4問の質問に答えるだけで、簡易的にMBTI診断を行うことができます。',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                '2. 診断しよう',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '診断ボタンを押して、グループの相性を診断しましょう。',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                '3. 結果を見てみよう',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '診断が終わると、グループの点数（100点満点）やレーダーチャート、個人間の相性など様々なデータが確認できます。\n自分たちのグループをMBTIの観点から診断した結果を見て、みんなで盛り上がりましょう！',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'さあ、診断ページへ GO！',
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
