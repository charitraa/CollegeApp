import 'dart:io';

abstract class BaseApiServices{
  Future<dynamic> getApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url,dynamic body);
  Future<dynamic> getDeleteApiResponse(String url);
  Future<dynamic> putUrlResponse(String url);
  Future<dynamic> postFile(
      String url, File file);
  Future<dynamic> postBanner(
      String url, File file);
  Future<dynamic> getPutResponse(String url, dynamic data);
  Future<dynamic> postMultipartResponse(
      String url, Map<String, dynamic> fields, File file);
  Future<dynamic> postKycResponse(
      String url, Map<String, dynamic> fields, Map<String, File?> file);
  Future<dynamic> postForm(
      String url, Map<String, dynamic> fields);
  Future<dynamic> putMultipartResponse(
      String url, File files);
  Future<dynamic> postUrlResponse(String url);

}