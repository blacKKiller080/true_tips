import 'dart:typed_data';

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:true_tips_mobile/core/helper/shared_preferences_helper.dart';

import 'custom_exception.dart';

class ApiClient {
  Future<Map<String, dynamic>> post(String url, dynamic body) async {
    String token = await SharedPreferencesHelper.getToken() ?? "";
    print(url);
    print(body);
    dynamic responseJson;
    try {
      final dynamic response = await http.post(Uri.parse(url),
          body: jsonEncode(body), headers: getHeader(token));
      responseJson = await _response(response);
    } on SocketException catch (e) {
      print(e);
      noInternetConnection();
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> delete(String url, dynamic body) async {
    String token = await SharedPreferencesHelper.getToken() ?? "";
    dynamic responseJson;
    print(url);
    print(body);
    try {
      final dynamic response = await http.delete(Uri.parse(url),
          body: jsonEncode(body), headers: getHeader(token));
      responseJson = await _response(response);
    } on SocketException catch (e) {
      print(e);
      noInternetConnection();
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> patch(String url, dynamic body) async {
    String token = await SharedPreferencesHelper.getToken() ?? "";
    dynamic responseJson;
    try {
      final dynamic response = await http.patch(Uri.parse(url),
          body: jsonEncode(body), headers: getHeader(token));
      responseJson = await _response(response);
    } on SocketException catch (e) {
      print(e);
      noInternetConnection();
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> put(String url, dynamic body,
      {anotherToken}) async {
    String token = await SharedPreferencesHelper.getToken() ?? "";
    dynamic responseJson;
    print(url);
    print(body);
    try {
      final dynamic response = await http.put(Uri.parse(url),
          body: jsonEncode(body), headers: getHeader(token));
      responseJson = await _response(response);
    } on SocketException catch (e) {
      print(e);
      noInternetConnection();
    }
    return responseJson;
  }

  Future<List<Map<String, dynamic>>> postList(String url, dynamic body,
      {anotherToken}) async {
    String token = await SharedPreferencesHelper.getToken() ?? "";

    dynamic responseJson;
    try {
      final dynamic response = await http.post(Uri.parse(url),
          body: body, headers: getHeader(token));
      responseJson = await _response(response);
    } on SocketException {
      noInternetConnection();
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> get(String url,
      {anotherToken, String query = ''}) async {
    dynamic responseJson;
    String token = await SharedPreferencesHelper.getToken() ?? "";
    String fullUrl = url + query;
    print(fullUrl);
    try {
      final dynamic response =
          await http.get(Uri.parse(fullUrl), headers: getHeader(token));
      responseJson = await _response(response);
    } on SocketException {
      noInternetConnection();
    }
    return responseJson;
  }

  noInternetConnection() {
    throw FetchDataException.no();
  }

  Future<List<dynamic>> getList(String url,
      {anotherToken, String query = ''}) async {
    String token = await SharedPreferencesHelper.getToken() ?? "";

    dynamic responseJson;
    try {
      final dynamic response =
          await http.get(Uri.parse(url + query), headers: getHeader(token));
      responseJson = await _response(response);
    } on SocketException {
      throw FetchDataException.no();
    }
    return responseJson;
  }

  Map<String, String> getHeader(String token, {bool isMultipart = false}) {
    return {
      'content-type': isMultipart ? 'multipart/form-data' : 'application/json',
      'accept': 'application/json',
      'Authorization': token.isEmpty ? token : 'Token ' + token,
    };
  }

  Future<Map<String, dynamic>> postMultipart(
      String url, Map<String, MultiPart> body) async {
    String token = await SharedPreferencesHelper.getToken() ?? "";
    dynamic response;
    try {
      ParsedMultiPart parts = await _parseMultiPartBody(body);
      var request = http.MultipartRequest("POST", Uri.parse(url))
        ..fields.addAll(parts.body)
        ..files.addAll(parts.files)
        ..headers.addAll(getHeader(token, isMultipart: true));
      response = await request.send();
      response = await _response(response);
    } on SocketException {
      noInternetConnection();
    }
    return response;
  }

  Future<ParsedMultiPart> _parseMultiPartBody(
      Map<String, MultiPart> body) async {
    Map<String, String> values = Map();
    List<http.MultipartFile> parts = [];
    for (var key in body.keys) {
      MultiPart? part = body[key];
      if (part != null) {
        if (part.value != null) {
          values[key] = part.value;
        } else if (part.file != null) {
          String? mime = lookupMimeType(part.file.path);
          print("FILE MIME_TYPE: $mime");
          Uint8List bytes = await part.file.readAsBytes();
          var _part = http.MultipartFile.fromBytes(
            key,
            bytes,
            contentType: MediaType.parse(mime!),
            filename: part.file.path.split('/').last,
          );
          parts.add(_part);
        }
      }
    }
    return ParsedMultiPart(values, parts);
  }

  dynamic _response(http.BaseResponse response) async {
    dynamic responseJson;
    try {
      var bytes;
      if (response is http.Response) {
        bytes = response.bodyBytes;
      } else if (response is http.StreamedResponse) {
        bytes = await response.stream.toBytes();
      } else {
        throw new UnsupportedError("Response type is unsupported");
      }
      responseJson = bytes.isNotEmpty ? json.decode(utf8.decode(bytes)) : null;
    } on Exception catch (e) {
      print(e);
    }

    switch (response.statusCode) {
      case 201:
      case 200:
        return responseJson;
      case 400:
        throw BadRequestException(responseJson, response.statusCode);
      case 422:
        throw InvalidInputException(responseJson, response.statusCode);
      case 401:
        await SharedPreferencesHelper.removeAll();
        throw UnauthorizedException(responseJson, response.statusCode);
      case 403:
        await SharedPreferencesHelper.removeAll();
        throw UnauthorizedException(responseJson, response.statusCode);
      default:
        throw FetchDataException({
          "error": [
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}'
          ]
        }, 0);
    }
  }
}

class ParsedMultiPart {
  Map<String, String> body;
  List<http.MultipartFile> files;

  ParsedMultiPart(this.body, this.files);

  @override
  String toString() {
    return 'ParsedMultiPart{body: $body, files: $files}';
  }
}

class MultiPart {
  String value;
  File file;

  MultiPart({required this.value, required this.file});

  @override
  String toString() {
    return 'MultiPart{value: $value, file: $file}';
  }
}
