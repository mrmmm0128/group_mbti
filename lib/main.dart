import 'package:app_base/firebase_options.dart';
import 'package:app_base/pages/mbti_history.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/explain.dart';
import 'pages/mbti_group.dart';
import 'pages/easy_check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Explain(),
    MBTIScreen(),
    EasyCheck(),
    GroupListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline_outlined),
            label: '一覧',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            activeIcon: Icon(Icons.business_center),
            label: '診断',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'MBTI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '履歴',
          ),
        ],
        // ここで色を設定していても、shiftingにしているので
        // Itemの方のbackgroundColorが勝ちます。
        backgroundColor: const Color.fromARGB(255, 254, 254, 254),
        enableFeedback: true,
        // IconTheme系統の値が優先されます。
        iconSize: 20,
        // 横向きレイアウトは省略します。
        // landscapeLayout: 省略
        selectedFontSize: 15,
        selectedIconTheme:
            const IconThemeData(size: 30, color: Color.fromARGB(255, 0, 0, 0)),
        selectedLabelStyle: const TextStyle(color: Colors.red),
        // ちなみに、LabelStyleとItemColorの両方を選択した場合、ItemColorが勝ちます。
        selectedItemColor: Colors.black,
        unselectedFontSize: 12,
        unselectedIconTheme: const IconThemeData(
          size: 25,
          color: Colors.black,
        ),
        unselectedLabelStyle: const TextStyle(color: Colors.purple),
        // IconTheme系統の値が優先されるのでこの値は適応されません。
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
