import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

//获取首页主页内容  大括号表示可选参数
Future request(url, {formdata}) async {
  print("开始获取数据${url}");
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");

    if (formdata == null) {
      response = await dio.post(url);
    } else {
      print("开始获取数据");
      response = await dio.post(url, data: formdata);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("后端接口出现异常");
    }
  } catch (e) {
    return print("err=====>" + e);
  }
}

//获取首页主页内容
Future getHomePageContent() async {
  print("开始获取主页数据");
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("后端接口出现异常");
    }
  } catch (e) {
    return print("err=====>" + e);
  }
}

//获取首页火爆专区数据
Future getHomePageBelowConten() async {
  print("开始获取火爆专区数据");
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    int page = 1;
    response = await dio.post(servicePath['homePaeBelowConten'], data: page);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("后端接口出现异常");
    }
  } catch (e) {
    return print("err=====>" + e);
  }
}
