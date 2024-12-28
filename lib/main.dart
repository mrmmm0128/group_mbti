import 'package:app_base/pages/book_page.dart';
import 'package:flutter/material.dart';
import 'pages/explain.dart';
import 'pages/mbti_group.dart';
import 'pages/easy_check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
  @override
  final List<Widget> _pages = [
    Explain(),
    MBTIScreen(),
    EasyCheck(),
    Center(
      child: Text(
        "comming soon!",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MBTIグループ診断'),
        backgroundColor: Color.fromARGB(255, 207, 207, 207),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline_outlined),
            label: '使い方',
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
        backgroundColor: const Color.fromARGB(255, 179, 179, 179),
        enableFeedback: true,
        // IconTheme系統の値が優先されます。
        iconSize: 18,
        // 横向きレイアウトは省略します。
        // landscapeLayout: 省略
        selectedFontSize: 20,
        selectedIconTheme:
            const IconThemeData(size: 30, color: Color.fromARGB(255, 0, 0, 0)),
        selectedLabelStyle: const TextStyle(color: Colors.red),
        // ちなみに、LabelStyleとItemColorの両方を選択した場合、ItemColorが勝ちます。
        selectedItemColor: Colors.black,
        unselectedFontSize: 15,
        unselectedIconTheme: const IconThemeData(
            size: 25, color: Color.fromARGB(255, 255, 255, 255)),
        unselectedLabelStyle: const TextStyle(color: Colors.purple),
        // IconTheme系統の値が優先されるのでこの値は適応されません。
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
