import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// final options = BaseOptions(
//   headers: {'Content-Type': 'application/json'},
// );

class IdApiCall{
  final dio = Dio();
  Future httpPost(String url, dynamic data,dynamic header) async {
    try {
      final response = await dio.post(url, data: data,options: Options(headers: header,));
      return response.data;
    } catch (e) {
      DioError error = e as DioError;
      // print(e.response);
    }
  }

  Future httpGet(String url,dynamic header) async {
    try {
      Response response = await dio.get(url,options: Options(headers: header,));
      return response.data;
    } catch (e) {
      DioError error = e as DioError;
       print(e.response);
    }
  }
  Future httpDelete(String url,dynamic header) async {
    try {
      Response response = await dio.delete(url,options: Options(headers: header,));
      return response.data;
    } catch (e) {
      DioError error = e as DioError;
      print(e.response);
    }
  }
  Future httpUpdate(String url, dynamic data,dynamic header) async{
    try {
      Response response = await dio.patch(url,data:data,options: Options(headers:header,));
      return response.data;
    } catch (e) {
      DioError error = e as DioError;
      print(e.response);
    }
  }

  }



