import 'package:flutter/material.dart';
import '../../provide/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfo>(
      builder: (context, child, val) {
        bool isLeft = Provide.value<DetailsInfo>(context).isLeft;
        bool isRight = Provide.value<DetailsInfo>(context).isRight;
        return Container(
          margin: EdgeInsets.only(top: 15),
          child: Row(
            children: <Widget>[
              _myTabBarLeft(context, isLeft),
              _myTabBarRight(context, isRight),
            ],
          ),
        );
      },
    );
  }

  Widget _myTabBarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfo>(context).changeLeftAndRight("left");
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(370),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isLeft ? Colors.pink : Colors.black12))),
        child: Text(
          "详情",
          style: TextStyle(color: isLeft ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  Widget _myTabBarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfo>(context).changeLeftAndRight("right");
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(370),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isRight ? Colors.pink : Colors.black12))),
        child: Text(
          "评论",
          style: TextStyle(color: isRight ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}
