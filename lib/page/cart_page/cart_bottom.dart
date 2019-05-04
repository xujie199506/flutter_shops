import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/CartProvide.dart';
import 'package:provide/provide.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<CartProvide>(
      builder: (context, child, val) {
        return Container(
          padding: EdgeInsets.all(5),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              selectAllBtn(context),
              allPriceArea(context),
              goButton(context)
            ],
          ),
        );
      },
    );
  }

  Widget selectAllBtn(context) {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            activeColor: Colors.red,
            value: Provide.value<CartProvide>(context).isAllCheck,
            onChanged: (val) {
              Provide.value<CartProvide>(context).changeAllCheckState(val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  Widget allPriceArea(context) {
    num allPrice = Provide.value<CartProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(240),
                child: Text(
                  '合计：',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(190),
                child: Text(
                  '￥${allPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36), color: Colors.red),
                ),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(400),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(22),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget goButton(context) {
    num allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: ScreenUtil().setHeight(90),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3.0)),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
