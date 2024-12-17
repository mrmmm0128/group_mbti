import 'package:flutter/material.dart';
import 'package:group_mbti/firebase_options.dart';
import 'package:group_mbti/pages/input_mbti.dart';
import 'package:group_mbti/pages/mbti_group.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MBTIでグループ分け',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // ルーティングの設定
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // URLパスを取得
        final uri = Uri.parse(settings.name ?? '');
        if (uri.pathSegments[0] == "Artist") {
          // Artist を含む場合、InputMBTIScreen に遷移
          return MaterialPageRoute(
            builder: (context) => inputMBTIScreen(),
          );
        }

        // デフォルトは MBTIScreen
        return MaterialPageRoute(
          builder: (context) => inputMBTIScreen(),
        );
      },
    );
  }
}
