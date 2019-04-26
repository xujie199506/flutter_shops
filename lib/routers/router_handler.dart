import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../page/details_page.dart';

Handler detailsHandlers = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;
  print('goodsid: ${goodsId}');
  return DetailsPage(goodsId);
});
