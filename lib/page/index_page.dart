import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'member_page.dart';
import 'home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottombars = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("首页")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text("分类")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text("购物车")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text("会员中心")),
  ];

  final List<Widget> tabBodis = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  int currentIndex = 0;

  var currentpage;

  @override
  void initState() {
    currentpage = tabBodis[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: bottombars,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              currentpage = tabBodis[index];
            });
          },
        ),
        body: IndexedStack(index: currentIndex, children: tabBodis));
  }
}
