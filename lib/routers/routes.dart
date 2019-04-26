import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './router_handler.dart';

class Routes {
  static String root = '/';
  static String detailspage = '/detail';
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> paramss) {
      print('error ==>route notFoundHandler');
    });
    router.define(detailspage, handler: detailsHandlers);
  }
}
