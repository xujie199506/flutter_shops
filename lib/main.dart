import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'page/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';

void main() {
  var counter = Counter();
  var provides = Providers();
  var chilCategory = ChilCategory();
  provides
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChilCategory>.value(chilCategory));

  runApp(ProviderNode(child: MyApp(), providers: provides));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: "百姓生活+",
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
