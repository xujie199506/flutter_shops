import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import '../config/service_url.dart';
import 'dart:convert';

class DetailsInfo with ChangeNotifier {
  DetailsModle goodsinfo = null;

  bool isLeft = true;
  bool isRight = false;

  //tabBar的切换方法
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

  //从后台获取数据
  getGoodsInfo(String id) async {
    var formData = {'goodId': id};
    await request(servicePath['getGoodDetailById'], formdata: formData)
        .then((val) {
      var responseData = json.decode(val.toString());
      print(responseData);
      goodsinfo = DetailsModle.fromJson(responseData);
      notifyListeners();
    });
  }
}
