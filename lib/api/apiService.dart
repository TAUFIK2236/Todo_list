
import 'package:dio/dio.dart';


class IdApiCall{
  final dio = Dio();

  Future httpPost(String url, dynamic data,dynamic header) async {
    final response = await dio.post(url, data: data,options: Options(headers: header,));
      return response.data;}

  Future httpGet(String url,dynamic header) async {
    Response response = await dio.get(url,options: Options(headers: header,));
      return response.data;}


  Future httpDelete(String url,dynamic header) async {
     Response response = await dio.delete(url,options: Options(headers: header,));
      return response.data;
  }

  Future httpUpdate(String url, dynamic data,dynamic header) async{
    Response response = await dio.patch(url,data:data,options: Options(headers:header,));
      return response.data;
  }

  }



