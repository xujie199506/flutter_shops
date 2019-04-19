import 'package:flutter/material.dart';
import '../model/CategoryBigModel.dart';

class ChilCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  getChildCateGory(List<BxMallSubDto> list) {
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = '';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList..addAll(list);
    notifyListeners();
  }
}
