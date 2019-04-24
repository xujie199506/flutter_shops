import 'package:flutter/material.dart';
import '../model/CategoryBigModel.dart';

class ChilCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  getChildCateGory(List<BxMallSubDto> list, String id) {
    page = 1;
    noMoreText = '';

    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.comments = '';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList..addAll(list);
    childIndex = 0;
    categoryId = id;
    notifyListeners();
  }

  int childIndex = 0;
  changeChildIndex(index, id) {
    page = 1;
    noMoreText = '';
    childIndex = index;
    subId = id;
    notifyListeners();
  }

  //增加page的方法
  addPage() {
    page++;
    notifyListeners();
  }

  changenoMoreText(String text) {
    noMoreText = text;
    notifyListeners();
  }

  String categoryId = "4";
  String subId = "";
  int page = 1;
  String noMoreText = '';
}
