import 'package:flutter/material.dart';
import '../../provide/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfo>(
      builder: (context, child, val) {
        if (Provide.value<DetailsInfo>(context).goodsinfo != null) {
          var goodInfo =
              Provide.value<DetailsInfo>(context).goodsinfo.data.goodInfo;

          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodInfo.image1),
                _goodsname(goodInfo.goodsName),
                _goodsNum(goodInfo.goodsSerialNumber),
                Row(
                  children: <Widget>[
                    _goodsPresentPrice(goodInfo.presentPrice),
                    _goodsOriPrice(goodInfo.oriPrice)
                  ],
                )
              ],
            ),
          );
        } else {
          return Text('正在加载中');
        }
      },
    );
  }

//商品图片
  Widget _goodsImage(url) {
    return Image.network(url, width: ScreenUtil().setWidth(740));
  }

  //商品名称
  Widget _goodsname(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      margin: EdgeInsets.only(left: 15),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colors.black),
      ),
    );
  }

  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(740),
      margin: EdgeInsets.only(left: 15),
      child: Text(
        '编号：${num}',
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

  Widget _goodsPresentPrice(price) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15),
      child: Text('￥${price}',
          style:
              TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(36))),
    );
  }

  Widget _goodsOriPrice(oriPrice) {
    return Container(
      margin: EdgeInsets.only(left: 25, top: 15),
      child: Row(
        children: <Widget>[
          Text('市场价：'),
          Text('${oriPrice}',
              style: TextStyle(
                  color: Colors.black12,
                  decoration: TextDecoration.lineThrough))
        ],
      ),
    );
  }
}
