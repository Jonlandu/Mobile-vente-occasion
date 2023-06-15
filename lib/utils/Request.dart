import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as d;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../apps/MonApplication.dart';
import 'Constantes.dart';

class HttpResponse {
  bool status;
  Map? data;
  String? errorMsg;
  bool? isException;

  HttpResponse(

      {this.data,
      required this.status,
      this.errorMsg,
      this.isException});
}

void printWrapped(String text) {
  print('===');
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future<dynamic> getData(String url_api, {String? token}) async {
  try {

    var url = Uri.parse("${Constantes.BASE_URL}$url_api");
    print("Données de l'URL : ${url}");

    var reponse = await http.get(url, headers: {"Authorization":"Bearer ${token??Constantes.defaultToken}"}).timeout(Duration(seconds: 2));
    if (reponse.statusCode == 200) {
      return json.decode(reponse.body);
    }
    return null;
  } catch (e, trace) {
    print(e.toString());
    print(trace.toString());
    return null;
  }
}

Future<HttpResponse> patchData(String api_url, Map data,
    {String? token}) async {
  try {
    var url = Uri.parse("${Constantes.BASE_URL}$api_url");
    String dataStr = json.encode(data);
    var tkn = token ?? Constantes.DefaultToken;
    var response = await http.patch(url, body: dataStr, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $tkn"
    }).timeout(Duration(seconds: 5));
    var successList = [200, 201];
    var msg = json.decode(response.body);
    var st = successList.contains(response.statusCode);
    print("url:${url}");

    return HttpResponse(status: st, data: msg);
  } catch (e, trace) {
    print(e.toString());
    print(trace.toString());

    return HttpResponse(
        status: false, errorMsg: "Erreur inattendue", isException: true);
  }
}

Future<HttpResponse> postData(String api_url, Map data, {String? token}) async {
  try {
    var url = Uri.parse("${Constantes.BASE_URL}$api_url");
    print("url===== $url");
    String dataStr = json.encode(data);
    var _tkn = token ?? Constantes.defaultToken;

    var response = await http.post(url, body: dataStr, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_tkn"
    }).timeout(Duration(seconds: 2));
    if(!kReleaseMode){
      alice.onHttpResponse(response);
    }

    var successList = [200, 201];
    var msg = json.decode(response.body);
    var st = successList.contains(response.statusCode);
    if (response.statusCode == 500) throw Exception(msg);

    return HttpResponse(status: st, data: msg); // {"status": st, "msg": msg};
    // return null;
  } catch (e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());
    // return null;
    //return {"status": false, "error_msg": };
    return HttpResponse(
        status: false,
        errorMsg: "Erreur inattendue, Problème de connexion",
        isException: true); // {"status": st, "msg": msg};
  }
}

Future<dynamic> postDataWithFile(String endpoint,List<String> filenames, {String? token}) async {
  try{
    var url =
        "${Constantes.BASE_URL}$endpoint";
    final dio = d.Dio();
    dio.interceptors.add(alice.getDioInterceptor());
    String _tkn = token ?? Constantes.defaultToken;
    var files=[];
    var Splitedelement = "";
    for (var f in filenames) {
      var elt = f.split('/');
      Splitedelement = elt.last;
      files.add(await d.MultipartFile.fromFile( f, filename:Splitedelement ));
    }
    final formData = d.FormData.fromMap({
      // 'name': 'dio',
      // 'date': DateTime.now().toIso8601String(),
      //'file': await d.MultipartFile.fromFile( , filename: 'upload.txt'),
      'image_path[]': files
    });
    final response = await dio.post(url, data: formData,
      options: d.Options(
        followRedirects: false,
        contentType: "application/x-www-form-urlencoded",
        headers: {
          'Authorization':'Bearer $_tkn',
          "Accept" : "application/json"
        },
      ),
    );
    var successList = [200, 201];
    var msg = json.decode(response.data);
    var st = successList.contains(response.statusCode);
    if (response.statusCode == 500) throw Exception(msg);

    return HttpResponse(status: st, data: msg); // {"status": st, "m
  }catch(e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());
    return HttpResponse(
        status: false,
        errorMsg: "Erreur inattendue, Problème de connexion",
        isException: true
    ); // {"status": st, "msg": msg};{
  }
}

Future<dynamic> deleteArticle(String articleId, String endpoint, {String? token}) async {
  try {
    final url = 'https://example.com/api/articles/$articleId';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // Handle error
    }
  }catch(e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());
    return HttpResponse(
        status: false,
        errorMsg: "Erreur inattendue, Problème de connexion",
        isException: true
    ); // {"status": st, "msg": msg};{
  }
}
