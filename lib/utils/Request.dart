import 'dart:convert';
import 'dart:developer';
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

    print(reponse.runtimeType);
    print(reponse.body.runtimeType);
    log(reponse.body);
    print(reponse.statusCode);
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
  var url =  Uri.parse(
      "${Constantes.BASE_URL}$endpoint");
  print("C'est le print de l'url ${url}");


  var request = http.MultipartRequest(
      'POST', url
     );
  String _tkn = token ?? Constantes.defaultToken;
  print("Le PRINT DU TOKEN ${_tkn}");
  request.headers.addAll({'Authorization': 'Bearer $_tkn'});
  for (var f in filenames) {
    request.files.add(await http.MultipartFile.fromPath('image', f));
  }

  var res = await request.send();
  var response = await http.Response.fromStream(res);
  alice.onHttpResponse(response);
  print("C'est le print de l'url ${res}");
  if (res.statusCode==200) {
    await res.stream.bytesToString().then((value) => jsonDecode(value));
  }
}
