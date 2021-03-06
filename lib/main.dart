import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'page/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods.dart';
import 'package:fluro/fluro.dart';
import './routers/routes.dart';
import './routers/application.dart';
import './provide/details_info.dart';
import './provide/CartProvide.dart';
import './provide/CurrentIndex.dart';

void main() {
  var counter = Counter();
  var provides = Providers();
  var chilCategory = ChilCategory();
  var categoryGoodsList = CategoryGoodsListProvide();
  var detailsInfo = DetailsInfo();
  var crtProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();

  provides
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChilCategory>.value(chilCategory))
    ..provide(Provider<DetailsInfo>.value(detailsInfo))
    ..provide(Provider<CartProvide>.value(crtProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList));

  runApp(ProviderNode(child: MyApp(), providers: provides));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = new Router();

    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: "百姓生活+",
        onGenerateRoute: Application.router.generator,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
