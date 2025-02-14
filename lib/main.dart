import 'package:app_base/components/ad_mob.dart';
import 'package:app_base/firebase_options.dart';
import 'package:app_base/pages/mbti_history.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'pages/explain.dart';
import 'pages/mbti_group.dart';
import 'pages/easy_check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
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
  final AdMobManager _adMobManager = AdMobManager();
  int _selectedIndex = 1;
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

  @override
  void initState() {
    super.initState();
    _adMobManager.loadAd(); // 広告のロード
  }

  @override
  void dispose() {
    _adMobManager.dispose(); // 広告リソースの解放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          "assets/MBTI2.png",
          width: 45,
        ),
        leadingWidth: 65,
        title: const Text('グループ相性診断'),
        backgroundColor: Color.fromARGB(255, 207, 207, 207),
        shadowColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _pages[_selectedIndex],
          ),
          _adMobManager.getAdWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: '一覧',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            activeIcon: Icon(Icons.business_center),
            label: '診断',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '性格タイプ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '履歴',
          ),
        ],
        // ここで色を設定していても、shiftingにしているので
        // Itemの方のbackgroundColorが勝ちます。
        backgroundColor: const Color.fromARGB(255, 207, 207, 207),

        enableFeedback: true,
        // IconTheme系統の値が優先されます。
        iconSize: 20,
        // 横向きレイアウトは省略します。
        // landscapeLayout: 省略
        selectedFontSize: 12,
        selectedIconTheme:
            const IconThemeData(size: 30, color: Color.fromARGB(255, 0, 0, 0)),
        selectedLabelStyle: const TextStyle(color: Colors.red),
        // ちなみに、LabelStyleとItemColorの両方を選択した場合、ItemColorが勝ちます。
        selectedItemColor: Colors.black,
        unselectedFontSize: 12,
        unselectedIconTheme: const IconThemeData(
            size: 25, color: Color.fromARGB(255, 255, 255, 255)),
        unselectedLabelStyle: const TextStyle(color: Colors.purple),
        // IconTheme系統の値が優先されるのでこの値は適応されません。
        //unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
