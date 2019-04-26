import 'package:flutter/material.dart';
import '../provide/details_info.dart';
import 'package:provide/provide.dart';
import './details_page/details_top_area.dart';
import './details_page/details_explans.dart';
import './details_page/details_tabbar.dart';
import './details_page/details_web.dart';
import './details_page/datails_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goodsid;
  DetailsPage(this.goodsid);

  @override
  Widget build(BuildContext context) {
    _getBackInfo(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("商品详情页"),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExplan(),
                      DetailsTabbar(),
                      DetailsWeb()
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailsBottom(),
                )
              ],
            );
          } else {
            return Text('加载中。。。');
          }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfo>(context).getGoodsInfo(goodsid);
    print('加载完成。。。');
    return '完成加载';
  }
}
