import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String goodsid;
  DetailsPage(this.goodsid);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("商品：${goodsid}"),
      ),
    );
  }
}
