import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'page/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods.dart';

void main() {
  var counter = Counter();
  var provides = Providers();
  var chilCategory = ChilCategory();
  var categoryGoodsList = CategoryGoodsListProvide();
  provides
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChilCategory>.value(chilCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList));

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
