import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/userCheck_model.dart';

class UserCheck_Data{
  static const ROOT = 'https://d-grab.co.kr/user_check.php';
  static  const _GET_USER_CHECK = 'USER_CK';

  static Future<List<User_Ck>> getUserCheck(String user_id) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_USER_CHECK;
      map['user_id'] = user_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getUser_Ck Response: ${response.body}');
      if(200 == response.statusCode){
        List<User_Ck> list = parseResponse(response.body);
        return list;
      }else{
        return List<User_Ck>();
      }
    }catch(e){
      return List<User_Ck>();
    }
  }
  static List<User_Ck> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User_Ck>((json) => User_Ck.fromJson(json)).toList();
  }
}
