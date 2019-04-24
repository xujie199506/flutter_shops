import 'package:flutter/material.dart';
import '../model/CateroryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<Data> childCategoryList = [];
  int getGoodsList(List<Data> list) {
    childCategoryList = list;
    notifyListeners();
  }

  int addGoodsList(List<Data> list) {
    childCategoryList.addAll(list);
    notifyListeners();
  }
}
