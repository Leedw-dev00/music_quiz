class User_Ck{
  String user_id;
  String stage;
  String formatted;

  User_Ck({this.user_id, this.stage, this.formatted});

  factory User_Ck.fromJson(Map<String, dynamic> json){
    return User_Ck(
      user_id: json['user_id'] as String,
      stage: json['stage'] as String,
        formatted: json['formatted'] as String
    );
  }
}