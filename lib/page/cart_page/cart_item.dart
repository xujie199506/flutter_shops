import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cartinfo.dart';
import './cart_count.dart';
import 'package:provide/provide.dart';
import '../../provide/CartProvide.dart';
import '../../routers/application.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;

  CartItem(this.item);
  @override
  Widget build(BuildContext context) {
    print(item);
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 1),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _cartCheckBt(context, item),
          _cartImage(item),
          _cardGoodsName(context, item),
          _cartPrice(context)
        ],
      ),
    );
  }

//多选按钮
  Widget _cartCheckBt(context, item) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: ((bool val) {
          print(val);
          item.isCheck = val;
          Provide.value<CartProvide>(context).changeCheckState(item);
        }),
      ),
    );
  }

  //商品图片
  Widget _cartImage(item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.all(3),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Image.network(item.images),
    );
  }

  Widget _cardGoodsName(context, item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Application.router
                  .navigateTo(context, "/detail?id=${item.goodsId}");
            },
            child: Text(item.goodsName),
          ),
          CartConut(item),
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice(context) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () async {
                await Provide.value<CartProvide>(context)
                    .deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete,
                color: Colors.black12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
