import 'package:http/http.dart' as http;

class Delete_User {
  static const ROOT = 'https://d-grab.co.kr/delete_user.php';
  static const _DELETE_USER_ACTION = 'DELETE_USER';

  static Future<String> deleteUser(String user_id) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_USER_ACTION;
      map['user_id'] = user_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('deleteUser Response: ${response.body}');
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