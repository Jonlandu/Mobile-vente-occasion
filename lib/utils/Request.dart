import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:squelette_mobile_parcours/utils/Constantes.dart';

class HttpResponse {
  bool status;
  Map? data;
  String? errorMsg;
  bool? isException;

  HttpResponse(
      {this.data, required this.status, this.errorMsg, this.isException});
}

Future<dynamic> getData(String url_api, {String? token}) async {
  try {
    var url = Uri.parse('${Constantes.BASE_URL}$url_api');
    var tkn = token ?? Constantes.DefaultToken;
    var reponse = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $tkn"
    }).timeout(Duration(seconds: 5));

    if (reponse.statusCode == 200) {
      return jsonDecode(reponse.body);
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
    String dataStr = json.encode(data);
    var tkn = token ?? Constantes.DefaultToken;
    var response = await http.post(url, body: dataStr, headers: {
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

Future<HttpResponse> patchData(String api_url, Map data, {String? token}) async {
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