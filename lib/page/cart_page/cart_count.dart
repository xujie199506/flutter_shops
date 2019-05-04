import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/CartProvide.dart';

class CartConut extends StatelessWidget {
  var item;
  CartConut(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _reduceBtn(item, context),
          _countArea(item),
          _addBtn(item, context),
        ],
      ),
    );
  }

  //减少按钮
  Widget _reduceBtn(item, context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addorReduceAction(item, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.count > 1 ? Colors.white : Colors.black12,
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: Text('-'),
      ),
    );
  }

  //减少按钮
  Widget _addBtn(item, context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addorReduceAction(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        child: Text('+'),
        decoration: BoxDecoration(
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
      ),
    );
  }

  //显示区域
  Widget _countArea(item) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }
}
