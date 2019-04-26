import 'package:flutter/material.dart';
import '../../provide/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsExplan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(10.0),
      child: Text(
        '说明 > 急速送达 > 正品保证',
        style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }
}
