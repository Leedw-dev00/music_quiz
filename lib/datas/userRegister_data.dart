import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRegister_Data{
  static const ROOT = 'https://d-grab.co.kr/user_register.php';
  static const _ADD_USER_ACTION = 'ADD_USER';

  static Future<String> addUser(String user_id) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_USER_ACTION;
      map['user_id'] = user_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('addUser Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }
}