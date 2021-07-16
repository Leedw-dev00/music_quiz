import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quiz_model.dart';

class Quiz_Data{
  static const ROOT = 'https://quanlijing.cafe24.com/quiz.php';
  static const _GET_QUIZ_ACTION = 'GET_QUIZ';

  static Future<List<Quiz>> getQuiz() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_QUIZ_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getQuiz Response: ${response.body}');
      if(200 == response.statusCode){
        List<Quiz> list = parseResponse(response.body);
        return list;
      }else{
        return List<Quiz>();
      }
    }catch(e){
      return List<Quiz>();
    }
  }
  static List<Quiz> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Quiz>((json) => Quiz.fromJson(json)).toList();
  }
}