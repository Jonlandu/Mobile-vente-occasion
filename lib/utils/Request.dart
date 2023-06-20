import 'dart:convert';
import 'package:dio/dio.dart' as d;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../apps/MonApplication.dart';
import 'Constantes.dart';

class HttpResponse {
  bool status;
  Map? data;
  String? errorMsg;
  bool? isError;
  bool? isException;

  HttpResponse(
      {this.data,
        required this.status,
        this.errorMsg,
        this.isError,
        this.isException}
      );
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future<dynamic> getData(String url_api, {String? token}) async {
  try {
    var url = Uri.parse("${Constantes.BASE_URL}$url_api");
    var reponse = await http.get(url,
        headers: {
          "Authorization":"Bearer ${token??Constantes.defaultToken}"}).timeout(Duration(seconds: 2)
    );
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
    var tkn = token ?? Constantes.defaultToken;
    var response = await http.patch(url, body: dataStr, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $tkn"
    }).timeout(Duration(seconds: 5));

    var successList = [200, 201];
    var msg = json.decode(response.body);
    var st = successList.contains(response.statusCode);
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

  } catch (e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());

    return HttpResponse(
        status: false,
        errorMsg: "Erreur inattendue, Problème de connexion",
        isException: true); // {"status": st, "msg": msg};
  }
}

Future<dynamic> postDataWithFile(String endpoint,List<String> filenames, {String? token}) async {
  final dio = d.Dio();

  try{
    var url =
        "${Constantes.BASE_URL}$endpoint";
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

Future<dynamic> deleteData(String endpoint, {String? token}) async {
  final dio = d.Dio();

  try {
    final url = "${Constantes.BASE_URL}$endpoint";
    dio.interceptors.add(alice.getDioInterceptor());
    var _tkn = token ?? Constantes.defaultToken;

    final response = await dio.delete(url,
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

Future<dynamic> updateData(String endpoint, Map data, {String? token}) async {
  final dio = d.Dio();

  try{
    final url = "${Constantes.BASE_URL}$endpoint";
    dio.interceptors.add(alice.getDioInterceptor());
    var _tkn = token ?? Constantes.defaultToken;

    String jsonData = json.encode(data);

    final response = await dio.put(url, data: jsonData,
      options: d.Options(
        followRedirects: false,
        contentType: "application/json",
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

Future<dynamic> updateDataWithFile(String endpoint,List<String> filenames, {String? token}) async {
  final dio = d.Dio();

  try{
    var url =
        "${Constantes.BASE_URL}$endpoint";
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

    final response = await dio.put(url, data: formData,
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
/*Future<dynamic> searchArticles(String query) async {
  final dio = d.Dio();
  try{
    final response = await http.get();
    final jsonData = json.decode(response.body) as List<dynamic>;
  }catch(){

  }
}*/
/*setState(() {
    _searchResults = jsonData.map((article) => Article.fromJson(article)).toList();
  });*/
