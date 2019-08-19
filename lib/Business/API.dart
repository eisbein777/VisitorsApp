import 'dart:async';
import 'dart:io';
import 'package:fitzroy_visitors/Dto/Visitor.dart';
import 'package:http/http.dart' as http;
import 'package:fitzroy_visitors/Dto/User.dart';
import 'dart:convert';

const baseUrl = "http://172.16.41.239:45455/api";
var users = new List<User>();

class API {
  static Future getUsers() {
    var url = baseUrl + "/GetAdUsers";
    return http.get(url);
  }

  static Future getvisitorsforsignout() {
    var url = baseUrl + "/GetVisitorsForSignout";
    return http.get(url);
  }


  static Future<List<String>> getSuggestions(String searchstr) async {
    var apiusers = await getUsers();
    Iterable list = json.decode(apiusers);
    users = list.map((model) => User.fromJson(model)).toList();

    List<String> firstnames = users.map((users) => users.firstname).toList();
    firstnames = firstnames.take(3);

    return firstnames;
  }

  static Future<void> saveVisistor(Visitor vis) async {
    var url = baseUrl + "/SaveNewVisistor";

    var response = await http.post(url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: json.encode(vis));

    return;
  }
}
