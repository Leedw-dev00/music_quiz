class User_Ck{
  String user_id;
  String stage;
  String temp_point;

  User_Ck({this.user_id, this.stage, this.temp_point});

  factory User_Ck.fromJson(Map<String, dynamic> json){
    return User_Ck(
      user_id: json['user_id'] as String,
      stage: json['stage'] as String,
      temp_point: json['temp_point'] as String
    );
  }
}