import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartinfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> cartList = [];

  num allPrice = 0;
  num allGoodsCount = 0;
  bool isAllCheck = true; //是否全选

  save(goodsId, goodsName, count, price, image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    var ishave = false;
    int ival = 0;
    allGoodsCount = 0;
    allPrice = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        ishave = true;
      }
      if (item['isCheck']) {
        allPrice += (cartList[ival].price * cartList[ival].count);
        allGoodsCount += cartList[ival].count;
      }
      ival++;
    });

    if (!ishave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'isCheck': true,
        'images': image
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
    }
    cartString = json.encode(tempList).toString();
    print('字符串》》》》》' + cartString);

    prefs.setString('cartInfo', cartString);

    allPrice += (count * price);
    allGoodsCount += count;
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = [];
    notifyListeners();
  }

  getCartInfo() async {
    cartList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    isAllCheck = true;
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartList.add(CartInfoModel.fromJson(item));
      });
    }

    print('--------------------------${cartString}');
    notifyListeners();
  }

  //删除单个购物车商品
  deleteOneGoods(String goodsId) async {
    cartList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int deIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        deIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList.removeAt(deIndex);
    cartString = jsonEncode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    getCartInfo();
  }

  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int changeIndex = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();

    cartString = jsonEncode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    getCartInfo();
  }

  //点击全选按钮操作
  changeAllCheckState(bool isAllSelectCheck) async {
    isAllCheck = isAllSelectCheck;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    tempList.forEach((item) {
      item['isCheck'] = isAllSelectCheck;
    });

    cartString = jsonEncode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    getCartInfo();
  }

  //商品数量加减
  addorReduceAction(var cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int changeIndex = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();

    cartString = jsonEncode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    getCartInfo();
  }
}
