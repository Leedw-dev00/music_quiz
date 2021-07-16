import 'package:http/http.dart' as http;

class Point_Data{
  static const ROOT = 'https://quanlijing.cafe24.com/pointAdd.php';
  static const _ADD_POINT = 'ADD_POINT';

  static Future<String> addPoint(String user_id, String point) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_POINT;
      map['user_id'] = user_id;
      map['point'] = point;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('addPoint Response: ${response.body}');
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