import 'dart:convert';
import 'dart:io';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as g;
import 'package:go_router/go_router.dart';
import '../../presentation/router/go_router.dart';
import '../../presentation/service/app/app_service.dart';
import '../constants/instances.dart';
import 'package:http/http.dart' as http;

class DioRequestManager {
  final Dio dio;

  final AppService appService = g.Get.find();

  DioRequestManager({required this.dio});

  Future<ApiResponse> send(
    String method,
    Uri url, {
    String token = '',
    final Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    CancelToken? cancelToken,
  }) async {

    Map<String, dynamic>? header = headers.isNotEmpty
        ? headers
        : {
      'Accept': '*/*',
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
      'Authorization': token.isNotEmpty ? 'Bearer $token' : null,
    };
   
    Options options = Options(
      method: method,
      headers: header,
    );

    logger.e('url $url \n cancelToken : $cancelToken');
    logger.i('body ${json.encode(body)}');
    logger.i('token $token');

    try {
      final response = await dio.request(url.toString(),
          options: options, data: json.encode(body), cancelToken: cancelToken);
      logger.e('\n\n\n after request\n\n');

      logger.i('response.data : ${response.data}');

      Map<String, dynamic> map = response.data is String
          ? json.decode(response.data)
          : response.data is Map<String, dynamic>
              ? response.data
              : {};

      ApiResponse apiResponse = ApiResponse(
          body: response.data is String
              ? response.data
              : json.encode(response.data),
          map: map,
          message: map['message'] ?? '',
          data: map['data'] ?? {},
          problems: map['problems'] ?? [],
          statusCode: response.statusCode ?? 0,
          success: [200, 201, 204, 301, 302, 304].contains(response.statusCode),
          result: response.data);

      return apiResponse;
    } on DioException catch (e) {
      logger.e(
          'on DioException : $e with message : ${(e.response?.data != null && e.response?.data is Map && e.response?.data['message'] != null) ? e.response?.data['message'] : 'An error occurred'}');
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        if(e.response?.statusCode != null && e.response!.statusCode == 401){
          appService.redirectUserForTokenExpire();
        }
        if (e.response?.data != null &&
            e.response?.data is Map &&
            e.response?.data['data'] != null) {
          var data = e.response?.data['data'];
          if (data is Map) {
            for (var value in data.values) {
              if (value is List && value.isNotEmpty) {
                errorMessage = value.first;
                break;
              }
            }
          }
        } else {
          errorMessage = e.response?.data['message'] ?? 'An error occurred';
        }
      }

      return ApiResponse(
        body: e.response.toString(),
        map: {},
        message: errorMessage,
        data: {},
        problems: [],
        statusCode: e.response?.statusCode ?? 0,
        success: false,
      );
    }
  }

  Future<ApiResponse> sendMultipart(
    String method,
    Uri url,
    List<FileDetails> files, {
    String fileField = 'file',
    String fileFieldList = 'file',
    List<File> filesList = const [],
    String token = '',
    final Map<String, String> headers = const {},
    Map<String, String> fields = const {},
  }) async {

    Map<String, dynamic>? header = headers.isNotEmpty
        ? headers
        : {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };
    
    Options options = Options(
      method: method,
      headers: header
    );

    FormData formData = FormData();

    // Add files
    for (var fileDetails in files) {
      formData.files.add(
        MapEntry(
          fileField,
          MultipartFile.fromFileSync(
            fileDetails.path,
            // contentType: MediaType.parse(fileDetails.mimeType),
          ),
        ),
      );
    }

    // Add files list
    for (var file in filesList) {
      formData.files.add(
        MapEntry(
          fileFieldList,
          MultipartFile.fromFileSync(
            file.path,
            // contentType: MediaType.parse(lookupMimeType(file.path) ?? 'image/jpeg'),
          ),
        ),
      );
    }

    // Add fields
    formData.fields.addAll(fields.entries);

    logger.i('form data $formData}');
    logger.i('token $token');

    try {
      final response = await dio.request(
        url.toString(),
        options: options,
        data: formData,
      );

      logger.i(response.data);

      Map<String, dynamic> map = response.data is String
          ? json.decode(response.data)
          : response.data is Map<String, dynamic>
              ? response.data
              : {};

      ApiResponse apiResponse = ApiResponse(
        body: response.data is String
            ? response.data
            : json.encode(response.data),
        map: map,
        message: map['message'] ?? '',
        data: map['data'] ?? {},
        problems: map['problems'] ?? [],
        statusCode: response.statusCode ?? 0,
        success: [200, 201, 204, 301, 302, 304].contains(response.statusCode),
        result: response.data,
      );

      return apiResponse;
    } on DioException catch (e) {
      debugPrint('\n \n error msg : ${e.response?.statusMessage}');
      if (e.response != null) {
        if(e.response?.statusCode != null && e.response!.statusCode == 401){
          appService.redirectUserForTokenExpire();
        }
        return ApiResponse(
          body: e.response.toString(),
          map: {},
          message: (e.response?.data != null &&
                  e.response?.data is Map &&
                  e.response?.data['message'] != null)
              ? e.response?.data['message']
              : 'An error occurred',
          data: {},
          problems: [],
          statusCode: e.response?.statusCode ?? 0,
          success: false,
        );
      } else {
        return ApiResponse(
          body: e.message ?? '',
          map: {},
          message: e.message ?? '',
          data: {},
          problems: [],
          statusCode: 0,
          success: false,
        );
      }
    }
  }
}

class HttpRequestManager {
  final http.Client client;

  HttpRequestManager(this.client);

  Future<ApiResponse> send(
    String method,
    Uri url, {
    String token = '',
    final Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
  }) async {
    Map<String, String> reqHeaders = {};

    if (headers.isNotEmpty) {
      reqHeaders.addAll(headers);
    }

    if (headers.isEmpty) {
      reqHeaders.addAll({
        'Accept': '/',
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
    }

    var request = http.Request(method, url);

    // Set headers
    request.headers.addAll(reqHeaders);

    // Set body
    request.body = json.encode(body);

    http.StreamedResponse response = await client.send(request);

    final String bodyRes = await response.stream.bytesToString();
    final int code = response.statusCode;

    logger.i(response.statusCode);
    logger.i(bodyRes);

    Map<String, dynamic> map = json.decode(bodyRes);

    ApiResponse apiResponse = ApiResponse(
        body: bodyRes,
        map: map,
        message: map['message'] ?? '',
        data: map['data'] ?? {},
        problems: map['problems'] ?? [],
        statusCode: code,
        success: map['success'] ?? false);

    return apiResponse;
  }

  Future<ApiResponse> sendMultipart(
      String method, Uri url, List<FileDetails> files,
      {String token = '',
      final Map<String, String> headers = const {},
      Map<String, String> fields = const {},
      String? fieldFile}) async {
    Map<String, String> reqHeaders = {};

    if (headers.isNotEmpty) {
      reqHeaders.addAll(headers);
    }

    if (headers.isEmpty) {
      reqHeaders.addAll({
        'Accept': '/',
        'Access-Control-Allow-Origin': '*',
        'Accept-Language': prefs.getString('languageCode')!,
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });
    }

    var request = http.MultipartRequest(method, url);

    for (var file in files) {
      request.files.add(
        await http.MultipartFile.fromPath(
          fieldFile ?? 'files', file.path,
          // contentType: MediaType.parse(file.mimeType)
        ),
      );
    }

    logger.i(request.files.first.field);

    // Set headers
    request.headers.addAll(reqHeaders);

    Map<String, String> mapFields = {};

    mapFields.addAll(fields);

    List<String> nullKeys = [];

    for (var entry in mapFields.entries) {
      if (entry.value == 'null') {
        nullKeys.add(entry.key);
      }
    }

    mapFields.removeWhere((key, value) => nullKeys.contains(key));

    // Set fields
    logger.e(mapFields);
    request.fields.addAll(mapFields);

    logger.e(request.headers);

    http.StreamedResponse response = await client.send(request);

    final String bodyRes = await response.stream.bytesToString();
    final int code = response.statusCode;

    Map<String, dynamic> map = json.decode(bodyRes);

    logger.i(response.statusCode);
    logger.i(bodyRes);

    ApiResponse apiResponse = ApiResponse(
      body: bodyRes,
      map: map,
      message: map['message'],
      data: map['data'],
      problems: map['problems'],
      statusCode: code,
      success: map['success'] ?? false,
    );

    return apiResponse;
  }
}

class ApiResponse {
  String body;
  Map<String, dynamic> map;
  dynamic message;
  dynamic data;
  List<dynamic> problems;
  int statusCode;
  bool success;
  dynamic result;

  ApiResponse(
      {required this.body,
      required this.map,
      required this.message,
      required this.data,
      this.problems = const [],
      required this.statusCode,
      required this.success,
      this.result});
}

class FileDetails {
  final String path;
  final String mimeType;

  FileDetails(this.path, this.mimeType);
}
