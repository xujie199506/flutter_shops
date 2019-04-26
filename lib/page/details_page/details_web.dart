import 'package:flutter/material.dart';
import '../../provide/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetail =
        Provide.value<DetailsInfo>(context).goodsinfo.data.goodInfo.goodsDetail;
    print(goodsDetail);
    print(goodsDetail);

    return Provide<DetailsInfo>(
      builder: (context, child, val) {
        var isLeft = Provide.value<DetailsInfo>(context).isLeft;

        if (isLeft) {
          return Container(
              child: Html(
            data: goodsDetail,
          ));
        } else {
          return Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(15),
            height: ScreenUtil().setHeight(260),
            child: Text('暂无评论'),
          );
        }
      },
    );
  }
}
