import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/rank_model.dart';

class Rank_Data{
  static const ROOT = 'https://d-grab.co.kr/rank_point.php';
  static const _GET_RANK_POINT = 'RANK_POINT';

  static Future<List<Rank>> getRank() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_RANK_POINT;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getRank Response ${response.body}');
      if(200 == response.statusCode){
        List<Rank> list = parseResponse(response.body);
        return list;
      }else{
        return List<Rank>();
      }
    }catch(e){
      return List<Rank>();
    }
  }
  static List<Rank> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Rank>((json) => Rank.fromJson(json)).toList();
  }
}