import 'package:http/http.dart' as http;


class RankDelete_Data{
  static const ROOT = 'https://quanlijing.cafe24.com/deleteRank.php';
  static const _DELETE_RANK_POINT = 'DELETE_RANK';

  static Future<String> deleteRank() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_RANK_POINT;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('deleteRank Response: ${response.body}');
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