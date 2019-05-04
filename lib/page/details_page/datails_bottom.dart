import 'package:flutter/material.dart';
import '../../provide/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/CartProvide.dart';
import 'package:provide/provide.dart';
import '../../provide/CurrentIndex.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsinfo = Provide.value<DetailsInfo>(context).goodsinfo.data.goodInfo;

    var goodsId = goodsinfo.goodsId;
    var goodsName = goodsinfo.goodsName;
    var count = 1;
    var price = goodsinfo.presentPrice;
    var image = goodsinfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () async {
                  Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: ScreenUtil().setWidth(110),
                  height: ScreenUtil().setHeight(80),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Colors.red,
                  ),
                ),
              ),
              Provide<CartProvide>(
                builder: (context, child, val) {
                  int goodsCount =
                      Provide.value<CartProvide>(context).allGoodsCount;
                  return Positioned(
                    top: 0,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        '${goodsCount}',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(22),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          InkWell(
            onTap: () async {
              print('加入购物车');
              await Provide.value<CartProvide>(context)
                  .save(goodsId, goodsName, count, price, image);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(28)),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.red,
              child: Text(
                '立即购买',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(28)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
