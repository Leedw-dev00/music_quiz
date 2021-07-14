import 'package:http/http.dart' as http;

class UpdateStage{
  static const ROOT = "https://d-grab.co.kr/updateStage.php";
  static const _UPDATE_STAGE_ACTION = 'UPDATE_STAGE';


  static Future<String> updateStage(String formatted, String user_id) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_STAGE_ACTION;
      map['formatted'] = formatted;
      map['user_id'] = user_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('updateStage Response: ${response.body}');
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